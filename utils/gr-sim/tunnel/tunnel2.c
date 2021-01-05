#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"


#define SCALE	8.0
#define STEP	30
#define DELTA	(STEP/10.0)

//#define SCALE	4.0
//#define STEP	45.0
//#define DELTA	(STEP/3.0)

//#define SCALE	8.0
//#define STEP	22.5
//#define DELTA	(STEP/3.0)


static double d2r(double xx) {
	return (xx/180.0)*3.1415926535897932384;
}

int main(int argc, char **argv) {

	int xx,yy,ch,i;
	double theta,delta=0.0;


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
//	grsim_unrle(demo_rle,0xc00);

//	gr_copy_to_current(0xc00);
//	page_flip();
//	gr_copy_to_current(0xc00);
//	page_flip();

	ram[DRAW_PAGE]=PAGE0;

	while(1) {

		ch=repeat_until_keypressed();
		if (ch=='q') break;

		clear_top();

		for(theta=0;theta<360.0;theta+=STEP) {
			xx=cos(d2r(theta+delta))*SCALE+20;
			yy=sin(d2r(theta+delta))*SCALE*1.33+24;

#if 1
			color_equals(15);
			plot(xx,yy);

			if (xx<20) {
				color_equals(1);
				for(i=xx;i<(20-xx)+20;i++) {
					plot(i,yy);
				}
			}
			else {
				color_equals(2);
				for(i=xx;i<40;i++) {
					plot(i,yy);
				}
			}

#endif

#if 0
			color_equals(4);
			plot(xx,yy);
			if (xx>20) {
				for(i=xx;i<40;i++) {
					plot(i,yy);
				}
			}
#endif
#if 0

			color_equals(4);
//			plot(xx,yy);
			if (xx<20) {
				for(i=xx;i<40;i++) {
					plot(i,yy);
				}
			}
#endif

		}
		delta+=DELTA;

		grsim_update();

	}


	return 0;
}

