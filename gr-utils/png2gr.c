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
	int enough=0;
	int x;

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

	if (loadpng(argv[1],&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	printf("Loaded image %d by %d\n",xsize,ysize);

	x=0;
	while(1) {
		fputc( image[col+(row*xsize)] |
			(image[col+(row+1)*xsize]<<4),outfile);
		x++;
		if (x>0x3f8) break;
		enough++;
		if (enough>119) {
			/* screen hole */
			/* We should never BLOAD this image */
			/* as we can corrupt important state here */
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			enough=0;
		}

		col++;
		if (col>39) {
			col=0;
			row+=16;
			if (row>47) row-=46;
		}
	}

	fclose(outfile);

	return 0;
}
