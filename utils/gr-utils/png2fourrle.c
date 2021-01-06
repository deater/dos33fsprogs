#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

static int offset=0;

static int print_byte(int byte) {

	if (offset%16==0) {
		printf(".byte\t");
	}
	else {
		printf(",");
	}

	printf("$%02X",byte);
	offset++;

	if (offset%16==0) {
		printf("\n");
	}
	else {

	}

	return 0;
}

static int print_rle(int color, int run) {

	int ret=0;

	if ((color&0xf)!=((color>>4)&0xf)) {
		fprintf(stderr,"color not match! %x\n",color);
		ret=1;
	}
	if (run>255) {
		fprintf(stderr,"Run too big %x\n",run);
		ret=1;
	}

	if (run<=14) {
		print_byte((run<<4)|(color&0xf));
	}
	else {
		print_byte((15<<4)|(color&0xf));
		print_byte(run);
	}


	return ret;
}

/* Converts a PNG to 4/4 RLE encoding */

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int color=0,oldcolor=0;
	int run=0;

	unsigned char *image;
	int xsize,ysize;

	if (argc<2) {
		fprintf(stderr,"Usage:\t%s INFILE\n\n",argv[0]);
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	oldcolor=image[0];
	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			color=image[row*xsize+col];
			if (color!=oldcolor) {
				if (print_rle(oldcolor,run)) {
					fprintf(stderr,"at %d, %d\n",col,row);
				}
				oldcolor=color;
				run=0;
			}
			if (run>254) {
				if (print_rle(oldcolor,run)) {
					fprintf(stderr,"at %d, %d\n",col,row);
				}
				oldcolor=color;
				run=0;
			}

			run++;
		}
	}
	print_rle(oldcolor,run);

	/* terminate */
	print_rle(0,0);

	printf("\n");

	return 0;
}
