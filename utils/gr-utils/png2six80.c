#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

/* Converts a PNG to a shifted 6 bitmap */
/* for 80 column mode */

int main(int argc, char **argv) {

	int row=0;
	int col=0;

	unsigned char ch;

	unsigned char *image;
	int xsize,ysize;

	if (argc<2) {
		fprintf(stderr,"Usage:\t%s INFILE\n\n",argv[0]);
		exit(-1);
	}

	if (loadpng80(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	ch=0;
	for(row=0;row<12;row++) {
		for(col=0;col<80;col++) {
			if (image[row*xsize+col]) {
				ch|=1<<5;
			}
			if ((row*xsize+col)%6==5) {
				printf("%c",ch+32);
				ch=0;
			}
			else {
				ch>>=1;
			}
		}
	}

	printf("\n");

	return 0;
}
