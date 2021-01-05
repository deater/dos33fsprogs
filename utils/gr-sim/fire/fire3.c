#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "tfv_zp.h"
#include "gr-sim.h"
                         //    0  1  2 3 4 5 6 7
static unsigned char colors[]={0,0,5,8,1,9,13,15};

#define YSIZE	20

static unsigned char framebuffer[YSIZE][80];




int main(int argc, char **argv) {

	int ch,xx,yy,col,newc,r;
	int i,j;

	grsim_init();

	gr();
	clear_screens();

	for(j=0;j<YSIZE-1;j++)
		for(i=0;i<80;i++)
			framebuffer[j][i]=0x0;

	for(i=0;i<80;i++) framebuffer[YSIZE-1][i]=0x7;

	ram[DRAW_PAGE]=0x0;

	while(1) {

		/* activate fire */
		for(yy=0;yy<YSIZE-1;yy++) {
			for(xx=0;xx<80;xx++) {
				r=rand()&2;
				if (r==0) r=-1;
				else if (r==3) r=1;
				else r=0;

				newc=framebuffer[yy+1][xx+r]-
					(rand()&1);
				if (newc<0) newc=0;
				framebuffer[yy][xx]=newc;
			}
		}

		/* copy to framebuffer */
		for(yy=0;yy<YSIZE;yy++) {
			for(xx=0;xx<80;xx+=2) {
				col=((framebuffer[yy][xx]+
						framebuffer[yy][xx+1])/2);
//				if (xx==0) printf("Row %d color=%d\n",yy,col/2);
				color_equals(colors[col]);
				plot(xx/2,yy+(23-(YSIZE/2)));
			}
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(40000);

	}

	return 0;
}
