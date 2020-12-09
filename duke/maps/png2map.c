#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"


/* converts a png of map to format by our duke engine */

/* 1280x200 image */
/* 256 sprites of size 2x4 in a 16x16 grid at 8,4 */


static unsigned char tiles[256][2][4];

int main(int argc, char **argv) {

	int i,j;
	int numtiles=32;

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


	fprintf(outfile,"tiles:\n");
	for(i=0;i<numtiles;i++) {
		fprintf(outfile,"tile%02x:\t.byte ",i);
		for(j=0;j<4;j++) {
			fprintf(outfile,"$%02x",tiles[i][0][0]);
			if (j!=3) fprintf(outfile,",");
		}
		fprintf(outfile,"\n");
	}

	fprintf(outfile,"\n");

	fclose(outfile);

	return 0;
}
