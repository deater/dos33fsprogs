#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <math.h>

#include "../gr-sim.h"
#include "../tfv_zp.h"

#include "sin1024.h"

#define	MAXDOTS	256

static short gravitybottom;
static short gravity=0;
static short gravityd=16;

static short dot_x[MAXDOTS];
static short dot_y[MAXDOTS];
static short dot_z[MAXDOTS];
static short dot_yadd[MAXDOTS];

static short rotsin=0;
static short rotcos=0;



static void drawdots(void) {
	int temp32;
	int transx,transz;
	unsigned short ball_x,ball_y,shadow_y;
	unsigned short d,sc,newy;
	unsigned short ax;
	short signed_ax;

	for(d=0;d<MAXDOTS;d++) {


		/* https://en.wikipedia.org/wiki/3D_projection */

		transx=dot_x[d]*rotsin;
		transz=dot_z[d]*rotcos;
		temp32=transz-transx;
		sc=(temp32>>16)+9000;
		if (sc==0) sc=1;

		transx=dot_x[d]*rotcos;
		transz=dot_z[d]*rotsin;
		temp32=transx+transz;
		temp32>>=8;

		temp32=temp32+(temp32>>3);

		ball_x=(temp32/sc)/8;

		/* center */
		ball_x+=20;

		/* if off end of screen, no need for shadow */

		if (ball_x>39) continue;

		/**********/
		/* shadow */
		/**********/

		shadow_y=0x80000/sc/4;

		/* center it */
		shadow_y+=24;

		/* if shadow off screen, don't draw */
		if (shadow_y>47) continue;

		/* draw shadow */
		color_equals(0);
		plot( (ball_x),shadow_y);

		/********/
		/* ball */
		/********/

		dot_yadd[d]+=gravity;
		newy=dot_y[d]+dot_yadd[d];

		temp32=newy;
		if (temp32&0x8000) temp32|=0xffff0000;
		if (temp32>=gravitybottom) {
			//ax=-dot_yadd[d];
			temp32=(-dot_yadd[d])*gravityd;
			ax=temp32&0xffff;

			signed_ax=ax;
			ax=signed_ax>>4;

			dot_yadd[d]=ax;
			newy+=dot_yadd[d];
		}

		dot_y[d]=newy;

		/* sign extend */
		temp32=newy;
		if (temp32&0x8000) {
			temp32|=0xffff0000;
		}

		temp32<<=6;

		newy=temp32/sc/4;

		/* center */
		ball_y=newy+24;

		/* don't draw if off screen */
		if (ball_y>47) continue;

		/* plot ball */
		/* convert from 320x200 to 40x48 */
		color_equals(6);
		plot(ball_x,ball_y);

	}

	return;

}



static short isin(short deg) {
	return(sin1024[deg&1023]);
}

static short icos(short deg) {
	return(sin1024[(deg+256)&1023]);
}

static short dottaul[1024];

int main(int argc,char **argv) {

	short dropper;
	short frame=0;
	short rota=-1*64;
	short rot=0,rots=0;
	short a,b,c,d,i,j=0;
	short grav,gravd;
	short f=0;
	int ch;

	dropper=22000;
	grav=3;
	gravd=13;
	gravitybottom=8105;

	for(a=0;a<MAXDOTS;a++) {
		dottaul[a]=a;
	}

	for(a=0;a<MAXDOTS-12;a++) {
		b=rand()%MAXDOTS;
		c=rand()%MAXDOTS;
		d=dottaul[b];
		dottaul[b]=dottaul[c];
		dottaul[c]=d;
	}

	for(a=0;a<MAXDOTS;a++) {
		dot_x[a]=0;
		dot_y[a]=2560-dropper;
		dot_z[a]=0;
		dot_yadd[a]=0;
	}

	for(a=0;a<(MAXDOTS-12);a++) { // scramble
		b=rand()%MAXDOTS;
		c=rand()%MAXDOTS;
		d=dot_x[b]; dot_x[b]=dot_x[c]; dot_x[c]=d;
		d=dot_y[b]; dot_y[b]=dot_y[c]; dot_y[c]=d;
		d=dot_z[b]; dot_z[b]=dot_z[c]; dot_z[c]=d;
	}


	grsim_init();

	gr();

	clear_screens();
	soft_switch(MIXCLR);

	ram[DRAW_PAGE]=0;

	while(frame<1686) {

		/* re-draw background */
		color_equals(0);
		for(a=0;a<24;a++) hlin(0,0,40,a);
		color_equals(5);
		for(a=24;a<48;a++) hlin(0,0,40,a);

		frame++;
		if(frame==355) f=0;

		i=dottaul[j];
		j++; j%=MAXDOTS;

		/* initial spin */
		if(frame<355) {
//			dot[i].x=isin(f*11)*40;
//			dot[i].y=icos(f*13)*10-dropper;
//			dot[i].z=isin(f*17)*40;
			dot_x[i]=isin(f*8)*32;
			dot_y[i]=icos(f*16)*8-dropper;
			dot_z[i]=isin(f*16)*32;
			dot_yadd[i]=0;
		}
		/* bouncing ring */
		else if(frame<643) {
//			dot[i].x=icos(f*15)*55;
//			dot[i].y=dropper;
//			dot[i].z=isin(f*15)*55;
//			dot[i].yadd=-260;
			dot_x[i]=icos(f*16)*48;
			dot_y[i]=dropper;
			dot_z[i]=isin(f*16)*48;
			dot_yadd[i]=-260;
		}
		/* fountain */
		else if(frame<1214) {
//			a=sin1024[frame&1023]/8;
//			dot[i].x=icos(f*66)*a;
//			dot[i].y=8000;
//			dot[i].z=isin(f*66)*a;
//			dot[i].yadd=-300;
			a=sin1024[frame&1023]/8;
			dot_x[i]=icos(f*64)*a;
			dot_y[i]=8000;
			dot_z[i]=isin(f*64)*a;
			dot_yadd[i]=-300;
		}
		/* swirling */
		else if(frame<1686) {
			dot_x[i]=rand()-16384;
			dot_y[i]=8000-rand()/2;
			dot_z[i]=rand()-16384;
			dot_yadd[i]=0;
			if(frame>1357 && !(frame&31) && grav>0) grav--;
		}

		if(dropper>4000) dropper-=100;
//rotsin=0; rotcos=64;
		rotcos=icos(rot)*64; rotsin=isin(rot)*64;
		rots+=2;

		if(frame>1357) {
			rot+=rota/64;
			rota--;
		}
		else rot=isin(rots);

		f++;
		gravity=grav;
		gravityd=gravd;

		drawdots();

		grsim_update();

		/* approximate by 50Hz sleep */
		usleep(20000);

		ch=grsim_input();
		if (ch==27) {
			return 0;
		}

	}

	return 0;
}
