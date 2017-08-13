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

	home();

	grsim_unrle(title_rle,0x800);
	gr_copy(0x800,0x400);

	grsim_update();

	result=select_menu(12, 22, 3, title_menu);

	return result;
}

