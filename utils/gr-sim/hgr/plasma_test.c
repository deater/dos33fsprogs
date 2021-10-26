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


int sine_lookup[64];

#if 0
static unsigned char color_lookup[]={0x0, 0x0, 0x1, 0x1,
				     0x2, 0x2, 0x3, 0x3,
				     0x4, 0x4, 0x5, 0x5,
				     0x6, 0x6, 0x7, 0x7};
#else
static unsigned char color_lookup[]={0x0, 0x0, 0x0, 0x1,
				     0x1, 0x1, 0x2, 0x2,
				     0x2, 0x3, 0x3, 0x3,
				     0x2, 0x2, 0x1, 0x1};

#endif

int main(int argc, char **argv) {

	int ch,xx,yy,col;

	grsim_init();

	home();

	hgr();

	soft_switch(MIXCLR);

	clear_screens();

	ram[DRAW_PAGE]=0x0;

	for(xx=0;xx<64;xx++) {

		sine_lookup[xx]=32.0*sin( (xx*2*PI)/64);

	}

	int offset=0;

	while(1) {

	for(yy=0;yy<192;yy++) {
		for(xx=0;xx<40;xx++) {

		 	col = (int)
    		( 128.0 + sine_lookup[ (int)(xx+offset)&0x3f ]
			+ sine_lookup[ (int)(xx)&0x3f ]
          		+ sine_lookup[ (int)((yy/4)-offset)&0x3f ]
//		          + sine_lookup[ (int)((xx + yy)/4)&0x3f ]
    		) ;


			col+=offset;

			hcolor_equals(color_lookup[col&0xf]);

			hplot(xx*7,yy);
			hplot_to((xx*7)+6,yy);
		}
	}
	offset++;
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
