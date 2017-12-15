#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

#define OUTPUT_C	0
#define OUTPUT_ASM	1

/* Converts a PNG to RLE compressed data */

int rle_original(int out_type, char *varname,
		int xsize,int ysize, unsigned char *image) {

	int run=0;
	int x;

	int last=-1,next;
	int size=0;
	int count=0;

	x=0;

	/* Write out xsize and ysize */

	if (out_type==OUTPUT_C) {
		fprintf(stdout,"unsigned char %s[]={\n",varname);
		fprintf(stdout,"\t0x%X,0x%X,",xsize,ysize);
	}
	else {
		fprintf(stdout,"%s:",varname);
		fprintf(stdout,"\t.byte $%X,$%X",xsize,ysize);
	}

	size+=2;

	/* Get first top/bottom color pair */
	last=image[x];
	run++;
	x++;

	while(1) {

		/* get next top/bottom color pair */
		next=image[x];

//		printf("x=%d, next=%x image[%d]=%x\n",
//			x,next,
//			x,image[x]);


		/* If color change (or too big) then output our run */
		/* Note 0xff for run length is special case meaning "finished" */
		if ((next!=last) || (run>253)) {
			if (out_type==OUTPUT_C) {
				if (count==0) {
					printf("\n\t");
				}
				printf("0x%02X,0x%02X, ",run,last);
			}
			else {
				if (count==0) {
					printf("\n\t.byte ");
				}
				else {
					printf(", ");
				}
				printf("$%02X,$%02X",run,last);
			}
			count++;

			size+=2;
			run=0;
			last=next;
		}

		x++;

		/* Split up per-line */
//		enough++;
//		if (enough>=xsize) {
//			enough=0;
//			fprintf(stdout,"\n");
//		}

		/* If we reach the end */
		if (x>=xsize*(ysize/2)) {
			run++;
			/* print tailing value */
			if (run!=0) {
				if (out_type==OUTPUT_C) {
					printf("0x%02X,0x%02X, ",run,last);
				}
				else {
					if (count==0) {
						printf("\n\t.byte ");
					}
					else {
						printf(", ");
					}
					printf("$%02X,$%02X\n",run,last);
				}
				size+=2;
			}
			break;
		}

		run++;
		if (count>6) count=0;

	}

	/* Print closing marker */

	if (out_type==OUTPUT_C) {
		fprintf(stdout,"0xFF,0xFF,");
		fprintf(stdout,"\t};\n");
	} else {
		fprintf(stdout,"\t.byte $FF,$FF\n");
	}

	size+=2;

	return size;
}



/* Converts a PNG to RLE compressed data */

int main(int argc, char **argv) {

	unsigned char *image;
	int xsize,ysize;
	int size=0;
	int out_type=OUTPUT_C;

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s type INFILE varname\n\n",argv[0]);
		exit(-1);
	}

	if (!strcmp(argv[1],"c")) {
		out_type=OUTPUT_C;
	}
	else if (!strcmp(argv[1],"asm")) {
		out_type=OUTPUT_ASM;
	}

	if (loadpng(argv[2],&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	size=rle_original(out_type,argv[3],
		xsize,ysize,image);

	fprintf(stderr,"Size %d bytes\n",size);

	return 0;
}




