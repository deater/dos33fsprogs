#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_defines.h"

#include "tfv_backgrounds.h"

void show_map(void) {

	gr();

	grsim_unrle(map_rle,((int)ram[DRAW_PAGE]+0x4)<<8);
	//gr_copy(0x800,0x400);

	color_equals(COLOR_RED);

	printf("plot(%d,%d)\n",
		8+((map_location&0x3)*6)+(tfv_x/6),
		8+(((map_location&0xc)>>2)*6)+(tfv_y/6));

	basic_plot(8+((map_location&0x3)*6)+(tfv_x/6),8+(((map_location&0xc)>>2)*6)+(tfv_y/6));



//	basic_plot(8+((map_location&0x3)*6)+(tfv_x/6),8+(((map_location&0xc)>>2)*6)+(tfv_y/6));

	ram[CH]=20;
	ram[CV]=20;	move_and_print(map_info[map_location].name);

	page_flip();

	repeat_until_keypressed();
}




