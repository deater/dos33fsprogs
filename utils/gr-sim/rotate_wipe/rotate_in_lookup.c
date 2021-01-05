#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "demo_title.c"

#define PI 3.14159265358979323846264

static int lookup_table_x[40][40];
static int lookup_table_y[40][40];

static int setup_lookup_table(void) {

	int xx,yy,dx,dy;
	double h,theta,thetadiff=PI/16;
	double theta2,nx,ny,x2,y2,scale=1.0;

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

			if ((x2<0)||(x2>39)) {
				lookup_table_x[xx][yy]=-1;
			}
			else {
				lookup_table_x[xx][yy]=x2;
			}

			if ((y2<0)||(y2>39)) {
				lookup_table_y[xx][yy]=-1;
			}
			else {
				lookup_table_y[xx][yy]=y2;
			}
		}
	}

	return 0;
}


int main(int argc, char **argv) {

	int xx,yy,ch,color;
	double thetadiff;
	int frame=0;
	double scale=1.0;

	grsim_init();
	gr();

	setup_lookup_table();

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
				if ((lookup_table_x[xx][yy]==-1) ||
					(lookup_table_y[xx][yy]==-1)) {
					color=0;
				}
				else {
					color=scrn_page(lookup_table_x[xx][yy],
							lookup_table_y[xx][yy],
							PAGE2);
				}
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

