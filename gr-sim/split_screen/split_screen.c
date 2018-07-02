#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include "../tfv_zp.h"

#include "gr-sim.h"

int main(int argc, char **argv) {

	int yy,ch;
	int i,fd;

	grsim_init();

	/* Text first */
	text();
	home();

	ram[DISP_PAGE]=0x0;
	ram[DRAW_PAGE]=0x0;
	vtab(1); htab(1); move_cursor();
	print("   *                            .      ");
	vtab(2); htab(1); move_cursor();
	print("  *    .       T A L B O T          .  ");
	vtab(3); htab(1); move_cursor();
	print("  *           F A N T A S Y            ");
	vtab(4); htab(1); move_cursor();
	print("   *            S E V E N              ");
	vtab(5); htab(1); move_cursor();
	print(" .                          .    .     ");
	vtab(6); htab(1); move_cursor();
	print("             .                         ");

	/* draw the moon */
	vtab(1); htab(4); move_cursor(); print_inverse(" ");
	vtab(2); htab(3); move_cursor(); print_inverse(" ");
	vtab(3); htab(3); move_cursor(); print_inverse(" ");
	vtab(4); htab(4); move_cursor(); print_inverse(" ");


	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch!=0) break;

		usleep(100000);
	}

	/* gr part */
	soft_switch(LORES);     // LDA SW.LORES
	soft_switch(TXTCLR);    // LDA  TXTCLR
	soft_switch(MIXCLR);

	color_equals(2);
	for(i=28;i<48;i++) {
		basic_hlin(0,39,i);
	}

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch!=0) break;

		usleep(100000);
	}



	hgr();


	/* Put horizontal lines on screen */
	for(yy=64;yy<128;yy++) {
		hcolor_equals(1);
		hplot(0,yy);
		hplot_to(279,yy);
	}

	fd=open("KATC.BIN",O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x2000],0x2000);
	close(fd);

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch) break;

		usleep(100000);

	}

	set_plaid();

	

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch) break;

		usleep(100000);

	}



	return 0;
}
