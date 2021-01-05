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
	double ca,sa;
	double theta=0;
	int frame=0;
	double scale=1.0;

	double y0,x0,yca,ysa,xp,yp,xd=20,yd=20;
	int ytop=0,ybottom=40,xcenter=20,ycenter=20;
	int xleft=0,xright=40;

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

		y0=ytop-yd;
		for(yy=ytop;yy<ybottom;yy++) {
			y0=y0+1;
			x0=xleft-xd;
			yca=y0*ca+ycenter;
			ysa=y0*sa+xcenter;
			for(xx=xleft;xx<xright;xx++) {
				x0=x0+1;
				xp=x0*ca+ysa;
				yp=yca-x0*sa;

				if ((xp<0) || (xp>39)) color=0;
				else if ((yp<0) || (yp>39)) color=0;
				else {
					color=scrn_page(xp,yp,PAGE2);
				}

				if (
					((xx==0) && (yy==0)) ||
					((xx==20) && (yy==20)) ||
					((xx==39) && (yy==39))
				   ) {
				printf("%d,%d -> %0.2lf,%0.2lf\n",xx,yy,xp,yp);
				}

				color_equals(color);
				plot(xx,yy);

			}

		}
		theta+=(PI/8.0);

//		scale-=0.008;

		usleep(30000);

		frame++;
		/* reset */
//		if (frame==128) {
//			sleep(1);
//			theta=0;
//			scale=1.0;
//			frame=0;
//		}

	}

	return 0;
}

