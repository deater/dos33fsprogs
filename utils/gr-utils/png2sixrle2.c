#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

static int print_rle(int color, int run) {

	int ret=0;

	if ((color&0xf)!=((color>>4)&0xf)) {
		fprintf(stderr,"color not match! %x\n",color);
		ret=1;
	}
	if (run>63) {
		fprintf(stderr,"Run too big %x\n",run);
		ret=1;
	}
	if (run==1) {
		printf("%c",(color&0xf)+16+' ');
	}
	else {
		printf("%c%c",(color&0xf)+' ',run+' ');
//	fprintf(stderr,"c=%x run=%x\n",color,run);
	}
	return ret;
}

/* Converts a PNG to a 6-bit RLE encoding */

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
			if (run>62) {
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
	printf("\n");

	return 0;
}
