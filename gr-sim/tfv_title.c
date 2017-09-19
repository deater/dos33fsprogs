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

	clear_bottom(PAGE0);
	clear_bottom(PAGE1);
	clear_bottom(PAGE2);

	grsim_unrle(title_rle,0xc00);

	gr_copy_to_current(0xc00);
	page_flip();
	gr_copy_to_current(0xc00);

//	page_flip();
//	page_flip();

//	grsim_update();

	result=select_menu(12, 22, 3, title_menu);

	return result;
}

