#include <stdio.h>
#include <stdlib.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"


void print_help(void) {

	clear_top_a(0xa0);

	soft_switch(TXTSET);

//	htab(1);
//	vtab(1);
//	move_cursor();

/*
***************************************
*                HELP                 *
*                                     *
*   ARROWS  - MOVE                    *
*   W/A/S/D - MOVE                    *
*   Z/X     - FORWARD/BACK (FLYING)   *
*   SPACE   - STOP                    *
*   RETURN  - LAND / ENTER / ACTION   *
*   I       - INVENTORY               *
*   M       - MAP                     *
*   ESC     - CANCEL                  *
*                                     *
***************************************
*/
	ram[CV]=1;
	ram[CH]=18;
	move_and_print("HELP");

	ram[CV]=3;
	ram[CH]=4;	move_and_print("ARROWS  - MOVE");
	ram[CV]++;	move_and_print("W/A/S/D - MOVE");
	ram[CV]++;	move_and_print("Z/X     - FORWARD / BACK (FLYING)");
	ram[CV]++;	move_and_print("SPACE   - STOP");
	ram[CV]++;	move_and_print("RETURN  - LAND / ENTER / ACTION");
	ram[CV]++;	move_and_print("I       - INVENTORY");
	ram[CV]++;	move_and_print("M       - MAP");
	ram[CV]++;	move_and_print("ESC     - CANCEL");

	page_flip();

	repeat_until_keypressed();

	soft_switch(TXTCLR);
}

