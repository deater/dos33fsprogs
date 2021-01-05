#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int x,y,ch;

	grsim_init();

	home();
	gr();

	/* Put rainbow on screen */
	for(y=0;y<40;y++) for(x=0;x<40;x++) {
		color_equals(y%16);
		basic_plot(x,y);
	}

	color_equals(15);
	basic_vlin(0,39,20);

	color_equals(0);
	basic_hlin(0,39,20);

	printf("0: %d, 1: %d, 2: %d, 3: %d\n",
		scrn(0,0),scrn(1,1),scrn(2,2),scrn(3,3));
	printf("0: %d, 1: %d, 2: %d, 3: %d\n",
		scrn_page(0,0,0),scrn_page(1,1,0),scrn_page(2,2,0),scrn_page(3,3,0));

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
