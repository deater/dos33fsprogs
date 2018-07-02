#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include "../tfv_zp.h"

#include "../tfv/tfv_sprites.h"
#include "../tfv/tfv_sprites.c"

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

	color_equals(4);
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

	int frame=0;
	int tree1_x=28,tree1_y=28;
	int tree2_x=37,tree2_y=30;

	grsim_put_sprite_page(PAGE0,
			bird_rider_stand_right,
			17,30);

	while(1) {
		grsim_update();

		color_equals(4);
			for(i=28;i<48;i++) {
			basic_hlin(0,39,i);
		}
		grsim_put_sprite_page(PAGE0,
				small_tree,
				tree1_x,tree1_y);
		grsim_put_sprite_page(PAGE0,
				big_tree,
				tree2_x,tree2_y);

		if (frame%8>4) {
			grsim_put_sprite_page(PAGE0,
				bird_rider_stand_right,
				17,30);
		}
		else {
			grsim_put_sprite_page(PAGE0,
				bird_rider_walk_right,
				17,30);
		}

		ch=grsim_input();

		if (ch) break;

		usleep(100000);
		frame++;
		if (frame>31) frame=0;

		if (frame%4==0) {
			tree2_x--;
			if (tree2_x<0) tree2_x=37;
		}

		if (frame%16==0) {
			tree1_x--;
			if (tree1_x<0) tree1_x=37;
		}

	}



	return 0;
}
