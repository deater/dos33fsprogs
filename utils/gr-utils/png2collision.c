/* png2collision */

/* takes png file and generates the 240 byte table lookup info */
/* for collision of sprites in the Peasant's Quest game */
/* a color of 0 indicates there should be a collision */

/* data organized in 6 rows of 40 bytes */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"


//static short gr_offsets[]={
//	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
//	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
//	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
//};



/* Converts a PNG to a GR file you can BLOAD to 0x400		*/
/* HOWEVER you *never* want to do this in real life		*/
/* as it will clobber important values in the memory holes	*/

int main(int argc, char **argv) {

	int row=0;
	int col=0;
//	int x;
	unsigned char out_buffer[1024];

	unsigned char *image;
	int xsize,ysize;
	FILE *outfile;

	if (argc<3) {
		fprintf(stderr,"Usage:\t%s INFILE OUTFILE\n\n",argv[0]);
		exit(-1);
	}

	outfile=fopen(argv[2],"w");
	if (outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",argv[2]);
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);


	memset(out_buffer,0,240);

	int temp_byte;

	for(row=0;row<6;row++) {
		for(col=0;col<40;col++) {
			temp_byte=0;
			if ((image[((row*4)+0)*xsize+col]&0xf)==0) temp_byte|=0x80;
			if (((image[((row*4)+0)*xsize+col]>>4)&0xf)==0) temp_byte|=0x40;

			if ((image[((row*4)+1)*xsize+col]&0xf)==0) temp_byte|=0x20;
			if (((image[((row*4)+1)*xsize+col]>>4)&0xf)==0) temp_byte|=0x10;

			if ((image[((row*4)+2)*xsize+col]&0xf)==0) temp_byte|=0x08;
			if (((image[((row*4)+2)*xsize+col]>>4)&0xf)==0) temp_byte|=0x04;

			if ((image[((row*4)+3)*xsize+col]&0xf)==0) temp_byte|=0x02;
			if (((image[((row*4)+3)*xsize+col]>>4)&0xf)==0) temp_byte|=0x01;

			fputc( temp_byte,outfile);
		}
	}

	fclose(outfile);

	return 0;
}
