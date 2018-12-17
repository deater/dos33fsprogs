#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <fcntl.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,fd;

	grsim_init();

	home();

	hgr();
	/* Show all 280x192, no bottom text */
        soft_switch(MIXCLR);

	fd=open("MERRY.BIN",O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x2000],8192);
	close(fd);

	grsim_update();

	while(1) {
		ch=grsim_input();
		if (ch) break;
		usleep(100000);
	}

	fd=open("BALLC.BIN",O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x2000],8192);
	close(fd);

	grsim_update();

	while(1) {
		ch=grsim_input();
		if (ch) break;
		usleep(100000);
	}


	return 0;
}
