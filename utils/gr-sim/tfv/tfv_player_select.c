#include <unistd.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_sprites.h"

int player_select(void) {

	int which_player=0;
	int ch,saved;

	saved=ram[DRAW_PAGE];
	ram[DRAW_PAGE]=8;
	clear_top_a(0);
	ram[DRAW_PAGE]=saved;

	while(1) {

		gr_copy_to_current(0xc00);

		color_equals(COLOR_AQUA);
		vlin(6+(which_player*16),22+(which_player*16),15);
		vlin(6+(which_player*16),22+(which_player*16),22);

		grsim_put_sprite(tfv_walk_right,17,8);

		grsim_put_sprite(tfg_walk_right,17,24);

		ram[CH]=13;
		ram[CV]=21;
		move_and_print("SELECT PLAYER");

		page_flip();

		ch=grsim_input();
		if (ch==13) break;

		if ((ch==APPLE_UP) || (ch==APPLE_DOWN) ||
			(ch==APPLE_RIGHT) || (ch==APPLE_LEFT)) {
			which_player=!which_player;
		}

		usleep(100000);

	}

	return which_player;
}
