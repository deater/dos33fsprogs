#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_backgrounds.h"


int main(int argc, char **argv) {

	int result;

	grsim_init();
	gr();

	clear_bottom(PAGE0);
	clear_bottom(PAGE1);
	clear_bottom(PAGE2);

	grsim_unrle(title_rle,0xc00);

	gr_copy_to_current(0xc00);
	page_flip();
	gr_copy_to_current(0xc00);
	page_flip();

	repeat_until_keypressed();

	return result;
}

