/* for demoscene, you need a plasma effect... */
/* https://rosettacode.org/wiki/Plasma_effect */
/* https://www.bidouille.org/prog/plasma */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "tfv_zp.h"
#include "gr-sim.h"

#define PI 3.14159265358979323846264338327950


#if 1
static unsigned char color_lookup[]={0x0, 0x0, 0x5, 0x5,
				     0x7, 0x7, 0xf, 0xf,
				     0x7, 0x7, 0x6, 0x6,
				     0x2, 0x2, 0x5, 0x5};
#else

static unsigned char color_lookup[]={0x0, 0x5, 0x7, 0xf,
				     0x7, 0x6, 0x2, 0x5,
				     0x0, 0x5, 0x7, 0xf,
				     0x7, 0x6, 0x2, 0x5};

#endif

static int offscreen[40][40];

static int sintable[16];

int main(int argc, char **argv) {

	int ch,xx,yy,col;

	grsim_init();

	gr();
	soft_switch(MIXCLR);

	clear_screens();

	ram[DRAW_PAGE]=0x0;

	for(xx=0;xx<16;xx++) {
		sintable[xx]=8.0*sin(xx*PI/8.0);
//		printf("%2lf\n",(double)sintable[xx]);
		printf("%02X\n",sintable[xx]);
	}

	for(yy=0;yy<40;yy++) {
	for(xx=0;xx<40;xx++) {

//	col = ( 32.0 + (32.0 * sin(xx / 4.0))
  //            + 32.0 + (32.0 * sin(yy / 4.0))
    //          ) / 2;


//	col = ( 8.0 + (8.0 * sin(xx *PI/8.0))
//            + 8.0 + (8.0 * sin(yy *PI/8.0))
//              ) / 2;



	col = ( 8.0 + (sintable[xx&0xf])
            + 8.0 + (sintable[yy&0xf])
              ) / 2;

	printf("%d %d: %lf %lf\n",xx,yy,8.0*sin(xx*PI/8.0),(double)sintable[xx&0xf]);

			offscreen[xx][yy]=col;
		}
	}

	while(1) {
		for(yy=0;yy<40;yy++) {
			for(xx=0;xx<40;xx++) {
				col=offscreen[xx][yy];
				color_equals(color_lookup[col]);
				col++;
				col&=0xf;
				offscreen[xx][yy]=col;
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
		usleep(200000);
	}


	return 0;
}
