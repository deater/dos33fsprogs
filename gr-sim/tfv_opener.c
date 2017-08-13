#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"


static void draw_segment(void) {

	for(ram[LOOP]=0;ram[LOOP]<4;ram[LOOP]++) {
		ram[YY]=ram[YY]+ram[YADD];
		if (ram[XX]==ram[MATCH]) color_equals(ram[COLOR1]*3);
		else color_equals(ram[COLOR1]);
		vlin(ram[DRAW_PAGE],10,ram[YY],9+ram[XX]);
		if (ram[XX]==ram[MATCH]) color_equals(ram[COLOR2]*3);
		else color_equals(ram[COLOR2]);
		if (ram[YY]!=34) vlin(ram[DRAW_PAGE],ram[YY],34,9+ram[XX]);
		ram[XX]++;
	}
	ram[YADD]=-ram[YADD];
}

static void draw_logo(void) {

	ram[XX]=0;
	ram[YY]=10;
	ram[YADD]=6;
	ram[COLOR1]=1;
	ram[COLOR2]=0;
	draw_segment();
	ram[COLOR2]=4;
	draw_segment();
	ram[COLOR1]=2;
	draw_segment();
	draw_segment();
	draw_segment();
	ram[COLOR2]=0;
	draw_segment();
}

int opening(void) {

	/* VMW splash */

	ram[MATCH]=100;
	draw_logo();
	page_flip();

	usleep(200000);

	for(ram[MATCH]=0;ram[MATCH]<30;ram[MATCH]++) {
		draw_logo();
		page_flip();

		usleep(20000);
	}

	vtab(21);
	htab(9);
	move_cursor();
	print("A VMW SOFTWARE PRODUCTION");
	page_flip();

	repeat_until_keypressed();

	return 0;
}

