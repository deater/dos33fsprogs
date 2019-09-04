/* Convert a 40x96 image into two, 40x48 images suitable of loading */
/* with my kfest18 based code */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <png.h>

#include "loadpng.h"
#include "rle_common.h"

/* Converts a PNG to RLE compressed data */

int main(int argc, char **argv) {

	unsigned char *image;
	int xsize,ysize;
	int size=0;
	int out_type=OUTPUT_C;
	char output_name[BUFSIZ];

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s type INFILE varname\n\n",argv[0]);
		fprintf(stderr,"\ttype: c or asm\n");
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

	if (loadpng(argv[2],&image,&xsize,&ysize,PNG_ODDLINES)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	sprintf(output_name,"%s_low",argv[3]);
	size=rle_smaller(out_type,output_name,
		xsize,ysize,image);

	fprintf(stderr,"Size %d bytes\n",size);

	if (loadpng(argv[2],&image,&xsize,&ysize,PNG_EVENLINES)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	sprintf(output_name,"%s_high",argv[3]);
	size=rle_smaller(out_type,output_name,
		xsize,ysize,image);

	fprintf(stderr,"Size %d bytes\n",size);


	return 0;
}







