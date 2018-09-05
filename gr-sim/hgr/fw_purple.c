#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"

// Based on BASIC program posted by FozzTexx, originally written in 1987

//140 REM MS is max steps, CS is current step, X/Y/X1/Y1/X2/Y2 is rocket position
//150 REM CL is Apple II hi-res color group

const int ysize=160,xsize=280,margin=24;
int color_group;
int max_steps;
double x_even_older,x_old=0,y_even_older,y_old=0,cs,peak;
double xpos,ypos,x_velocity,y_velocity;
double i,n;

void routine_370(void) {

	hplot(xpos+n,ypos+n);		// NE
	hplot(xpos-n,ypos-n);		// SW

	hplot(xpos+n,ypos-n);		// SE
	hplot(xpos-n,ypos+n);		// NW

	hplot(xpos,ypos+(n*1.5));		// N
	hplot(xpos+(n*1.5),ypos);		// E

	hplot(xpos,ypos-(n*1.5));		// S
	hplot(xpos-(n*1.5),ypos);		// W

}

int main(int argc, char **argv) {

	int ch;

	grsim_init();

	home();

	hgr();
	soft_switch(MIXCLR);	// Full screen

label_180:
	color_group=random()%2;			// HGR color group (PG or BO)
	x_velocity=(random()%3)+1;		// x velocity = 1..3
	y_velocity=-((random()%5)+3);		// y velocity = -3..-7

	max_steps=(random()%25)+40;		// 40..64

	xpos=(random()%(xsize-margin*2))+margin;
						// margin .. xsize-margin
	ypos=ysize;				// start at ground
	peak=ypos;				// peak starts at ground?

	/* Aim towards center of screen */
	if (xpos>xsize/2) x_velocity=-x_velocity;

	/* Draw rocket */
	for(cs=1;cs<=max_steps;cs++) {
		y_even_older=y_old;
		y_old=ypos;
		x_even_older=x_old;
		x_old=xpos;

		/* Move rocket */
		xpos=xpos+x_velocity;
		ypos=ypos+y_velocity;

		/* adjust Y velocity, slow it down */
		y_velocity=y_velocity+0.125;

		/* if we went higher, adjust peak */
		if (ypos<peak) peak=ypos;

		/* check if out of bounds and stop moving */
		if (xpos<=margin) {
			cs=max_steps;		// too far left
		}

		if (xpos>=(xsize-margin)) {
			cs=max_steps;		// too far right
		}

		if (ypos<=margin) {
			cs=max_steps;		// too far up
		}


		// if falling downward
		if (y_velocity>0) {
			// if too close to ground, explode
			if (ypos>=ysize-margin) {
				cs=max_steps;
			}
			// if fallen a bit past peak, explode
			if (ypos>ysize-(ysize-peak)/2) {
				cs=max_steps;
			}
		}

		// if not done, draw rocket
		if (cs<max_steps) {
			hcolor_equals(color_group*4+3);
			hplot(x_old,y_old);
			hplot_to(xpos,ypos);

		}
		// erase with proper color black
		hcolor_equals(color_group*4);
//		hcolor_equals(6);
		hplot(x_even_older,y_even_older);
		hplot_to(x_old,y_old);

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(100000);

	}


label_290:
	/* Draw explosion near x_old, y_old */
	x_old=floor(x_old);
	y_old=floor(y_old);

	xpos=(random()%20)-10;	// x +/- 10
	ypos=(random()%20)-10;	// y +/- 10

	xpos+=x_old;
	ypos+=y_old;

	hcolor_equals(color_group*4+3);	// draw white (with fringes)

	hplot(xpos,ypos);	// draw at center of explosion

	/* Spread the explosion */
	for(i=1;i<=9;i++) {
		/* Draw spreading dots in white */
		if (i<9) {
			n=i;
			hcolor_equals(color_group*4+3);
			routine_370();
		}
		/* erase old */
		n=i-1;
		hcolor_equals(color_group*4);
		routine_370();

		grsim_update();
		ch=grsim_input();
		if (ch=='q') break;
		usleep(100000);
	}

	/* randomly draw more explosions */
	if (random()%2) goto label_290;

	goto label_180;


	return 0;
}
