#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,i=0;

	int y=0;

	grsim_init();

	gr();

	while(1) {
		gr();

		i++;
		y=8.0*sin(i*2.0*3.14/16.0);

		printf("%d %d\n",i,y);

		color_equals(1);		// red
		hlin(0,0,40,y+18);
		color_equals(11);		// pink
		hlin(0,0,40,6);
		color_equals(9);		// orange
		hlin(0,0,40,7);
		color_equals(13);		// yellow
		hlin(0,0,40,8);


		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(50000);

		if (i>15) i=0;
	}

	return 0;
}
