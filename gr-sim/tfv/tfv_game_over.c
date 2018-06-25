#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_defines.h"

#include "tfv_backgrounds.h"

void game_over(void) {

	text();
	home();

	/* Make a box around it? */

	vtab(12);
	htab(15);
	move_cursor();
	print("GAME OVER");

	/* play the GROAN sound? */

	page_flip();

	repeat_until_keypressed();
}
