#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int x,y,ch;

	grsim_init();

	/* Put rainbow on screen */
	for(y=0;y<40;y++) for(x=0;x<40;x++) {
		color_equals(y%16);
		plot(x,y);
	}

	color_equals(15);
	vlin(0,40,20);

	color_equals(0);
	hlin(0,40,20);


	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
