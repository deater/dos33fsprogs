#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int x,y,ch;

	grsim_init();

	home();

	gr();

	text();

	basic_htab(10);

	basic_vtab(10);

	basic_print("HELLO WORLD!\n");

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
