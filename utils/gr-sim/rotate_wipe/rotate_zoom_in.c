#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "demo_title.c"

int main(int argc, char **argv) {

	int xx,yy,ch,color,x2,y2;
	double h,theta,dx,dy,theta2,thetadiff,nx,ny;
	int frame=0;
	double scale=1.0;

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

	thetadiff=0;

	while(1) {
		grsim_update();

		ch=grsim_input();
		if (ch=='q') break;

		for(yy=0;yy<40;yy++) {
			for(xx=0;xx<40;xx++) {
				dx=(xx-20);
				dy=(yy-20);
				h=scale*sqrt((dx*dx)+(dy*dy));
				theta=atan2(dy,dx);

				theta2=theta+thetadiff;
				nx=h*cos(theta2);
				ny=h*sin(theta2);

				x2=nx+20;
				y2=ny+20;
				if ((x2<0) || (x2>39)) color=0;
				else if ((y2<0) || (y2>39)) color=0;
				else color=scrn_page(x2,y2,PAGE2);

				color_equals(color);
				plot(xx,yy);
			}
		}
		thetadiff+=(3.14/16.0);

		scale-=0.008;

		usleep(30000);

		frame++;
		/* reset */
		if (frame==128) {
			sleep(1);
			thetadiff=0;
			scale=1.0;
			frame=0;
		}

	}

	return 0;
}

