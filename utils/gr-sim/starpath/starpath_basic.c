/* An Apple II lores version of Hellmood's amazing 64B DOS Star Path Demo */

/* See https://hellmood.111mb.de//starpath_is_55_bytes.html */

/* deater -- Vince Weaver -- vince@deater.net -- 24 February 2025 */


#include <stdio.h>
#include <unistd.h>

#include "gr-sim.h"

#include <stdio.h>
#include <unistd.h>

#define MAX_COLORS	32

/* The demo only actually generates these colors */
// 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
// black/white gradient, let's map from 0..15 instead
// in decimal, so add 100/16 each time, or 6.25?

static int color_remap[32]={
	0, 5, 0, 5, 5, 5,10,10, 5, 5,10,10, 7, 7, 15, 15,
	1, 2, 1, 2, 3, 9, 3, 9,13,12,13,12, 4, 4, 4, 4,
//	1, 1, 2, 2, 3, 3, 9, 9,13,13,12,12, 4, 4, 4, 4,
};

static void framebuffer_putpixel(unsigned int x, unsigned int y,
	unsigned char color) {

	color_equals(color_remap[color]);
	basic_plot(x,y);

}


int main(int argc, char **argv) {

	double frame,color,depth,x,y,yprime,xprime,a;
	int temp,ch;

	// set_default_pal();

	frame=0;

	grsim_init();

	gr();

	clear_screens();

	soft_switch(MIXCLR);

	while(1) {

	for(x=0;x<40;x++) {
		for(y=0;y<48;y++) {

			depth=14;	//  start ray depth at 14
L:
			yprime=(y*4)*depth;	// Y'=Y * current depth

			temp=(x*6)-depth;	// curve X by the current depth

			// if left of the curve, jump to "sky"
//			if (temp&0x100) {
			if (temp<0) {

				color=15;	// is both the star color and
						// palette offset into sky

				// pseudorandom multiplication leftover DL added to
				// truncated pixel count
				// 1 in 256 chance to be a star
				a=(x*6)+yprime;
				while(a>256) a-=256;
//				if (( (int)((x*6)+yprime) %256)!=0) {
//				if (a<4) printf("a=%lf (%d,%d)\n",a,(int)x,(int)y);
				if (a>6) {
					// if not, shift the starcolor and add scaled pixel count
					// want 16 .. 32
					color=(y/4)+16;
					//color-=160;
				}
			}
			else {
				// multiply X by current depth (into AH)
				xprime=temp*depth;

				// OR for geometry and texture pattern

//				temp=((int)(xprime)|(int)(yprime))/256;
				temp=((int)(xprime/256)|(int)(yprime/256));

				// get (current depth) + (current frame)
				// mask geometry/texture by time shifted depth
//
				color=((int)temp&(int)(depth+frame));

				// (increment depth by one)
				depth++;

				// ... to create "gaps"

				// color is always 0..16 here?
				// so gap if it is 16 or 32?

//				if (((int)color&0x10)==0) {
				if (color<16) {
//					printf("yeah %d!\n",(int)color);
					goto L;
				}

				// if ray did not hit, repeat pixel loop

				color-=16;
			}

			framebuffer_putpixel(x,y,color);
		}
	}

	frame++;		// increment frame counter

	grsim_update();

	usleep(10000);

	ch=grsim_input();
	if (ch=='q') return 0;
	if (ch==27) return 0;

	}

	return 0;

}

