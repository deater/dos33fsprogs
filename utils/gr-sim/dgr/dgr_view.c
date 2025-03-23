#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <fcntl.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,fd;

	if (argc<2) {
		fprintf(stderr,"Usage: dhgr_view FILENAME.AUX FILENAME.MAIN\n");
		fprintf(stderr,"  where FILENAME AUX/MAIN are 8k AppleII DHIRES dumps\n\n");
	}

	grsim_init();

	home();

	soft_switch(SET_GR);
	soft_switch(LORES);
	soft_switch(FULLGR);
	soft_switch_write(CLRAN3);
	soft_switch_write(SET80_COL);
	soft_switch_write(EIGHTY_COLON);

	soft_switch(SET_PAGE2);

	/* Load AUX RAM */
	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x10400],1024);
	close(fd);

	soft_switch(SET_PAGE1);

	/* load MAIN RAM */
	fd=open(argv[2],O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x00400],1024);
	close(fd);


	grsim_update();

	while(1) {
		ch=grsim_input();
		if (ch) break;
		usleep(100000);
	}

	return 0;
}
