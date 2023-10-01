/* box_convert */

/* Try to automate the loser conversion process */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

#include "box_sizes.c"


static char color_names[16][16]={
	"BLACK",	/* $00 */
	"RED",		/* $01 */
	"DARK_BLUE",	/* $02 */
	"MAGENTA",	/* $03 */
	"GREEN",	/* $04 */
	"GREY1",	/* $05 */
	"MEDIUM_BLUE",	/* $06 */
	"LIGHT_BLUE",	/* $07 */
	"BROWN",	/* $08 */
	"ORANGE",	/* $09 */
	"GREY2",	/* $0A */
	"PINK",		/* $0B */
	"LIGHT_GREEN",	/* $0C */
	"YELLOW",	/* $0D */
	"AQUA",		/* $0E */
	"WHITE",	/* $0F */
};


/* SET_COLOR = $C0 */

#define ACTION_END		0x0
#define ACTION_CLEAR		0x1
#define ACTION_BOX		0x2
#define ACTION_HLIN		0x3
#define ACTION_VLIN		0x4
#define ACTION_PLOT		0x5
#define ACTION_HLIN_ADD		0x6
#define ACTION_HLIN_ADD_LSAME	0x7
#define ACTION_HLIN_ADD_RSAME	0x8

#if 0
static char action_names[9][16]={
	"END","CLEAR","BOX","HLIN","VLIN","PLOT",
	"HLIN_ADD","HLIN_ADD_LSAME","HLIN_ADD_RSAME"
};
#endif

#define MAX_PRIMITIVES	4096
static struct {
	int type;
	int color;
	int x1,y1,x2,y2;
} primitive_list[MAX_PRIMITIVES];

static int framebuffer[40][48];
static int background_color=0;

int create_using_plots(void) {

	int current_primitive=0;
	int row,col;

	/* Initial Implementation, All Plots */

	for(row=0;row<48;row++) {
		for(col=0;col<40;col++) {
			primitive_list[current_primitive].color=framebuffer[col][row];
			primitive_list[current_primitive].x1=col;
			primitive_list[current_primitive].y1=row;
			primitive_list[current_primitive].type=ACTION_PLOT;
			current_primitive++;

		}
	}
	return current_primitive;
}


int create_using_hlins(void) {

	int current_primitive=0;
	int row,col,start_x;
	int prev_color;
	int len;

	for(row=0;row<48;row++) {
		prev_color=framebuffer[0][row]; len=0; start_x=0;
		for(col=0;col<40;col++) {
			if (framebuffer[col][row]!=prev_color) {
				primitive_list[current_primitive].color=
					prev_color;
				primitive_list[current_primitive].x1=start_x;
				primitive_list[current_primitive].x2=start_x+len;
				primitive_list[current_primitive].y1=row;
				primitive_list[current_primitive].type=ACTION_HLIN;
				current_primitive++;
				len=0;
				prev_color=framebuffer[col][row];
				start_x=col;
			}
			else {
				len++;
			}

		}
	}
	return current_primitive;
}

int create_using_hlins_by_color(void) {

	int current_primitive=0;
	int row,col,start_x;
	int current_color,prev_color;
	int len;

	for(current_color=0;current_color<16;current_color++) {

	if (current_color==background_color) continue;

	for(row=0;row<48;row++) {
		prev_color=framebuffer[0][row]; len=0; start_x=0;
		for(col=0;col<40;col++) {
			if (framebuffer[col][row]!=prev_color) {
				if (prev_color==current_color) {
				primitive_list[current_primitive].color=
					prev_color;
				primitive_list[current_primitive].x1=start_x;
				primitive_list[current_primitive].x2=start_x+len;
				primitive_list[current_primitive].y1=row;
				primitive_list[current_primitive].type=ACTION_HLIN;
				current_primitive++;
				}
				len=0;
				prev_color=framebuffer[col][row];
				start_x=col;
			}
			else {
				len++;
			}

		}
	}
	}
	return current_primitive;
}


int create_using_boxes(void) {

	int current_primitive=0;
	int row,col,box;
	int current_color;

	for(current_color=0;current_color<16;current_color++) {

	if (current_color==background_color) continue;

	for(box=0;box<NUM_BOX_SIZES;box++) {

	int xx,yy,box_found;

	for(row=0;row<48-box_sizes[box].y;row++) {
		for(col=0;col<40-box_sizes[box].x;col++) {
			box_found=1;
			for(yy=0;yy<box_sizes[box].y;yy++) {
			for(xx=0;xx<box_sizes[box].x;xx++) {

			if (framebuffer[xx+col][yy+row]!=current_color) {
				box_found=0;
				break;
			}
			} // xx
			if (!box_found) break;
			} // yy

			if (box_found) {
				primitive_list[current_primitive].color=
					current_color;
				primitive_list[current_primitive].x1=col;
				primitive_list[current_primitive].x2=col+
					box_sizes[box].x-1;
				primitive_list[current_primitive].y1=row;
				primitive_list[current_primitive].y2=row+
					box_sizes[box].y-1;
				primitive_list[current_primitive].type=ACTION_BOX;
				current_primitive++;
				if (current_primitive>=MAX_PRIMITIVES) {
					fprintf(stderr,"Error!  Too many primitives: %d\n",current_primitive);
					exit(1);
				}
				for(yy=0;yy<box_sizes[box].y;yy++) {
				for(xx=0;xx<box_sizes[box].x;xx++) {
				framebuffer[xx+col][yy+row]=0xff;
				}
				}

			}


		} // col
	}	// row
	}	// box
	}	// current_color
	return current_primitive;
}




int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int pixel;
	int i;

	unsigned char *image;
	int xsize,ysize;

	if (argc<1) {
		fprintf(stderr,"Usage:\t%s INFILE\n",argv[0]);
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	if (ysize!=48) {
		fprintf(stderr,"Error!  Ysize must be 48!\n");
		exit(1);
	}

	if (xsize==40) {

	}
	else if (xsize==80) {

	}
	else {
		fprintf(stderr,"Error!  Improper xsize %d!\n",xsize);
		exit(1);
	}




	int color_count[16];

	int current_color=0;



	int max_primitive=0;
	int previous_primitive=0;
	int total_size=0;

	memset(color_count,0,16*sizeof(int));

	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			pixel=(image[row*40+col]);
			color_count[pixel&0xf]++;
			color_count[(pixel>>4)&0xf]++;
			framebuffer[col][row*2]=pixel&0xf;
			framebuffer[col][(row*2)+1]=(pixel>>4)&0xf;
		}
	}

	/* TODO: sort */
	printf("; Histogram\n");
	for(i=0;i<16;i++) {
		printf("; $%02X %s: %d\n",i,color_names[i],color_count[i]);
	}

//	max_primitive=create_using_hlins();
//	max_primitive=create_using_hlins_by_color();
	max_primitive=create_using_boxes();


	/* Optimize boxes to PLOT/VLIN/HLIN*/
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].type==ACTION_BOX) {
			if ((primitive_list[i].x1==primitive_list[i].x2) &&
				(primitive_list[i].y1==primitive_list[i].y2)) {
				primitive_list[i].type=ACTION_PLOT;
			} else
			if (primitive_list[i].x1==primitive_list[i].x2) {
				primitive_list[i].type=ACTION_VLIN;
			} else
			if (primitive_list[i].y1==primitive_list[i].y2) {
				primitive_list[i].type=ACTION_HLIN;
			}
		}
	}

	/* Optimize HLIN */
	int previous_entry=0,previous_y=0;
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].type==ACTION_HLIN) {
			if ((previous_entry==ACTION_HLIN) &&
				(previous_y==primitive_list[i].y1-1)) {
				primitive_list[i].type=ACTION_HLIN_ADD;
			}
			else
			if ((previous_entry==ACTION_HLIN_ADD) &&
				(previous_y==primitive_list[i].y1-1)) {
				primitive_list[i].type=ACTION_HLIN_ADD;
			}
			else
			if ((previous_entry==ACTION_PLOT) &&
				(previous_y==primitive_list[i].y1-1)) {
				primitive_list[i].type=ACTION_HLIN_ADD;
			}
		}
		previous_entry=primitive_list[i].type;
		previous_y=primitive_list[i].y1;
	}


	/* Dump results */
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].color==0) continue;

		if (current_color!=primitive_list[i].color) {
			printf("\t.byte SET_COLOR | %s\n",
				color_names[primitive_list[i].color]);
			current_color=primitive_list[i].color;
			total_size+=1;
		}

		switch(primitive_list[i].type) {
			case ACTION_END:
					break;
			case ACTION_CLEAR:
					break;
			case ACTION_BOX:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d,%d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1,
						primitive_list[i].x2,
						primitive_list[i].y2);
					total_size+=4;
				}
				else {
					printf("\t.byte BOX,%d,%d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1,
						primitive_list[i].x2,
						primitive_list[i].y2);
					total_size+=5;
					previous_primitive=ACTION_BOX;
				}
					break;
			case ACTION_HLIN:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=3;
				}
				else {
					printf("\t.byte HLIN,%d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=4;
					previous_primitive=ACTION_HLIN;

				}
					break;
			case ACTION_VLIN:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d,%d,%d\n",
						primitive_list[i].y1,
						primitive_list[i].y2,
						primitive_list[i].x1);
					total_size+=3;
				}
				else {
					printf("\t.byte VLIN,%d,%d,%d\n",
						primitive_list[i].y1,
						primitive_list[i].y2,
						primitive_list[i].x1);
					total_size+=4;
					previous_primitive=ACTION_VLIN;

				}
					break;
			case ACTION_PLOT:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1);
					total_size+=2;
				}
				else {
					printf("\t.byte PLOT,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1);
					total_size+=3;
					previous_primitive=ACTION_PLOT;

				}
					break;
			case ACTION_HLIN_ADD:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d,%d\t; %d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=2;
				}
				else {
					printf("\t.byte HLIN_ADD,%d,%d\t; %d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=3;
					previous_primitive=ACTION_HLIN_ADD;

				}
					break;
			case ACTION_HLIN_ADD_LSAME:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d\n",
						primitive_list[i].x2);
					total_size+=1;
				}
				else {
					printf("\t.byte HLIN_ADD_LSAME,%d\n",
						primitive_list[i].x2);
					total_size+=2;
					previous_primitive=ACTION_HLIN_ADD_LSAME;

				}
					break;
			case ACTION_HLIN_ADD_RSAME:
				if (primitive_list[i].type==previous_primitive) {
					printf("\t.byte %d\n",
						primitive_list[i].x1);
					total_size+=1;
				}
				else {
					printf("\t.byte HLIN_ADD_RSAME,%d\n",
						primitive_list[i].x1);
					total_size+=2;
					previous_primitive=ACTION_HLIN_ADD_RSAME;

				}
					break;
			default:
				fprintf(stderr,"Error unknown type!\n");
				exit(1);
				break;

		}


	}
	printf("\t.byte END\n");
	total_size++;
	printf("; total size = %d\n",total_size);

	return 0;
}



