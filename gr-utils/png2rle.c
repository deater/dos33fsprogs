#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"
#include "rle_common.h"



/*****************************************/
/* \/                                 \/ */
/* Converts a PNG to RLE compressed data */
/*****************************************/



/* Converts a PNG to RLE compressed data */

int main(int argc, char **argv) {

	unsigned char *image;
	int xsize,ysize;
	int size=0;
	int out_type=OUTPUT_C;

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s type INFILE varname\n\n",argv[0]);
		fprintf(stderr,"\ttype: c or asm or raw\n");
		fprintf(stderr,"\tvarname: label for graphic\n");
		fprintf(stderr,"\n");

		exit(-1);
	}

	if (!strcmp(argv[1],"c")) {
		out_type=OUTPUT_C;
	}
	else if (!strcmp(argv[1],"asm")) {
		out_type=OUTPUT_ASM;
	}
	else if (!strcmp(argv[1],"raw")) {
		out_type=OUTPUT_RAW;
	}

	if (loadpng(argv[2],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

//	size=rle_original(out_type,argv[3],
//		xsize,ysize,image);

	size=rle_smaller(out_type,argv[3],
		xsize,ysize,image);

	fprintf(stderr,"Size %d bytes\n",size);

	return 0;
}




