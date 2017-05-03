#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int x,y,ch;

	grsim_init();

	/* Title Screen */
	bload("../tfv/TITLE.GR",0x400);

	grsim_update();

	while(1) {

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);
	}

	return 0;
}
