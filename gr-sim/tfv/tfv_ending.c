#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_defines.h"
#include "tfv_definitions.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"


int do_ending(void) {

	int i;
	int saved_drawpage;

//	boss_battle();

	saved_drawpage=ram[DRAW_PAGE];

	grsim_unrle(harfco_rle,0xc00);

	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();

	ram[DRAW_PAGE]=saved_drawpage;

	gr_copy_to_current(0xc00);
	page_flip();

	for(i=0;i<10;i++) {
		usleep(100000);
	}

	for(i=0;i<20;i++) {
		gr_copy_to_current(0xc00);
		color_equals(COLOR_AQUA);
                vlin(20-i,20,21);
		page_flip();

		usleep(50000);
	}
	for(i=0;i<30;i+=2) {
		gr_copy_to_current(0xc00);
		color_equals(COLOR_YELLOW);
		hlin_double(ram[DRAW_PAGE],0,39,0);
		if (i>2) hlin_double(ram[DRAW_PAGE],0,39,2);
		if (i>4) hlin_double(ram[DRAW_PAGE],0,39,4);
		if (i>6) hlin_double(ram[DRAW_PAGE],0,39,6);
		if (i>8) hlin_double(ram[DRAW_PAGE],0,39,8);
		page_flip();

		usleep(100000);
	}

	gr_copy_to_current(0xc00);
	ram[CH]=13;
	ram[CV]=21;
	move_and_print("YOU HAVE WON!!");
	page_flip();

	usleep(3400000);

	credits();

	return 0;
}
