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


char color_names[16][16]={
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

char action_names[9][16]={
	"END","CLEAR","BOX","HLIN","VLIN","PLOT",
	"HLIN_ADD","HLIN_ADD_LSAME","HLIN_ADD_RSAME"
};

	int color_count[16];
	int framebuffer[40][48];
	int current_color=0;

	struct {
		int type;
		int color;
		int x1,y1,x2,y2;
	} primitive_list[4096];

	int current_primitive=0;

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

	/* Initial Implementation, All Plots */
	current_primitive=0;
	for(row=0;row<48;row++) {
		for(col=0;col<40;col++) {
			primitive_list[current_primitive].color=framebuffer[col][row];
			primitive_list[current_primitive].x1=col;
			primitive_list[current_primitive].y1=row;
			primitive_list[current_primitive].type=ACTION_PLOT;
			current_primitive++;

		}
	}

	/* Dump results */
	for(i=0;i<current_primitive;i++) {
		if (primitive_list[i].color==0) continue;

		if (current_color!=primitive_list[i].color) {
			printf("\t.byte SET_COLOR | %s\n",
				color_names[primitive_list[i].color]);
			current_color=primitive_list[i].color;
		}

		switch(primitive_list[i].type) {
			case ACTION_END:
					break;
			case ACTION_CLEAR:
					break;
			case ACTION_BOX:
					break;
			case ACTION_HLIN:
					break;
			case ACTION_VLIN:
					break;
			case ACTION_PLOT:
				printf("\t.byte PLOT,%d,%d\n",
					primitive_list[i].x1,
					primitive_list[i].y1);
					break;
			case ACTION_HLIN_ADD:
					break;
			case ACTION_HLIN_ADD_LSAME:
					break;
			case ACTION_HLIN_ADD_RSAME:
					break;
			default:
				fprintf(stderr,"Error unknown type!\n");
				exit(1);
				break;

		}


	}
	printf("\t.byte END\n");

	return 0;
}
