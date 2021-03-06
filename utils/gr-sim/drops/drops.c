/* Based on https://twitter.com/seban_slt/status/1349084515755548676
   https://github.com/seban-slt/Atari8BitBot/blob/master/ASM/water/water.m65 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"
#include "tfv_zp.h"

#define XSIZE	40
#define YSIZE	48

static unsigned char buffer1[XSIZE*YSIZE];
static unsigned char buffer2[XSIZE*YSIZE];
static unsigned int frame=0;


static void update_frame2(void) {
	int xx,temp;

	for(xx=1;xx<(XSIZE*YSIZE)-1;xx++) {
		temp =buffer1[xx+1];
		temp+=buffer1[xx-1];
		if (xx>XSIZE) temp+=buffer1[xx-XSIZE];
		if (xx<(XSIZE-1)*YSIZE) temp+=buffer1[xx+XSIZE];
		temp/=2;
		temp-=buffer2[xx];
		if (temp<0) temp=-temp;
		buffer2[xx]=temp;
	}
	return;

}

static void update_frame1(void) {
	int xx,temp;

	for(xx=1;xx<(XSIZE*YSIZE)-1;xx++) {
		temp =buffer2[xx+1];
		temp+=buffer2[xx-1];
		if (xx>XSIZE) temp+=buffer2[xx-XSIZE];
		if (xx<(XSIZE-1)*YSIZE) temp+=buffer2[xx+XSIZE];
		temp/=2;
		temp-=buffer1[xx];
		if (temp<0) temp=-temp;
		buffer1[xx]=temp;
	}
	return;

}

static void plot_frame1(void) {

	int xx,yy,c;

	for(yy=0;yy<YSIZE;yy++) {
		for(xx=0;xx<XSIZE;xx++) {
			c=buffer1[yy*XSIZE+xx];
			c/=2;
			if (c==0) c=0;
			else if (c==1) c=2;
			else if (c==2) c=6;
			else if (c==3) c=14;
			else if (c==4) c=7;
			else c=15;
			color_equals(c);
			plot(xx,yy);
		}
	}
}

static void plot_frame2(void) {

	int xx,yy,c;

	for(yy=0;yy<YSIZE;yy++) {
		for(xx=0;xx<XSIZE;xx++) {
			c=buffer1[yy*XSIZE+xx];
			c/=2;
			if (c==0) c=0;
			else if (c==1) c=2;
			else if (c==2) c=6;
			else if (c==3) c=14;
			else if (c==4) c=7;
			else c=15;
			color_equals(c);
			plot(xx,yy);
		}
	}
}



int main(int argc, char **argv) {

	int xx,yy;
	int ch;

	grsim_init();

	gr();

	clear_screens();

	ram[DRAW_PAGE]=0;

	frame=0;

	while(1) {

		if (frame&1) {
			update_frame1();
			plot_frame1();
		}
		else {
			update_frame2();
			plot_frame2();
		}

		if ((frame&0x1f)==0) {

			xx=rand()%XSIZE;
			yy=rand()%YSIZE;

			if (xx==0) xx++;
			if (yy==0) yy++;
			if (xx>XSIZE-1) xx--;
			if (yy>YSIZE-1) yy--;


			buffer1[yy*XSIZE+xx]=0x1f;
			buffer1[yy*XSIZE+xx+1]=0x1f;
			buffer1[yy*XSIZE+xx-1]=0x1f;
			buffer1[(yy+1)*XSIZE+xx]=0x1f;
			buffer1[(yy-1)*XSIZE+xx]=0x1f;

		}

		grsim_update();

		usleep(60000);
		frame++;

		ch=grsim_input();
		if (ch=='q') return 0;
		if (ch==27) return 0;
	}

	return 0;
}
