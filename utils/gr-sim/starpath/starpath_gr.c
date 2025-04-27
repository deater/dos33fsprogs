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

	int maxdepth=0;
	int frame,color,depth,x,y,yprime,xprime;
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
			if (temp&0x100) {

				color=27-16;	// is both the star color and
						// palette offset into sky

				// pseudorandom multiplication leftover DL added to
				// truncated pixel count
				// 1 in 256 chance to be a star
				if ((((x*6)+yprime)&0xff)!=0) {
					// if not, shift the starcolor and add scaled pixel count
					color=(color<<4)|((y*4)>>4);
					color-=160;
				}


			}
			else {
				// multiply X by current depth (into AH)
				xprime=temp*depth;

				// OR for geometry and texture pattern
				temp=((xprime)|(yprime))>>8;

				// get (current depth) + (current frame)
				// mask geometry/texture by time shifted depth
				color=(temp&(depth+frame));

				// (increment depth by one)
				depth++;

				if (depth>maxdepth) {
					maxdepth=depth;
					printf("New maxdepth=%d\n",depth);
				}

				// ... to create "gaps"

				if ((color&0x10)==0) goto L;

				// if ray did not hit, repeat pixel loop

				color-=16;
			}

			framebuffer_putpixel(x,y,color);
		}
	}

	frame++;		// increment frame counter

//	dump_framebuffer_gr();

	grsim_update();

	usleep(10000);

	ch=grsim_input();
	if (ch=='q') return 0;
	if (ch==27) return 0;

	}

	return 0;

}

