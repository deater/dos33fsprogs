#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "tfv_zp.h"
#include "gr-sim.h"
                  //    0  1  2 3 4 5 6 7
unsigned char colors[]={15,13,9,1,8,5,0,0};
                  //     0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
unsigned char reverse[]={6,3,6,6,6,5,6,6,4,2,6, 6, 6, 1, 6, 0};

int main(int argc, char **argv) {

	int ch,xx,yy,col,r;

	grsim_init();

	gr();
	clear_screens();

	color_equals(15);
	hlin(0,0,40,39);

	ram[DRAW_PAGE]=0x0;

	while(1) {


		for(yy=0;yy<39;yy++) {
			for(xx=1;xx<39;xx++) {

				r=rand()&3;

				col=scrn(xx,yy+1);
				col=reverse[col];
				color_equals(colors[col+(r&1)]);
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
