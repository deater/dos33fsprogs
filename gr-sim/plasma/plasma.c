/* for demoscene, you need a plasma effect... */
/* https://rosettacode.org/wiki/Plasma_effect */
/* https://www.bidouille.org/prog/plasma */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "tfv_zp.h"
#include "gr-sim.h"

#define pi 3.14159265358979323846264338327950


unsigned char colors[]={15,13,9,1,8,5,0,0};


int main(int argc, char **argv) {

	int ch,xx,yy,sec=128;
	double dx,dy,dv,r;

	grsim_init();

	gr();
	clear_screens();

	color_equals(15);
	hlin(0,0,40,39);

	ram[DRAW_PAGE]=0x0;

	while(1) {

		sec++;

		for(yy=0;yy<40;yy++) {
			for(xx=0;xx<40;xx++) {

//				dx = xx + .5 * sin(sec/5.0);
				dx = sin(xx+sec);
				dy = yy + .5 * cos(sec/3.0);
				dv = sin(xx*10 + sec) +
					sin(10*(xx*sin(sec/2.0) +
					yy*cos(sec/3.0)) + sec) +
					sin(sqrt(100*(dx*dx + dy*dy)+1) + sec);
				r=fabs(sin(dv*pi))*16;
			printf("%d %d %f %f %f %f\n",xx,yy,dx,dy,dv,r);
//			setcolor(COLOR(255*fabs(sin(dv*pi)),255*fabs(sin(dv*pi + 2*pi/3)),255*fabs(sin(dv*pi + 4*pi/3))));



				color_equals(fabs(dx)*16);
				plot(xx,yy);
				//plot(xx-r+2,yy);
//				printf("plot %d,%d = %d\n",xx,yy,colors[col]);
			}

		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(20000);

	}

	return 0;
}
