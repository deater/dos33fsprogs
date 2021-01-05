#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "tfv_zp.h"
#include "gr-sim.h"
                         //    0  1  2 3 4 5 6 7
//static unsigned char colors[]={0,0,5,8,1,9,13,15};
//{15,14,7,6,2,3,0,0};
static unsigned char colors[]={0,0,3,2,6,7,14,15};

#define YSIZE	20

static unsigned char framebuffer[YSIZE][40];




int main(int argc, char **argv) {

	int ch,xx,yy,col,newc,r,q;
	int i,j,line=1;

	int a=0xf, b=0x8, c=0x0;
	int volume;

	grsim_init();

	gr();
	clear_screens();

	for(j=0;j<YSIZE-1;j++)
		for(i=0;i<40;i++)
			framebuffer[j][i]=0x0;

	for(i=0;i<40;i++) framebuffer[YSIZE-1][i]=0x7;

	ram[DRAW_PAGE]=0x0;

	while(1) {

		/* activate fire */
		for(yy=0;yy<YSIZE-1;yy++) {
			for(xx=0;xx<40;xx++) {

				if (xx<13) volume=a;
				else if (xx<26) volume=b;
				else volume=c;

				/* R is left/right movement */
				r=rand()&3;

				if (r==0) r=-1;
				else if (r==3) r=1;
				else r=0;

				if (xx==0) r=0;
				if (xx==39) r=0;


				/* Q is up propogate speed movement */

				q=rand()&3;
				if (volume<6) {
					/* Q=1 3/4 of time */
					if (q==0) q=0;
					else q=1;
				}
				else if (volume<12) {
					/* Q=1 1/2 of time */
					if (q<2) q=0;
					else q=1;
				}
				else {
					/* Q=1 1/4 of time */
					if (q<3) q=0;
					else q=1;
				}

				newc=framebuffer[yy+1][xx+r]-
					q;
				if (newc<0) newc=0;
				framebuffer[yy][xx]=newc;
			}
		}

		/* copy to framebuffer */
		for(yy=0;yy<YSIZE;yy++) {
			for(xx=0;xx<40;xx+=1) {
				col=framebuffer[yy][xx];
//				if (xx==0) printf("Row %d color=%d\n",yy,col/2);
				color_equals(colors[col]);
				plot(xx,yy+(23-(YSIZE/2)));
			}
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(20000);

		if (ch==' ') {
			line=!line;
			if (line==1)
				for(i=0;i<40;i++) framebuffer[YSIZE-1][i]=0x7;
			else
				for(i=0;i<40;i++) framebuffer[YSIZE-1][i]=0x0;

		}

	}

	return 0;
}
