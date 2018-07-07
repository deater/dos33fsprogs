#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_backgrounds.h"

static char *title_menu[]={
	"NEW GAME",
	"LOAD GAME",
	"CREDITS",
};

int title(void) {

	int result;

	soft_switch(LORES);
        soft_switch(TXTCLR);
        soft_switch(MIXSET);

	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE2;
	clear_bottom();

	grsim_unrle(title_rle,0xc00);

	ram[DRAW_PAGE]=PAGE0;
	gr_copy_to_current(0xc00);
	ram[DRAW_PAGE]=PAGE1;
	gr_copy_to_current(0xc00);
	page_flip();

//	page_flip();
//	page_flip();

//	grsim_update();

	result=select_menu(12, 22, 3, title_menu);

	return result;
}

