#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"

static int row_color[40];

#define ELEMENTS	16

int set_row_color(double offset, int color) {

	int y,s;

	y=16.0*sin((offset)*2.0*3.14/16.0);
	if (y<0) s=-1; else if (y==0) s=0; else s=1;

	row_color[y+18]=color;
	row_color[y+s+18]=color;

	return 0;
}

int main(int argc, char **argv) {

	int ch,i=0,j,end=3;

	grsim_init();

	gr();
	clear_screens();

	while(1) {

		/* clear old colors */
		for(j=0;j<40;j++) row_color[j]=0;

		gr();

		set_row_color(i+1.75,14);	// aqua
		set_row_color(i+1.5,6);		// med-blue
		set_row_color(i+1.25,12);	// light-green
		set_row_color(i+1.0,4);		// green
		set_row_color(i+0.75,13);	// yellow
		set_row_color(i+0.5,9);		// orange
		set_row_color(i+0.25,11);	// pink
		set_row_color(i+0.0,1);		// red

		for(j=0;j<40;j++) {
			if (row_color[j]) {
				color_equals(row_color[j]);
				hlin(0,0,40,j);
			}
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(100000);


		i++;
		if (i>ELEMENTS-1) {
			i=0;
			end--;
			if (end==0) break;
		}
	}

	return 0;
}
