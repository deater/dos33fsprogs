#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"

// Based on BASIC program posted by FozzTexx
// 100 REM Fireworks by FozzTexx, originally written in 1987
// Constants: BT/RT is screen size, MG is margin
//120 REM Variables:
//130 REM XV/YV are velocity, PK is highest point of rocket
//140 REM MS is max steps, CS is current step, X/Y/X1/Y1/X2/Y2 is rocket position
//150 REM CL is Apple II hi-res color group

const int ysize=191,xsize=280,mg=24;
int cl;
int ms;
double x1,x2=0,ypos1,y2=0,cs,pk;
double xpos,ypos,x_velocity,y_velocity;
double i,n;

void routine_370(void) {
	hplot(xpos+x2+n,ypos+y2+n);
	hplot(xpos+x2-n,ypos+y2-n);

	hplot(xpos+x2+n,ypos+y2-n);
	hplot(xpos+x2-n,ypos+y2+n);

	hplot(xpos+x2,ypos+y2+(n*1.5));
	hplot(xpos+x2+(n*1.5),ypos+y2);

	hplot(xpos+x2,ypos+y2-(n*1.5));
	hplot(xpos+x2-(n*1.5),ypos+y2);

}

int main(int argc, char **argv) {

	int ch;

	grsim_init();

	home();

	// 160 HGR:POKE 49234,0:REM Poke hides 4 line text area
	hgr();

	//

label_180:
	cl=random()%2;
	x_velocity=(random()%3)+1;
	y_velocity=-((random()%5)+3);

	ms=(random()%25)+40;
	xpos=(random()%(xsize-mg*2))+mg;
	ypos=ysize;
	pk=ypos;

	/* Aim towards center of screen */
	if (xpos>xsize/2) x_velocity=-x_velocity;

	//210 REM Draw rocket

	for(cs=1;cs<=ms;cs++) {
		ypos1=y2;
		y2=ypos;
		x1=x2;
		x2=xpos;
		xpos=xpos+x_velocity;
		ypos=ypos+y_velocity;
		y_velocity=y_velocity+0.12;
		if (ypos<pk) pk=ypos;

		/* check if out of bounds and stop moving */
		if (xpos<=mg) {
			cs=ms;
//			printf("X too small!\n");
		}

		if (xpos>=(xsize-mg)) {
			cs=ms;
//			printf("X too big!\n");
		}

		if (ypos<=mg) {
			cs=ms;
//			printf("Y too small!\n");
		}

		if (y_velocity>0) {
			if (ypos>=ysize-mg) {
				cs=ms;
//				printf("Y too big %d > %d\n",y,ysize-mg);
			}
			if (ypos>ysize-(ysize-pk)/2) cs=ms;
		}

//		printf("cs=%d,ms=%d\n",cs,ms);
		if (cs<ms) {
			hcolor_equals(cl*4+3);
			hplot(x2,y2);
			hplot_to(xpos,ypos);

//			printf("C=%d, %d,%d to %d,%d... yv=%d\n",cl*4+3,
//				x2,y2,x,y,y_velocity);

		}
		hcolor_equals(cl*4);
		hplot(x1,ypos1);
		hplot_to(x2,y2);
//
//		printf("C=%d, %d,%d to %d,%d\n",cl*4,
//			x1,ypos1,x2,y2);

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(100000);

	}


label_290:
	//280 REM Draw explosion near X2,Y2
	x2=floor(x2);
	y2=floor(y2);
	xpos=(random()%20)-10;
	ypos=(random()%20)-10;
	hcolor_equals(cl*4+3);
	hplot(xpos+x2,ypos+y2);
	for(i=1;i<=9;i++) {
		if (i<9) {
			n=i;
			hcolor_equals(cl*4+3);
			routine_370();
		}
		n=i-1;
		hcolor_equals(cl*4);
		routine_370();

		grsim_update();
		ch=grsim_input();
		if (ch=='q') break;
		usleep(100000);
	}

	if (random()%2) goto label_290;

	goto label_180;


	return 0;
}


