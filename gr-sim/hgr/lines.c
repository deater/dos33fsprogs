#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int yy,ch;

	grsim_init();

	home();

	hgr();


	/* Put lines on screen */
	for(yy=0;yy<100;yy++) {
		hcolor_equals(yy%8);
		hplot(yy,yy);
		hplot_to(200,yy);
	}

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
