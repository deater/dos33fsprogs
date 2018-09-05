#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "6502_emulate.h"
#include "gr-sim.h"

// Based on BASIC program posted by FozzTexx, originally written in 1987

//140 REM MS is max steps, CS is current step, X/Y/X1/Y1/X2/Y2 is rocket position
//150 REM CL is Apple II hi-res color group

const int ysize=160,xsize=280,margin=24;

double xpos;
int i,o;

signed char color_group,x_velocity,cs,max_steps;
unsigned char ypos_h,ypos_l;
signed char y_velocity_h;
unsigned char y_velocity_l;
unsigned char y_old=0,y_even_older;
unsigned char x_old=0,x_even_older;
unsigned char peak;

#define SEED 0
#define MAGIC "vW"	// $7657

/* based on Linear feedback shift register type of PRNG by White Flame	*/
/*	http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng	*/
void random_6502(void) {

	lda(SEED);			// lda seed
	if (a==0) goto lowZero;		// beq lowZero ; $0000 and $8000 are special values to test for
					// ; Do a normal shift
	asl_mem(SEED);			// asl seed
	lda(SEED+1);			// lda seed+1
	rol();				//  rol
	if (c==0) goto noEor;		// bcc noEor

doEor:
					// ; high byte is in .A
	a=a^0x76;			// eor #>magic
	ram[SEED+1]=a;			// sta seed+1
	lda(SEED);			// lda seed
	a=a^0x57;			// eor #<magic
	ram[SEED]=a;			// sta seed
	return;				//  rts


lowZero:
	lda(SEED+1);	// lda seed+1
	if (a==0) goto doEor;
			// beq doEor ; High byte is also zero, so apply the EOR
			// ; For speed, you could store 'magic' into 'seed' directly
			// ; instead of running the EORs

			//  ; wasn't zero, check for $8000
	asl();		//  asl
	if (a==0) goto noEor;
			//  beq noEor ; if $00 is left after the shift, then it was $80
	if (c==1) goto doEor;
			// bcs doEor ; else, do the EOR based on the carry bit as usual

noEor:
	ram[SEED+1]=a;	// sta seed+1

	return;		// rts
}

static void add16(unsigned char *a1h, unsigned char *a1l,
		unsigned char a2h,unsigned char a2l) {

	short i,j;

	i=(*a1h<<8)|(*a1l);
	j=(a2h<<8)|(a2l);
	i+=j;
	*a1h=i>>8;
	*a1l=i&0xff;

	return;
}

static void sadd16(signed char *a1h, unsigned char *a1l,
		unsigned char a2h,unsigned char a2l) {

	short i,j;

	i=(*a1h<<8)|(*a1l);
	j=(a2h<<8)|(a2l);
	i+=j;
	*a1h=i>>8;
	*a1l=i&0xff;

	return;
}


void routine_370(void) {

	hplot(xpos+o,ypos_h+o);		// NE
	hplot(xpos-o,ypos_h-o);		// SW

	hplot(xpos+o,ypos_h-o);		// SE
	hplot(xpos-o,ypos_h+o);		// NW

	hplot(xpos,ypos_h+(o*1.5));		// N
	hplot(xpos+(o*1.5),ypos_h);		// E

	hplot(xpos,ypos_h-(o*1.5));		// S
	hplot(xpos-(o*1.5),ypos_h);		// W

}

int main(int argc, char **argv) {

	int ch;

	grsim_init();

	for(i=0;i<100;i++) {
		random_6502();
		printf("%02x%02x\n",ram[SEED+1],ram[SEED]);
	}

	home();

	hgr();
	soft_switch(MIXCLR);	// Full screen

label_180:
	random_6502();
	color_group=ram[SEED]&1;		// HGR color group (PG or BO)
	random_6502();
	x_velocity=(ram[SEED]&0x3)+1;		// x velocity = 1..4
	random_6502();
	y_velocity_h=-((ram[SEED]&0x3)+3);	// y velocity = -3..-6
	y_velocity_l=0;

	random_6502();
	max_steps=(ram[SEED]&0x1f)+33;		// 33..64

	/* launch from the two hills */
	random_6502();
	xpos=ram[SEED]&0x3f;
	random_6502();
	if (ram[SEED]&1) {
		xpos+=24;			// 24-88 (64)
	}
	else {
		xpos+=191;			// 191-255 (64)
	}


	ypos_h=ysize;				// start at ground
	ypos_l=0;

	peak=ypos_h;				// peak starts at ground?

	/* Aim towards center of screen */
	/* TODO: merge this with hill location? */
	if (xpos>xsize/2) {
		x_velocity=-x_velocity;
	}

	/* Draw rocket */
	for(cs=1;cs<=max_steps;cs++) {
		y_even_older=y_old;
		y_old=ypos_h;
		x_even_older=x_old;
		x_old=xpos;

		/* Move rocket */
		xpos=xpos+x_velocity;

		/* 16 bit add */
		add16(&ypos_h,&ypos_l,y_velocity_h,y_velocity_l);

		/* adjust Y velocity, slow it down */
//		c=0;
//		a=y_velocity_l;
//		adc(0x20);		// 0x20 = 0.125
//		y_velocity_l=a;
//		a=y_velocity_h;
//		adc(0);
//		y_velocity_h=a;
		sadd16(&y_velocity_h,&y_velocity_l,0x00,0x20);

		/* if we went higher, adjust peak */
		if (ypos_h<peak) peak=ypos_h;

		/* check if out of bounds and stop moving */
		if (xpos<=margin) {
			cs=max_steps;		// too far left
		}

		if (xpos>=(xsize-margin)) {
			cs=max_steps;		// too far right
		}

		if (ypos_h<=margin) {
			cs=max_steps;		// too far up
		}


		// if falling downward
		if (y_velocity_h>0) {
			// if too close to ground, explode
			if (ypos_h>=ysize-margin) {
				cs=max_steps;
			}
			// if fallen a bit past peak, explode
			if (ypos_h>ysize-(ysize-peak)/2) {
				cs=max_steps;
			}
		}

		// if not done, draw rocket
		if (cs<max_steps) {
			hcolor_equals(color_group*4+3);
			hplot(x_old,y_old);
			hplot_to(xpos,ypos_h);

		}
		// erase with proper color black
		hcolor_equals(color_group*4);
		hplot(x_even_older,y_even_older);
		hplot_to(x_old,y_old);

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(50000);

	}


label_290:
	/* Draw explosion near x_old, y_old */
	xpos=floor(x_old);
	ypos_h=floor(y_old);

	xpos+=(random()%20)-10;	// x +/- 10
	ypos_h+=(random()%20)-10;	// y +/- 10

	hcolor_equals(color_group*4+3);	// draw white (with fringes)

	hplot(xpos,ypos_h);	// draw at center of explosion

	/* Spread the explosion */
	for(i=1;i<=9;i++) {
		/* Draw spreading dots in white */
		if (i<9) {
			o=i;
			hcolor_equals(color_group*4+3);
			routine_370();
		}
		/* erase old */
		o=i-1;
		hcolor_equals(color_group*4);
		routine_370();

		grsim_update();
		ch=grsim_input();
		if (ch=='q') break;
		usleep(50000);
	}

	/* randomly draw more explosions */
	if (random()%2) goto label_290;

	goto label_180;


	return 0;
}
