#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,i;
	char output[BUFSIZ];

	grsim_init();

	home();

	gr();

	text();

	basic_htab(10);

	basic_vtab(10);

	basic_print("HELLO WORLD!\r\r");

	for(i=0;i<128;i++) {
		sprintf(output,"%c",i);
		basic_print(output);
	}

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
