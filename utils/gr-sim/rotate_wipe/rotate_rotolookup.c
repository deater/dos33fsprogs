/* based roughly on code from https://www.ocf.berkeley.edu/~horie/qbrotate.html */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "demo_title.c"

#define PI 3.14159265358979323946264

int main(int argc, char **argv) {

	int xx,yy,ch,color;
	double ca,sa,cca,csa;
	double theta=0;
	int frame=0;
	double scale=1.0;

	double yca,ysa,xp,yp;
	int xcenter=20,ycenter=20;

	grsim_init();
	gr();

//	clear_screens();

	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE2;
	clear_bottom();


//	clear_bottom(PAGE0);
//	clear_bottom(PAGE1);
//	clear_bottom(PAGE2);

//	grsim_unrle(demo_rle,0x400);
	grsim_unrle(demo_rle,0xc00);

//	gr_copy_to_current(0xc00);
//	page_flip();
//	gr_copy_to_current(0xc00);
//	page_flip();

	ram[DRAW_PAGE]=PAGE0;

	while(1) {
		grsim_update();

blah:
		ch=grsim_input();
		if (ch=='q') break;
		if (ch==0) goto blah;

		ca = cos(theta)*scale;
		sa = sin(theta)*scale;

		cca = -20*ca;
		csa = -20*sa;

		yca=cca+ycenter;
		ysa=csa+xcenter;

		for(yy=-20;yy<20;yy++) {

			xp=cca+ysa;
			yp=yca-csa;

			for(xx=-20;xx<20;xx++) {

				if ((xp<0) || (xp>39)) color=0;
				else if ((yp<0) || (yp>39)) color=0;
				else {
					color=scrn_page(xp,yp,PAGE2);
				}

				if (
					((xx==-20) && (yy==-20)) ||
					((xx==0) && (yy==0)) ||
					((xx==19) && (yy==19))
				   ) {
				printf("%d,%d -> %0.2lf,%0.2lf\n",xx,yy,xp,yp);
				}

				color_equals(color);
				plot(xx+20,yy+20);
				xp=xp+ca;
				yp=yp-sa;
			}
			yca+=ca;
			ysa+=sa;
		}
		theta+=(PI/8.0);

		scale-=0.008;

		usleep(30000);

		frame++;
		/* reset */
		if (frame==128) {
			sleep(1);
			theta=0;
			scale=1.0;
			frame=0;
		}

	}

	return 0;
}

