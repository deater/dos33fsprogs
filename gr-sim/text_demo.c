#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,i;
	char string[]="HELLO WORLD!";

	grsim_init();

	home();
	gr();

	basic_htab(10);
	basic_vtab(21);

	while(1) {
		ch=grsim_input();
		if (ch!=0) break;
	}

	while(1) {
		basic_htab(14);
		basic_vtab(21);
		basic_print(string);

		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
