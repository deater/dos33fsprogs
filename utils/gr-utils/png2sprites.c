/* png2sprites */

/* take a png image and generate sprites */

/* they will be in the format */
/* label:            */
/* .byte xsize,ysize */
/* .byte line0data   */
/* ...               */
/* .byte lineNdata   */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int pixel;
	int sprite_x, sprite_y, sprite_xsize, sprite_ysize;

	unsigned char *image;
	int xsize,ysize;

	if (argc<6) {
		fprintf(stderr,"Usage:\t%s INFILE label x y xsize ysize\n\n",argv[0]);
		exit(-1);
	}

	sprite_x=atoi(argv[3]);
	sprite_y=atoi(argv[4]);

	sprite_xsize=atoi(argv[5]);
	sprite_ysize=atoi(argv[6]);

	if ((sprite_x>40) || (sprite_y>48)) {
		fprintf(stderr,"Error!  %d %d for sprite x,y out of bounds!\n",
			sprite_x,sprite_y);
		exit(-1);
	}

	if ((sprite_x+sprite_xsize>40) || (sprite_y+sprite_ysize>48)) {
		fprintf(stderr,"Error!  %d %d for sprite x,y out of bounds!\n",
			sprite_x+sprite_xsize,sprite_y+sprite_ysize);
		exit(-1);
	}

	if ( ((sprite_y%2)!=0) || ((sprite_y+sprite_ysize)%2!=0)) {
		fprintf(stderr,"Error! Y co-ords need to be a multiple of 2\n");
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	if ((xsize!=40) || (ysize!=48)) {
		fprintf(stderr,"Error!  Must be 80x48!\n");
		exit(1);
	}


	fprintf(stdout,"%s:\n",argv[2]);

	fprintf(stdout,".byte %d,%d\n",sprite_xsize,sprite_ysize/2);

	for(row=sprite_y/2;row<(sprite_y+sprite_ysize)/2;row++) {
		fprintf(stdout,".byte ");
		for(col=sprite_x;col<sprite_x+sprite_xsize;col++) {
			if (col!=sprite_x) fprintf(stdout,",");
			pixel=(image[row*xsize+col]);
			fprintf(stdout,"$%02X",pixel);
		}
		fprintf(stdout,"\n");
	}

	fprintf(stdout,"\n");

	return 0;
}
