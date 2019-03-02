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
#define OUTPUT_RAW	2



/*****************************************/
/* \/                                 \/ */
/* Converts a PNG to RLE compressed data */
/*****************************************/


static int print_run(int count, int out_type, int run, int last) {

	int size=0;

	if (count==0) {
		if (out_type==OUTPUT_C) {
			printf("\n\t");
		}
		else if (out_type==OUTPUT_ASM) {
			printf("\n\t.byte ");
		}
	}
	else {
		if (out_type==OUTPUT_C) {
		}
		else if (out_type==OUTPUT_ASM) {
			printf(", ");
		}
	}

	if (run==1) {
		if ((last&0xf0)==0xA0) {
			if (out_type==OUTPUT_C) {
				printf("0x%02X,0x%02X,0x%02X,",0xa0,1,last);
			}
			else if (out_type==OUTPUT_ASM) {
				printf("$%02X,$%02X,$%02X",0xa0,1,last);
			}
			else {
				printf("%c%c%c",0xa0,1,last);
			}
			size+=3;
		}
		else {
			if (out_type==OUTPUT_C) {
				printf("0x%02X,",last);
			}
			else if (out_type==OUTPUT_ASM) {
				printf("$%02X",last);
			}
			else {
				printf("%c",last);
			}
			size++;
		}
	}
	if (run==2) {
		if ((last&0xf0)==0xA0) {
			if (out_type==OUTPUT_C) {
				printf("0x%02X,0x%02X,0x%02X,",0xa0,2,last);
			}
			else if (out_type==OUTPUT_ASM) {
				printf("$%02X,$%02X,$%02X",0xa0,2,last);
			}
			else {
				printf("%c%c%c",0xa0,2,last);
			}
			size+=3;
		}
		else {

			if (out_type==OUTPUT_C) {
				printf("0x%02X,0x%02X,",last,last);
			}
			else if (out_type==OUTPUT_ASM) {
				printf("$%02X,$%02X",last,last);
			}
			else {
				printf("%c",last);
				printf("%c",last);
			}
			size+=2;
		}
	}

	if ((run>2) && (run<16)) {
		if (out_type==OUTPUT_C) {
			printf("0x%02X,0x%02X,",0xA0|run,last);
		}
		else if (out_type==OUTPUT_ASM) {
			printf("$%02X,$%02X",0xA0|run,last);
		}
		else {
			printf("%c",0xA0|run);
			printf("%c",last);
		}
		size+=2;
	}

	if (run>=16) {
		if (out_type==OUTPUT_C) {
			printf("0x%02X,0x%02X,0x%02X,",0xA0,run,last);
		}
		else if (out_type==OUTPUT_ASM) {
			printf("$%02X,$%02X,$%02X",0xA0,run,last);
		}
		else {
			printf("%c",0xA0);
			printf("%c",run);
			printf("%c",last);
		}
		size+=3;
	}

	return size;
}


int rle_smaller(int out_type, char *varname,
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
		fprintf(stdout,"\t0x%X, /* ysize=%d */",xsize,ysize);
	}
	else if (out_type==OUTPUT_ASM) {
		fprintf(stdout,"%s:",varname);
		fprintf(stdout,"\t.byte $%X ; ysize=%d",xsize,ysize);
	} else {
		fprintf(stdout,"%c",xsize);
	}

	size+=2;

	/* Get first top/bottom color pair */
	last=image[x];
	run++;
	x++;

	while(1) {

		/* get next top/bottom color pair */
		next=image[x];

//		if ((next&0xf0)==0xA0) {
//			fprintf(stderr,"Warning! Using color A (grey2)!\n");
//			next&=~0xf0;
//			next|=0x50; // substitute grey1
//		}

		/* If color change (or too big) then output our run */
		if ((next!=last) || (run>254)) {

			size+=print_run(count,out_type,run,last);

			count++;
			run=0;
			last=next;
		}

		x++;

		/* If we reach the end */
		if (x>=xsize*(ysize/2)) {
			run++;

			size+=print_run(count,out_type,run,last);

			break;

		}

		run++;
		if (count>6) count=0;

	}

	/* Print closing marker */

	if (out_type==OUTPUT_C) {
		fprintf(stdout,"0xA1,");
		fprintf(stdout,"\t};\n");
	} else if (out_type==OUTPUT_ASM) {
		fprintf(stdout,"\n\t.byte $A1\n");
	} else {
		fprintf(stdout,"%c",0xA1);
	}

	size+=1;

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

	if (loadpng(argv[2],&image,&xsize,&ysize)<0) {
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
	else if (out_type==OUTPUT_ASM) {
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

		/* If color change (or too big) then output our run */
		/* Note 0xff for run length is special case meaning "finished" */
		if ((next!=last) || (run>253)) {

			/* handle new line */
			if (out_type==OUTPUT_C) {
				if (count==0) {
					printf("\n\t");
				}
			}
			else if (out_type==OUTPUT_ASM) {
				if (count==0) {
					printf("\n\t.byte ");
				}
				else {
					printf(", ");
				}
			}

			if (out_type==OUTPUT_C) {
				printf("0x%02X,0x%02X, ",run,last);
			}
			else if (out_type==OUTPUT_ASM) {
				printf("$%02X,$%02X",run,last);
			}
			else {
				printf("%c",run);
				printf("%c",last);

			}
			size+=2;

			count++;
			run=0;
			last=next;
		}

		x++;

		/* If we reach the end */
		if (x>=xsize*(ysize/2)) {
			run++;
			/* print tailing value */
			if (run!=0) {
				if (out_type==OUTPUT_C) {
					printf("0x%02X,0x%02X, ",run,last);
				}
				else if (out_type==OUTPUT_ASM) {
					if (count==0) {
						printf("\n\t.byte ");
					}
					else {
						printf(", ");
					}
					printf("$%02X,$%02X\n",run,last);
				} else {
					printf("%c",run);
					printf("%c",last);
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
	} else if (out_type==OUTPUT_ASM) {
		fprintf(stdout,"\t.byte $FF,$FF\n");
	}

	size+=2;

	return size;
}
