#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

/* Converts a PNG to RLE compressed data */

int main(int argc, char **argv) {

	int enough=0,run=0;
	int x;

	unsigned char *image;
	int xsize,ysize,last=-1,next;
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

	if (loadpng(argv[1],&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	printf("Loaded image %d by %d\n",xsize,ysize);

	x=0;
	enough=0;
	fprintf(outfile,"0x%X,0x%x,\n",xsize,ysize);
	last=image[x] | (image[x+xsize]<<4);
	run++;
	x++;
	while(1) {
		next=image[x] | (image[x+xsize]<<4);

		if (next!=last) {
			fprintf(outfile,"0x%02X,0x%02X,\n",run,last);
			run=0;
			last=next;
		}

		run++;


		x++;
		enough++;
		if (enough>=xsize) {
			enough=0;
			x+=xsize;
			fprintf(outfile," ");
		}


		if (x>xsize*ysize) break;
	}

	fclose(outfile);

	return 0;
}
