/* Convert 80x48 png image to two files to be loaded as Apple II DGR */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"


static short gr_offsets[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

/* in even colors in AUX mem the colors are rotated right by one */
/* for some reason */
static unsigned char aux_colors[]={
	 0,	/* 0000 -> 0000 */
	 8,	/* 0001 -> 1000 */
	 1,	/* 0010 -> 0001 */
	 9,	/* 0011 -> 1001 */
	 2,	/* 0100 -> 0010 */
	10,	/* 0101 -> 1010 */
	 3,	/* 0110 -> 0011 */
	11,	/* 0111 -> 1011 */
	 4,	/* 1000 -> 0100 */
	12,	/* 1001 -> 1100 */
	 5,	/* 1010 -> 0101 */
	13,	/* 1011 -> 1101 */
	 6,	/* 1100 -> 0110 */
	14,	/* 1101 -> 1110 */
	 7,	/* 1110 -> 0111 */
	15	/* 1111 -> 1111 */
};
/* Converts a PNG to a GR file you can BLOAD to 0x400		*/
/* HOWEVER you *never* want to do this in real life		*/
/* as it will clobber important values in the memory holes	*/

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int x;
	int temp_low,temp_high,temp_color;

	unsigned char aux_buffer[1024];
	unsigned char main_buffer[1024];

	unsigned char *image;
	int xsize,ysize;
	FILE *aux_outfile;
	FILE *main_outfile;

	char aux_filename[BUFSIZ];
	char main_filename[BUFSIZ];


	if (argc<3) {
		fprintf(stderr,"Usage:\t%s INFILE OUTFILE_BASE\n\n",argv[0]);
		exit(-1);
	}

	sprintf(aux_filename,"%s.aux",argv[2]);
	sprintf(main_filename,"%s.main",argv[2]);

	aux_outfile=fopen(aux_filename,"w");
	if (aux_outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",aux_filename);
		exit(-1);
	}

	main_outfile=fopen(main_filename,"w");
	if (main_outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",main_filename);
		exit(-1);
	}


	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_NO_ADJUST)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	memset(main_buffer,0,1024);
	memset(aux_buffer,0,1024);

	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			/* note, the aux bytes are rotated right by 1 (!?) */
			temp_low=(image[row*xsize+(col*2)])&0xf;
			temp_high=(image[row*xsize+(col*2)]>>4)&0xf;
			temp_color=(aux_colors[temp_high]<<4)|
					(aux_colors[temp_low]);

			aux_buffer[(gr_offsets[row]-0x400)+col]=temp_color;
			main_buffer[(gr_offsets[row]-0x400)+col]=
						image[row*xsize+(col*2)+1];
		}
	}

	for(x=0;x<1024;x++) fputc( aux_buffer[x],aux_outfile);
	for(x=0;x<1024;x++) fputc( main_buffer[x],main_outfile);

	fclose(aux_outfile);
	fclose(main_outfile);

	return 0;
}
