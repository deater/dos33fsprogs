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


#if 0
static unsigned char color_lookup[]={0x0, 0x0, 0x5, 0x5,
				     0x7, 0x7, 0xf, 0xf,
				     0x7, 0x7, 0x6, 0x6,
				     0x2, 0x2, 0x5, 0x5};
#endif

static unsigned char color_lookup[]={0x0, 0x5, 0x7, 0xf,
				     0x7, 0x6, 0x2, 0x5,
				     0x0, 0x5, 0x7, 0xf,
				     0x7, 0x6, 0x2, 0x5};



int main(int argc, char **argv) {

	int ch,xx,yy,col;
//	double dx,dy,dv;
	double r;
	double sec=0.0;

	grsim_init();

	gr();
	soft_switch(MIXCLR);

	clear_screens();

	ram[DRAW_PAGE]=0x0;

	while(1) {

//		sec+=0.00625;
		sec+=0.000625;

		for(yy=0;yy<48;yy++) {
			for(xx=0;xx<40;xx++) {

//			r=sin(8*((xx*2)*sin(sec/2)+(yy*2)*cos(sec/4))+sec/8);

			r=sin(8*((xx*2)*sin(sec/2)+(yy*4)*cos(sec/4))+sec/128);




//			printf("%d %d %f %f %f %f\n",xx,yy,dx,dy,dv,r);
//			setcolor(COLOR(255*fabs(sin(dv*pi)),255*fabs(sin(dv*pi + 2*pi/3)),255*fabs(sin(dv*pi + 4*pi/3))));


				col=(int)((r+1)*8);
				if ((col<0) || (col>15)) {
					printf("Invalid color %d\n",col);
				}
				color_equals(color_lookup[col]);
				plot(xx,yy);
			}

		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);

		if (ch==' ') {
			while(1) {
				ch=grsim_input();
				if (ch) break;
			}
		}
		usleep(20000);

	}

	return 0;
}
