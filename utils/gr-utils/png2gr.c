#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

/* Converts a PNG to a GR file you can BLOAD to 0x400		*/
/* HOWEVER you *never* want to do this in real life		*/
/* as it will clobber important values in the memory holes	*/

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int x;
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

	short gr_offsets[]={
		0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
		0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
		0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
	};

	memset(out_buffer,0,1024);
	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			out_buffer[(gr_offsets[row]-0x400)+col]=image[row*xsize+col];
		}
	}

	for(x=0;x<1024;x++) fputc( out_buffer[x],outfile);

	fclose(outfile);

	return 0;
}
