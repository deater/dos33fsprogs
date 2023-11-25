#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <math.h>

#include "8086_emulator.h"
#include "vga_emulator.h"

#include "../gr-sim.h"
#include "../tfv_zp.h"

#include "sin1024.h"

#define	MAXDOTS	1024

#define SKIP	2

static short gravitybottom;
static short bpmin=30000;
static short bpmax=-30000;
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

//	cx=dotnum;			// mov	cx,cs:_dotnum
//	si=0;				// mov	si,OFFSET dot

	for(si=0;si<512;si+=SKIP) {
//	push(cx);			// push	cx
	ax=dot[si].x;			// mov	ax,ds:[si+0] ;X
	imul_16(rotsin);		// imul	ds:_rotsin
	ax=ax;				// mov	ax,ax
	cx=dx;				// mov	cx,dx
	ax=dot[si].z;			// mov	ax,ds:[si+4] ;Z
	imul_16(rotcos);		// imul	ds:_rotcos
	ax=ax-bx;			// sub	ax,bx
	dx=dx-cx;			// sub	dx,cx
	bp=dx;				// mov	bp,dx
	bp=bp+9000;			// add	bp,9000

	ax=dot[si].x;			// mov	ax,ds:[si+0] ;X
	imul_16(rotcos);		// imul	ds:_rotcos
	bx=ax;				// mov	bx,ax
	cx=dx;				// mov	cx,dx
	ax=dot[si].z;			// mov	ax,ds:[si+4] ;Z
	imul_16(rotsin);		// imul	ds:_rotsin

	temp32=ax+bx;			// add	ax,bx
	ax=ax+bx;			//
	dx=dx+cx;			// adc	dx,cx
	if (temp32&(1<<16)) dx=dx+1;

	ax=(ax>>8)|(dx<<8);		// shrd	ax,dx,8
	dx=sar(dx,8);			// sar	dx,8

	bx=ax;				// mov	bx,ax
	cx=dx;				// mov	cx,dx
	ax=(ax>>3)|(dx<<13);		// shrd	ax,dx,3

	dx=sar(dx,3);			// sar	dx,3
	temp32=ax+bx;			// add	ax,bx
	ax=ax+bx;
	dx=dx+cx;			// adc	dx,cx
	if (temp32&(1<<16)) dx=dx+1;

	temp32=(dx<<16)|(ax&0xfffff);
	idiv_16(bp);			// idiv bp
	ax=ax+160;			// add	ax,160
	push(ax);			// push	ax

	/* if off end of screen, no need for shadow */

	if (ax>319) goto label2;	// cmp	ax,319

					// ja	@@2
	/**********/
	/* shadow */
	/**********/

	ax=0;				// xor	ax,ax
	dx=8;				// mov	dx,8
	idiv_16(bp);			// idiv	bp
	ax=ax+100;			// add	ax,100

	/* if shadow off screen, don't draw */
	if (ax>199) goto label2;	// cmp	ax,199
					// ja	@@2
	bx=ax;				// mov	bx,ax

	// not needed, it's a C array
	//bx=bx<<1;			// shl	bx,1
	bx=rows[bx];			// mov	bx,ds:_rows[bx]
	ax=pop();			// pop	ax
	bx=bx+ax;			// add	bx,ax
	push(ax);			// push	ax


	/* draw shadow */

//	bx/320 -> 200     200->48  *48/200

	yy=((bx/320)*48)/200;
	color_equals(0);
	plot( (bx%320)/8,yy);

	/********/
	/* ball */
	/********/

	dot[si].yadd+=gravity;
	ax=dot[si].y+dot[si].yadd;

	temp32=ax;
	if (temp32&0x8000) temp32|=0xffff0000;
	if (temp32<gravitybottom) goto label4; //cmp	ax,ds:_gravitybottom
					// jl	@@4

	push(ax);			// push	ax
	ax=-dot[si].yadd;
	imul_16(gravityd);		// imul	cs:_gravityd
	ax=sar(ax,4);			// sar	ax,4
	dot[si].yadd=ax;		// mov	ds:[si+14],ax
	ax=pop();			// pop	ax
	ax+=dot[si].yadd;		// add	ax,ds:[si+14]

label4:
	dot[si].y=ax;			// mov	ds:[si+2],ax
	if (ax&0x8000) {		// cwd
		dx=0xffff;
	}
	else {
		dx=0;
	}
	dx=(dx<<6)|(ax>>10);		// shld	dx,ax,6
	ax=ax<<6;			// shl	ax,6
	idiv_16(bp);			// idiv	bp
	ax=ax+100;			// add	ax,100
	if (ax>199) goto label3;	// cmp	ax,199
					// ja	@@3
	bx=ax;				// mov	bx,ax

	// not needed, C array
	//bx=bx<<1;			// shl	bx,1
	bx=rows[bx];			// mov	bx,ds:_rows[bx]

	ax=pop();			// pop	ax
	push(ax);
	bx=bx+ax;			// add	bx,ax
	bp=bp>>6;		// shr	bp,6
	bp=bp&(~3L);		// and	bp,not 3

	temp32=bp;
	if (temp32&0x8000) temp32|=0xffff0000;
	if (temp32>=bpmin) goto label_t1;	// cmp	bp,cs:_bpmin
					// jge	@@t1
	bpmin=bp;			// mov	cs:_bpmin,bp
label_t1:
	temp32=bp;
	if (temp32&0x8000) temp32|=0xffff0000;
	if (temp32<=bpmax) goto label_t2;	// cmp	bp,cs:_bpmax
					// jle	@@t2
	bpmax=bp;			// mov	cs:_bpmax,bp
label_t2:
	yy=((bx/320)*48)/200;
	color_equals(6);
	plot( (bx%320)/8,yy);
label2:
label3:
	bx=pop();			// pop	bx

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
