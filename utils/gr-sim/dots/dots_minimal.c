#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <math.h>

#include "../gr-sim.h"
#include "../tfv_zp.h"

#include "sin1024.h"

#define	MAXDOTS	512

#define SKIP	2

static short gravitybottom;
//static short bpmin=30000;
//static short bpmax=-30000;
static short gravity=0;
static short dotnum=0;
static short gravityd=16;

static short rows[200];

static struct {
	short	x;	// 0
	short	y;	// 2
	short	z;	// 4
	short	yadd;	// 14
} dot[MAXDOTS];

static short rotsin=0;
static short rotcos=0;

static void drawdots(void) {
	int temp32;
	int yy;
	unsigned short ball_x,ball_y,shadow_y;
	unsigned short d,distance,newy;
	unsigned short ax;
	short signed_ax;

	for(d=0;d<512;d+=SKIP) {

		temp32=(dot[d].z*rotcos)-(dot[d].x*rotsin);
		distance=(temp32>>16)+9000;
		if (distance==0) distance=1;

		temp32=((dot[d].x*rotcos)+(dot[d].z*rotsin));
		temp32>>=8;

                temp32=temp32+(temp32>>3);

                ball_x=(temp32/distance);

		/* center */
		ball_x+=160;

		/* if off end of screen, no need for shadow */
		if (ball_x>319) continue;

		/**********/
		/* shadow */
		/**********/

		shadow_y=0x80000/distance;

		/* center it */
		shadow_y+=100;

		/* if shadow off screen, don't draw */
		if (shadow_y>199) continue;

		/* draw shadow */
		yy=(shadow_y*48)/200;
		color_equals(0);
		plot( (ball_x)/8,yy);

		/********/
		/* ball */
		/********/

		dot[d].yadd+=gravity;
		newy=dot[d].y+dot[d].yadd;

		temp32=newy;
		if (temp32&0x8000) temp32|=0xffff0000;
		if (temp32>=gravitybottom) {
			temp32=(-dot[d].yadd)*gravityd;
			ax=temp32&0xffff;

			signed_ax=ax;
			ax=signed_ax>>4;

			dot[d].yadd=ax;
			newy+=dot[d].yadd;
		}

		dot[d].y=newy;

		/* sign extend */
		temp32=newy;
		if (temp32&0x8000) {
			temp32|=0xffff0000;
		}

		temp32<<=6;

		newy=temp32/distance;

		/* center */
		ball_y=newy+100;		// add	ax,100

		/* don't draw if off screen */
		if (ball_y>199) continue;

		/* plot ball */
		/* convert from 320x200 to 40x48 */
		yy=(ball_y*48)/200;
		color_equals(6);
		plot(ball_x/8,yy);

	}

	return;

}


/* wait for VGA border start */
static short dis_waitb(void) {

	/* approximate by 70Hz sleep */
	usleep(14286);

	return 1;
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

	dotnum=512;
	for(a=0;a<dotnum;a++) {
		dottaul[a]=a;
	}

	for(a=0;a<500;a++) {
		b=rand()%dotnum;
		c=rand()%dotnum;
		d=dottaul[b];
		dottaul[b]=dottaul[c];
		dottaul[c]=d;
	}

	dropper=22000;

	for(a=0;a<dotnum;a++) {
		dot[a].x=0;
		dot[a].y=2560-dropper;
		dot[a].z=0;
		dot[a].yadd=0;
	}

	grav=3;
	gravd=13;
	gravitybottom=8105;
	i=-1;

	for(a=0;a<500;a++) { // scramble
		b=rand()%dotnum;
		c=rand()%dotnum;
		d=dot[b].x; dot[b].x=dot[c].x; dot[c].x=d;
		d=dot[b].y; dot[b].y=dot[c].y; dot[c].y=d;
		d=dot[b].z; dot[b].z=dot[c].z; dot[c].z=d;
	}

	/* setup rows lookup table */
	for(a=0;a<200;a++) {
		rows[a]=a*320;
	}


	grsim_init();

	gr();

	clear_screens();
	soft_switch(MIXCLR);

	ram[DRAW_PAGE]=0;

	while(frame<2360) {

		/* re-draw background */
		color_equals(0);
		for(a=0;a<24;a++) hlin(0,0,40,a);
		color_equals(5);
		for(a=24;a<48;a++) hlin(0,0,40,a);

		frame++;
		if(frame==500) f=0;

		i=dottaul[j];
		j++; j%=dotnum;

		/* initial spin */
		if(frame<500) {
			dot[i].x=isin(f*11)*40;
			dot[i].y=icos(f*13)*10-dropper;
			dot[i].z=isin(f*17)*40;
			dot[i].yadd=0;
		}
		/* bouncing ring */
		else if(frame<900) {
			dot[i].x=icos(f*15)*55;
			dot[i].y=dropper;
			dot[i].z=isin(f*15)*55;
			dot[i].yadd=-260;
		}
		/* fountain */
		else if(frame<1700) {
			a=sin1024[frame&1023]/8;
			dot[i].x=icos(f*66)*a;
			dot[i].y=8000;
			dot[i].z=isin(f*66)*a;
			dot[i].yadd=-300;
		}
		/* swirling */
		else if(frame<2360) {
			dot[i].x=rand()-16384;
			dot[i].y=8000-rand()/2;
			dot[i].z=rand()-16384;
			dot[i].yadd=0;
			if(frame>1900 && !(frame&31) && grav>0) grav--;
		}

		if(dropper>4000) dropper-=100;

		rotcos=icos(rot)*64; rotsin=isin(rot)*64;
		rots+=2;

		if(frame>1900) {
			rot+=rota/64;
			rota--;
		}
		else rot=isin(rots);

		f++;
		gravity=grav;
		gravityd=gravd;

		drawdots();

		grsim_update();

		dis_waitb();

		ch=grsim_input();
		if (ch==27) {
			return 0;
		}

	}

	return 0;
}
