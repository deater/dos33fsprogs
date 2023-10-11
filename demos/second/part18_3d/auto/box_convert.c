/* box_convert */

/* Try to automate part of the annoyingly tedious rotoscoping process */

/* For input assumes a 40x48 (or 80x48, double wide) PNG file */
/* with the Apple II palette */

/* Output is ca65 6502 assembler for including in project */

/* TOOD:
     have a VLIN_SAME (would save enough bytes.  enough to matter?)
     some way of detecting smaller foreground objects and drawing them
	separately.  Tricky to do
     sort PLOT in with HLIN so can use HLIN_ADD but only where appropriate
	not sure how much that would save

   Optimizations missed compared to by hand
	sometimes there are two sets of auto-incremeting HLIN, like on
		left and right side of screen.  auto can't capture that
	action_type can cross color boundaries, can optimize what order
		the actions are in to take advantage of this
*/

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

#include "box_sizes.c"

static int debug=0;

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

/* There's probably an algorithmic way of generating this at run time */
/* but I was too lazy to implement it */
/* We only do 4.  All 16 would be prohibitive.  Maybe a happy medium? */
static int permutations[24][4]={
{1,2,3,4},
{2,1,3,4},
{3,1,2,4},
{1,3,2,4},
{2,3,1,4},
{3,2,1,4},
{3,2,4,1},
{2,3,4,1},
{4,3,2,1},
{3,4,2,1},
{2,4,3,1},
{4,2,3,1},
{4,1,3,2},
{1,4,3,2},
{3,4,1,2},
{4,3,1,2},
{1,3,4,2},
{3,1,4,2},
{2,1,4,3},
{1,2,4,3},
{4,2,1,3},
{2,4,1,3},
{1,4,2,3},
{4,1,2,3},
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
#define ACTION_BOX_ADD		0x9
#define ACTION_BOX_ADD_LSAME	0xA
#define ACTION_BOX_ADD_RSAME	0xB
#define ACTION_VLIN_ADD		0xC

#if 0
static char action_names[9][16]={
	"END","CLEAR","BOX","HLIN","VLIN","PLOT",
	"HLIN_ADD","HLIN_ADD_LSAME","HLIN_ADD_RSAME"
};
#endif

#define MAX_PRIMITIVES	4096
static struct primitive_list_t {
	int type;
	int color;
	int x1,y1,x2,y2;
} primitive_list[MAX_PRIMITIVES];

static int framebuffer[40][48];
static int framebuffer_saved[40][48];
static int background_color=0;

/* Not used anymore, included for historical reasons */
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

static unsigned char *image;

static struct color_lookup_t {
	int color;
	int count;
} color_lookup[16]={
	{0,0},{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0},{8,0},
	{9,0},{10,0},{11,0},{12,0},{13,0},{14,0},{15,0}
};

static struct color_lookup_t color_backup[16];

/* Permute the top 4 colors in the color list histogram */
/* We do this to see if the resulting data is more compact */
/* We skip the black background, it might be interesting to include that */
/* as a normal color */
static void permute_colors(int which) {

	int i;

	for(i=0;i<4;i++) {

		color_lookup[i+1].color=color_backup[permutations[which][i]].color;
		color_lookup[i+1].count=color_backup[permutations[which][i]].count;

	}
}

/* Not used anymore, included for historical reasons */
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

/* Not used anymore, included for historical reasons */
int create_using_hlins_by_color(void) {

	int current_primitive=0;
	int row,col,start_x;
	int current_color,prev_color;
	int len,color;

	for(color=0;color<16;color++) {
	current_color=color_lookup[color].color;

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

/* Find the smallest rectangle that includes all of a certain color */
/* We calculate this because if we don't track and this and include */
/* Don't Cares, then the algorithm will make overly-huge rectangles */
/* that are bigger than needed and make subsequent rectangles */
/* pessimistic */

int find_max_color_extent(int current_color,int *color_minx,int *color_miny,
			int *color_maxx,int *color_maxy) {


	int xx,yy;

	*color_minx=39;
	*color_miny=47;
	*color_maxx=0;
	*color_maxy=0;

	/* Find maximum extent of color */
	for(yy=0;yy<48;yy++) {
		for(xx=0;xx<40;xx++) {
			if (current_color==framebuffer[xx][yy]) {
				if (xx<*color_minx) *color_minx=xx;
				if (xx>*color_maxx) *color_maxx=xx;
				if (yy<*color_miny) *color_miny=yy;
				if (yy>*color_maxy) *color_maxy=yy;
			}
		}
	}
	if (debug) fprintf(stderr,"Color %d: range %d,%d to %d,%d\n",
			current_color,*color_minx,*color_miny,
			*color_maxx,*color_maxy);


	return 0;

}

/* The main routine */
int create_using_boxes(int small_box_threshold) {

	int current_primitive=0;
	int row,col,box;
	int current_color;
	int color;
	int color_minx,color_maxx,color_miny,color_maxy;
	int which_threshold;

//for(which_threshold=0;which_threshold<2;which_threshold++) {
//	if (which_threshold==1) small_box_threshold=0;

	/* Do one color at a time */
	/* The color order is picked in advance */
	for(color=0;color<16;color++) {
		current_color=color_lookup[color].color;

		/* To save space the Apple II implementation */
		/* always clears screen to the background color */
		/* for each frame so we assume we don't have to draw it */
		if (current_color==background_color) continue;


		/* calculate maximum color extent */
		/* we don't want rectangles bigger than the region with */
		/* that color */
		/* Note we have to re-calc this after drawing a box */
		find_max_color_extent(current_color,
					&color_minx,&color_miny,
					&color_maxx,&color_maxy);

		/* Try all possible box sizes. */
		/* We can be exhaustive as there are only 40x48 possibilities */
		/* Table is pre-sorted by size */
		for(box=0;box<NUM_BOX_SIZES;box++) {

			int xx,yy,box_found,color_found,color_found2;

//			if ((box_sizes[box].x*box_sizes[box].y)
//				< small_box_threshold) {
//					fprintf(stderr,"Stopping color %d\n",current_color);
//					break;
//			}

			/* check to see if this box size is */
			/* the best fit for this color */
			for(row=0;row<48-box_sizes[box].y;row++) {
			for(col=0;col<40-box_sizes[box].x;col++) {
				box_found=1;
				color_found=0;
				color_found2=0;

				/* check to see if box is suitable */
				for(yy=0;yy<box_sizes[box].y;yy++) {
				for(xx=0;xx<box_sizes[box].x;xx++) {

				/* Only a fit if color is included */
				/* i.e. don't have one that's all don't cares */
				if (framebuffer[xx+col][yy+row]==current_color) {
					color_found=1;
				}

				/* If there's a background color */
				/* or else a previously drawn box (0xff)  */
				/* then early exit */
				if ((framebuffer[xx+col][yy+row]==
						background_color) ||
					(framebuffer[xx+col][yy+row]==0xff)) {
					box_found=0;
					break;
				}

				} // xx
				/* propogate early exit */
				if (!box_found) break;
				} // yy

				/* This isn't a good fit if rectangle is */
				/* bigger than the minimal rectangle */
				/* containing the colors */
				if (( (col)>=color_minx) &&
					((col+box_sizes[box].x-1)<=color_maxx) &&
					((row)>=color_miny) &&
					((row+box_sizes[box].y-1)<=color_maxy)) {

					color_found2=1;
				}

				/* We found a rectangle! */
				/* Box was found, included the color */
				/* 	and not too big */
				if ((box_found) &&
					(color_found) &&
						(color_found2)) {

				/* Urgh tab depth too deep */

				if (debug) fprintf(stderr,"Found box c=%d %d,%d to %d,%d\n",
					current_color,col,row,col+box_sizes[box].x-1,
					row+box_sizes[box].y-1);

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

				/* mark the area we've drawn */
				/* use 0xff to indicate */
				for(yy=0;yy<box_sizes[box].y;yy++) {
				for(xx=0;xx<box_sizes[box].x;xx++) {
					if(framebuffer[xx+col][yy+row]==current_color) {
						framebuffer[xx+col][yy+row]=0xff;
					}
				}
				}

				/* re-calculate max extent */
				find_max_color_extent(current_color,
					&color_minx,&color_miny,
					&color_maxx,&color_maxy);

				}


			} // col
			} // row
		} // box
	}	// current_color
//}

	return current_primitive;
}

/* Comparison routines for the qsort()s */

static int compare_type(const void *p1, const void *p2) {

	struct primitive_list_t *first,*second;

	first=(struct primitive_list_t *)p1;
	second=(struct primitive_list_t *)p2;

	return (first->type > second->type);

}

static int compare_y1(const void *p1, const void *p2) {

	struct primitive_list_t *first,*second;

	first=(struct primitive_list_t *)p1;
	second=(struct primitive_list_t *)p2;

	return (first->y1 > second->y1);

}

static int compare_x1(const void *p1, const void *p2) {

	struct primitive_list_t *first,*second;

	first=(struct primitive_list_t *)p1;
	second=(struct primitive_list_t *)p2;

	return (first->x1 > second->x1);

}

static int compare_color(const void *p1, const void *p2) {

	struct color_lookup_t *first,*second;

	first=(struct color_lookup_t *)p1;
	second=(struct color_lookup_t *)p2;

	return (first->count < second->count);

}



/* generate data for a frame */
/* returns how many bytes it takes up */
/* we call this many times when iterating to see best color combo */
/* only set print_results on final run to output the data */

int generate_frame(int print_results) {

	int i;

	int current_color=0;

	int max_primitive=0;
	int previous_primitive=0;
	int total_size=0;



//	max_primitive=create_using_hlins();
//	max_primitive=create_using_hlins_by_color();
	max_primitive=create_using_boxes(0);


	/* Optimize boxes to PLOT/VLIN/HLIN */
	/* if 1x1, single pixel plot */
	/* if xwidth = 1, then vertical line */
	/* if ywidth = 1, then horizontal line */
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

	/* Sort each color by BOX/HLIN/ETC */

	/* This lets us use more compact encoding where consecutive */
	/* types don't have to specify (since we max out at 40x48 we */
	/* can use the high bit of the first co-ord to specify whether */
	/* we are a number or else starting a new type */

	int old_color,last_color_start=0;

	old_color=primitive_list[0].color;
	for(i=0;i<max_primitive;i++) {
		if ((primitive_list[i].color!=old_color)||(i==max_primitive-1)) {
			if (debug) fprintf(stderr,"Sorting color %d from %d to %d\n",
				old_color,last_color_start,i);
			qsort(&(primitive_list[last_color_start]),i-last_color_start,
				sizeof(struct primitive_list_t),compare_type);
			last_color_start=i;
		}
		old_color=primitive_list[i].color;
	}

	/* Sort HLIN by Y1 */
	/* This lets us use more compact encoding where consecutive */
	/* horizontal lines don't specify the Y value but just increment */
	/* the previous one */

	int first_hlin=0,last_hlin=0,j,hlin_found;

	old_color=primitive_list[0].color;
	for(i=0;i<max_primitive;i++) {
		if ((primitive_list[i].color!=old_color)||(i==max_primitive-1))  {
			hlin_found=0;
			first_hlin=0; last_hlin=0;
//			fprintf(stderr,"Searching for HLIN in color %d from %d to %d\n",
//				old_color,last_color_start,i);
			for(j=last_color_start;j<i;j++) {
				if (primitive_list[j].type==ACTION_HLIN) {
					if (!hlin_found) {
						first_hlin=j;
						hlin_found=1;
					}
					last_hlin=j;
				}
			}
			if (hlin_found) {
				if (debug) fprintf(stderr,"Sorting color %d HLIN Y1 from %d to %d\n",
					old_color,first_hlin,last_hlin);
				// qsort(base, num_members,size_members,compare func
				qsort(&(primitive_list[first_hlin]),(last_hlin-first_hlin)+1,
					sizeof(struct primitive_list_t),compare_y1);
			}
			else {
//				fprintf(stderr,"No HLIN in color %d\n",old_color);
			}
			last_color_start=i;
		}
		old_color=primitive_list[i].color;
	}

	/* Sort VLIN by X1 */
	/* This lets us use more compact encoding where consecutive */
	/* horizontal lines don't specify the X value but just increment */
	/* the previous one */

	int first_vlin=0,last_vlin=0,vlin_found;

	old_color=primitive_list[0].color;
	for(i=0;i<max_primitive;i++) {
		if ((primitive_list[i].color!=old_color)||(i==max_primitive-1))  {
			vlin_found=0;
			first_vlin=0; last_vlin=0;
//			fprintf(stderr,"Searching for VLIN in color %d from %d to %d\n",
//				old_color,last_color_start,i);
			for(j=last_color_start;j<i;j++) {
				if (primitive_list[j].type==ACTION_VLIN) {
					if (!vlin_found) {
						first_vlin=j;
						vlin_found=1;
					}
					last_vlin=j;
				}
			}
			if (vlin_found) {
				if (debug) fprintf(stderr,"Sorting color %d VLIN Y1 from %d to %d\n",
					old_color,first_vlin,last_vlin);
				// qsort(base, num_members,size_members,compare func
				qsort(&(primitive_list[first_vlin]),(last_vlin-first_vlin)+1,
					sizeof(struct primitive_list_t),compare_x1);
			}
			else {
//				fprintf(stderr,"No HLIN in color %d\n",old_color);
			}
			last_color_start=i;
		}
		old_color=primitive_list[i].color;
	}


	/* Sort BOX by Y1 */
	/* This lets us do optimizations similar to HLIN above */
	int first_box=0,last_box=0,box_found;

	old_color=primitive_list[0].color;
	for(i=0;i<max_primitive;i++) {
		if ((primitive_list[i].color!=old_color)||(i==max_primitive-1))  {
			box_found=0;
			first_box=0; last_box=0;
//			fprintf(stderr,"Searching for BOX in color %d from %d to %d\n",
//				old_color,last_color_start,i);
			for(j=last_color_start;j<i;j++) {
				if (primitive_list[j].type==ACTION_BOX) {
					if (!box_found) {
						first_box=j;
						box_found=1;
					}
					last_box=j;
				}
			}
			if (box_found) {
				if (debug) fprintf(stderr,"Sorting color %d BOX Y1 from %d to %d\n",
					old_color,first_box,last_box);
				// qsort(base, num_members,size_members,compare func
				qsort(&(primitive_list[first_box]),(last_box-first_box)+1,
					sizeof(struct primitive_list_t),compare_y1);
			}
			else {
//				fprintf(stderr,"No BOX in color %d\n",old_color);
			}
			last_color_start=i;
		}
		old_color=primitive_list[i].color;
	}


	/* Optimize HLIN */
	/* If Y is same as prev+1, then ACTION_HLIN_ADD */
	/* If Y is same as prev+1 and x1 (left) same, then ACTION_HLIN_ADD_LSAME */
	/* If Y is same as prev+1 and x2 (right) same, then ACTION_HLIN_ADD_RSAME */

	int previous_entry=0,previous_y1=0,previous_x1=0,previous_x2=0,previous_y2=0;
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].type==ACTION_HLIN) {

			if ( ((previous_entry==ACTION_HLIN)||(previous_entry==ACTION_HLIN_ADD) ||(previous_entry==ACTION_HLIN_ADD_LSAME)) &&
				(previous_y1==primitive_list[i].y1-1) &&
				(previous_x1==primitive_list[i].x1)) {
				primitive_list[i].type=ACTION_HLIN_ADD_LSAME;
			}
			else
			if ( ((previous_entry==ACTION_HLIN)||(previous_entry==ACTION_HLIN_ADD) ||(previous_entry==ACTION_HLIN_ADD_RSAME)) &&
				(previous_y1==primitive_list[i].y1-1) &&
				(previous_x2==primitive_list[i].x2)) {
				primitive_list[i].type=ACTION_HLIN_ADD_RSAME;
			}
			else
			if ( ((previous_entry==ACTION_HLIN) || (previous_entry==ACTION_HLIN_ADD) || (previous_entry==ACTION_PLOT)) &&
				(previous_y1==primitive_list[i].y1-1)) {
				primitive_list[i].type=ACTION_HLIN_ADD;
			}
		}
		previous_entry=primitive_list[i].type;
		previous_y1=primitive_list[i].y1;
		previous_x1=primitive_list[i].x1;
		previous_x2=primitive_list[i].x2;
	}

	/* Optimize VLIN */
	/* If X is same as prev+1, then ACTION_VLIN_ADD */

	previous_entry=0,previous_y1=0,previous_x1=0,previous_x2=0,previous_y2=0;
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].type==ACTION_VLIN) {

			if ( ((previous_entry==ACTION_VLIN) || (previous_entry==ACTION_VLIN_ADD)) &&
				(previous_x1==primitive_list[i].x1-1)) {
				primitive_list[i].type=ACTION_VLIN_ADD;
			}
		}
		previous_entry=primitive_list[i].type;
		previous_y1=primitive_list[i].y1;
		previous_x1=primitive_list[i].x1;
		previous_x2=primitive_list[i].x2;
	}


	/* Optimize BOX */
	previous_entry=0,previous_y1=0,previous_y2=0,previous_x1=0,previous_x2=0;
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].type==ACTION_BOX) {

			if ( ((previous_entry==ACTION_BOX)||(previous_entry==ACTION_BOX_ADD) ||(previous_entry==ACTION_BOX_ADD_LSAME)) &&
				(previous_y2==primitive_list[i].y1-1) &&
				(previous_x1==primitive_list[i].x1)) {
				primitive_list[i].type=ACTION_BOX_ADD_LSAME;
			}
			else
			if ( ((previous_entry==ACTION_BOX)||(previous_entry==ACTION_BOX_ADD) ||(previous_entry==ACTION_BOX_ADD_RSAME)) &&
				(previous_y2==primitive_list[i].y1-1) &&
				(previous_x2==primitive_list[i].x2)) {
				primitive_list[i].type=ACTION_BOX_ADD_RSAME;
			}
			else
			if ( ((previous_entry==ACTION_BOX) || (previous_entry==ACTION_BOX_ADD)) &&
				(previous_y2==primitive_list[i].y1-1)) {
				primitive_list[i].type=ACTION_BOX_ADD;
			}
		}
		previous_entry=primitive_list[i].type;
		previous_x1=primitive_list[i].x1;
		previous_y1=primitive_list[i].y1;
		previous_x2=primitive_list[i].x2;
		previous_y2=primitive_list[i].y2;
	}



	/* Dump results */
	for(i=0;i<max_primitive;i++) {
		if (primitive_list[i].color==0) continue;

		if (current_color!=primitive_list[i].color) {
			if (print_results) printf("\t.byte SET_COLOR | %s\n",
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
					if (print_results) printf("\t.byte %d,%d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1,
						primitive_list[i].x2,
						primitive_list[i].y2);
					total_size+=4;
				}
				else {
					if (print_results) printf("\t.byte BOX,%d,%d,%d,%d\n",
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
					if (print_results) printf("\t.byte %d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=3;
				}
				else {
					if (print_results) printf("\t.byte HLIN,%d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=4;
					previous_primitive=ACTION_HLIN;

				}
					break;
			case ACTION_VLIN:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1,
						primitive_list[i].y2);
					total_size+=3;
				}
				else {
					if (print_results) printf("\t.byte VLIN,%d,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1,
						primitive_list[i].y2);
					total_size+=4;
					previous_primitive=ACTION_VLIN;

				}
					break;
			case ACTION_VLIN_ADD:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d\t; %d\n",
						primitive_list[i].y1,
						primitive_list[i].y2,
						primitive_list[i].x1);
					total_size+=2;
				}
				else {
					if (print_results) printf("\t.byte VLIN_ADD,%d,%d\t; %d\n",
						primitive_list[i].y1,
						primitive_list[i].y2,
						primitive_list[i].x1);
					total_size+=3;
					previous_primitive=ACTION_VLIN_ADD;

				}
					break;

			case ACTION_PLOT:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1);
					total_size+=2;
				}
				else {
					if (print_results) printf("\t.byte PLOT,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y1);
					total_size+=3;
					previous_primitive=ACTION_PLOT;

				}
					break;
			case ACTION_HLIN_ADD:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d\t; %d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=2;
				}
				else {
					if (print_results) printf("\t.byte HLIN_ADD,%d,%d\t; %d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=3;
					previous_primitive=ACTION_HLIN_ADD;

				}
					break;
			case ACTION_HLIN_ADD_LSAME:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d\n",
						primitive_list[i].x2);
					total_size+=1;
				}
				else {
					if (print_results) printf("\t.byte HLIN_ADD_LSAME,%d ; %d, %d, %d\n",
						primitive_list[i].x2,
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=2;
					previous_primitive=ACTION_HLIN_ADD_LSAME;

				}
					break;
			case ACTION_HLIN_ADD_RSAME:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d\t; %d %d %d\n",
						primitive_list[i].x1,
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=1;
				}
				else {
					if (print_results) printf("\t.byte HLIN_ADD_RSAME,%d\t; %d %d %d\n",
						primitive_list[i].x1,
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=2;
					previous_primitive=ACTION_HLIN_ADD_RSAME;

				}
					break;
			case ACTION_BOX_ADD:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d,%d\t; %d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y2,
						primitive_list[i].y1);
					total_size+=3;
				}
				else {
					if (print_results) printf("\t.byte BOX_ADD,%d,%d,%d\t; %d\n",
						primitive_list[i].x1,
						primitive_list[i].x2,
						primitive_list[i].y2,
						primitive_list[i].y1);
					total_size+=4;
					previous_primitive=ACTION_BOX_ADD;

				}
					break;
			case ACTION_BOX_ADD_LSAME:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d\n",
						primitive_list[i].x2,
						primitive_list[i].y2);
					total_size+=2;
				}
				else {
					if (print_results) printf("\t.byte BOX_ADD_LSAME,%d,%d ; %d, %d\n",
						primitive_list[i].x2,
						primitive_list[i].y2,
						primitive_list[i].x1,
						primitive_list[i].y1);
					total_size+=3;
					previous_primitive=ACTION_BOX_ADD_LSAME;

				}
					break;
			case ACTION_BOX_ADD_RSAME:
				if (primitive_list[i].type==previous_primitive) {
					if (print_results) printf("\t.byte %d,%d\t; %d %d\n",
						primitive_list[i].x1,
						primitive_list[i].y2,
						primitive_list[i].x2,
						primitive_list[i].y1);
					total_size+=2;
				}
				else {
					if (print_results) printf("\t.byte BOX_ADD_RSAME,%d,%d\n",
						primitive_list[i].x1,
						primitive_list[i].y2);
					total_size+=3;
					previous_primitive=ACTION_BOX_ADD_RSAME;

				}
					break;

			default:
				fprintf(stderr,"Error unknown type!\n");
				exit(1);
				break;

		}


	}
	if (print_results) printf("\t.byte END\n");
	total_size++;

	if (print_results) printf("; total size = %d\n",total_size);

	return total_size;
}

int main(int argc, char **argv) {

	int xsize,ysize;
	int row,col,pixel,i;
	int minimal_size,minimal_which=0;

	if (argc<1) {
		fprintf(stderr,"Usage:\t%s INFILE\n",argv[0]);
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	if (debug) fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

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

	/* convert "packed" lo-res data to easier to use 40x48 array */
	/* (on Apple II two rows of colors are combined in hi/lo nybble) */
	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			/* get packed color */
			pixel=(image[row*40+col]);
			/* Update histogram data */
			color_lookup[pixel&0xf].count++;
			color_lookup[(pixel>>4)&0xf].count++;
			/* unpack color */
			framebuffer[col][row*2]=pixel&0xf;
			framebuffer[col][(row*2)+1]=(pixel>>4)&0xf;
		}
	}

	/* save copy of framebuffer data as getting boxes is destructive */
	memcpy(framebuffer_saved,framebuffer,40*48*sizeof(int));

	/* sort histogram data */
	qsort(&(color_lookup[1]),15,
			sizeof(struct color_lookup_t),compare_color);

//	printf("; Histogram\n");
//	for(i=0;i<16;i++) {
//		printf("; $%02X %s: %d\n",color_lookup[i].color,color_names[color_lookup[i].color],color_lookup[i].count);
//	}

	/* backup color data as well */
	memcpy(color_backup,color_lookup,16*sizeof(struct color_lookup_t));

	int result;
	minimal_size=4096;
	for(i=0;i<24;i++) {
		permute_colors(i);
		result=generate_frame(0);
		fprintf(stderr,"%d: %d bytes\n",i,result);
		if (result<minimal_size) {
			minimal_size=result;
			minimal_which=i;
		}

		/* reset for next attempt */
		memcpy(framebuffer,framebuffer_saved,40*48*sizeof(int));
	}
	fprintf(stderr,"minimum = %d, %d bytes\n",minimal_which,minimal_size);
	permute_colors(minimal_which);
	generate_frame(1);

	return 0;
}
