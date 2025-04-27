/* An Apple II lores version of Hellmood's amazing 64B DOS Star Path Demo */

/* See https://hellmood.111mb.de//starpath_is_55_bytes.html */

/* deater -- Vince Weaver -- vince@deater.net -- 24 February 2025 */


#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#include "gr-sim.h"

#include <stdio.h>
#include <unistd.h>

#define MAX_COLORS	32

/* The demo only actually generates these colors */
// 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
// black/white gradient, let's map from 0..15 instead
// in decimal, so add 100/16 each time, or 6.25?

static int color_remap[32]={
//	0, 5, 0, 5, 5, 5,10,10, 5, 5,10,10, 7, 7, 15, 15,
//	1, 2, 1, 2, 3, 9, 3, 9,13,12,13,12, 4, 4, 4, 4,
//	1, 1, 2, 2, 3, 3, 9, 9,13,13,12,12, 4, 4, 4, 4,
	0,5,10,5,7,14,15,15,
//sky_colors:
// 2=blue 1=magenta 3=purple 9=orange d=yellow c=l.green
	2,3,1,9,13,12


};

static void framebuffer_putpixel(unsigned int x, unsigned int y,
	unsigned char color) {

	color_equals(color_remap[(color/2)-8]);
	basic_plot(x,y);

}

static int ypos_depth_lookup[48][256];
static unsigned char depth_squared_lookup[256];
static unsigned char xpos_depth_lookup[48][256];

static int ypos4_times_depth(int ypos, int depth) {

	if (ypos>47) printf("YPOS OUT OF BOUNDS %d\n",ypos);
	if (depth>127) printf("DEPTH OUT OF BOUNDS %d\n",depth);

	return ypos_depth_lookup[ypos][depth];

}

static void ypos_depth_lookup_init(void) {
	int y,d;

	for(d=0;d<128;d++) {
		for(y=0;y<48;y++) {
			ypos_depth_lookup[y][d]=y*4*d;
		}
	}

	unsigned char diff=1;
	unsigned short square=0;
	for(d=0;d<128;d++) {
		// 0, 1, 4, 9, 16, 25, 36
		//  1   3  5  7  9   11
		depth_squared_lookup[d]=(square)>>8;
		square=square+diff;
		diff+=2;
	}

	for(d=0;d<128;d++) {
		for(y=0;y<40;y++) {
			xpos_depth_lookup[y][d]=(y*6*d)>>8;
		}
	}

}

static int xpos_times_depth(int xpos, int depth) {

	if (xpos>40) printf("XPOS OUT OF BOUNDS %d\n",xpos);
	if (depth>127) printf("DEPTH OUT OF BOUNDS %d\n",depth);

	return xpos_depth_lookup[xpos][depth];

}


int main(int argc, char **argv) {

//	int maxdepth=0,mintemp=0,maxtemp=0;
//	int xprime;
	int xpos,xpos6,ypos,yprime;
	int xprime_high,yprime_high;
	int temp,ch;

	unsigned char frame,color,depth;

	// set_default_pal();

	frame=0;

	ypos_depth_lookup_init();

	grsim_init();

	gr();

	clear_screens();

	soft_switch(MIXCLR);

next_frame:

	ypos=0;
yloop:
	xpos=0;
	xpos6=0;
xloop:

	depth=14;	//  start ray depth at 14
depth_loop:
//	yprime=(ypos*4)*depth;	// Y'=Y * current depth
	yprime=ypos4_times_depth(ypos,depth);

	temp=xpos6-depth;	// curve X by the current depth

	// if left of the curve, jump to "sky"
	if (temp&0x100) {

		color=31;	// white for star


		if ( (random()%256)<6) {
//		if (((xpos6+yprime)&0xff)!=0) {
			// if not, shift the starcolor and add scaled pixel count
			//color=(color<<4)|((ypos*4)>>4);
			//color-=160;

			color=(ypos/4)+32;	// sky gradient instead
		}


	}
	else {
		// multiply X by current depth (into AH)
	//	xprime=temp*depth;
	//	xprime=(xpos6-depth)*depth;
//		xprime=(xpos6*depth)-(depth*depth);
//		xprime=xpos_times_depth(xpos,depth)-
//			depth_squared_lookup[depth];
//		xprime=temp_times_depth(xpos,depth);

		xprime_high=xpos_times_depth(xpos,depth)-
			depth_squared_lookup[depth];



		//printf("%d %d\n",temp,depth);
//		if (temp<mintemp) {
//			mintemp=temp;
//			printf("%d %d\n",mintemp,maxtemp);
//		}
//		if (temp>maxtemp) {
//			maxtemp=temp;
//			printf("%d %d\n",mintemp,maxtemp);
//		}


		// OR for geometry and texture pattern
//		xprime_high=xprime>>8;
		yprime_high=yprime>>8;

		temp=xprime_high|yprime_high;

		// get (current depth) + (current frame)
		// mask geometry/texture by time shifted depth
		color=(temp&(depth+frame));

		// (increment depth by one)
		depth++;

//		if (depth>maxdepth) {
//			maxdepth=depth;
//			printf("New maxdepth=%d\n",depth);
//		}

		// ... to create "gaps"

		if ((color&0x10)==0) goto depth_loop;

		// if ray did not hit, repeat pixel loop

	}

	framebuffer_putpixel(xpos,ypos,color);

	xpos++;
	xpos6+=6;
	if (xpos6<240) goto xloop;

	ypos++;
	if (ypos<48) goto yloop;

	frame++;		// increment frame counter

//	dump_framebuffer_gr();

	grsim_update();

	usleep(20000);

	ch=grsim_input();
	if (ch=='q') return 0;
	if (ch==27) return 0;

	goto next_frame;

	return 0;

}

