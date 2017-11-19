#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

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

void print_help(void) {
	text();
	home();

//	htab(1);
//	vtab(1);
//	move_cursor();

/*
***************************************
*                HELP                 *
*                                     *
*   ARROWS  - MOVE                    *
*   W/A/S/D - MOVE                    *
*   Z/X     - SPEED UP / SLOW DOWN    *
*   SPACE   - STOP                    *
*   RETURN  - LAND / ENTER / ACTION   *
*   I       - INVENTORY               *
*   M       - MAP                     *
*   ESC     - QUIT                    *
*                                     *
***************************************
*/
	ram[CV]=1;
	ram[CH]=18;
	move_and_print("HELP");

	ram[CV]=3;
	ram[CH]=4;	move_and_print("ARROWS  - MOVE");
	ram[CV]++;	move_and_print("W/A/S/D - MOVE");
	ram[CV]++;	move_and_print("Z/X     - SPEED UP / SLOW DOWN");
	ram[CV]++;	move_and_print("SPACE   - STOP");
	ram[CV]++;	move_and_print("RETURN  - LAND / ENTER / ACTION");
	ram[CV]++;	move_and_print("I       - INVENTORY");
	ram[CV]++;	move_and_print("M       - MAP");
	ram[CV]++;	move_and_print("ESC     - QUIT");

	page_flip();

	repeat_until_keypressed();

	gr();
}

void show_map(void) {

	gr();

	grsim_unrle(map_rle,((int)ram[DRAW_PAGE]+0x4)<<8);
	//gr_copy(0x800,0x400);

	color_equals(COLOR_RED);
	basic_plot(8+((map_x&0x3)*6)+(tfv_x/6),8+(((map_x&0xc)>>2)*6)+(tfv_y/6));

	page_flip();

	repeat_until_keypressed();
}


/*
          1         2         3         4
01234567890123456789012345678901234567890
****************************************  1
* DEATER	    * LEVEL 1          *  2
****************************************  3
* INVENTORY         * STATS            *  4
****************************************  5
*		    * HP:      50/100  *  6
*		    * MP:         0/0  *  7
*                   *                  *  8
*		    * EXPERIENCE:   0  *  9
*		    * NEXT LEVEL:  16  * 10
*                   *                  * 11
*		    * MONEY: $1        * 12   0-256
*		    * TIME: 00:00      * 13
*		    *		       * 14
*		    *		       * 15
*		    *		       * 16
*		    *		       * 17
*		    *		       * 18
*		    *		       * 19
*		    *		       * 20
*		    *		       * 21
*		    *		       * 22
*		    *	               * 23
**************************************** 24

EXPERIENCE = 0...255
LEVEL = EXPERIENCE /  = 0...63
NEXT LEVEL = 
MONEY   = 0...255
MAX_HP  = 32+EXPERIENCE (maxing at 255)
*/


static char item_names1[8][15]={
	"CUPCAKE",		// cafeteria lady
	"CARROT",		// capabara
	"SMARTPASS",		// metro worker
	"ELF RUNES",		// mree
	"LIZBETH STAR",		// Lizbeth
	"KARTE SPIEL",		// Frau
	"GLAMDRING",		// Gus
	"VEGEMITE",		// Nicole
};

static char item_names2[8][15]={
	"BLUE LED",		// bird
	"RED LED",		//
	"1K RESISTOR",		// brown black red, Elaine
	"4.7K RESISTOR",	// yellow purple red, Tater
	"9V BATTERY",		// Cindy
	"1.5V BATTERY",		// Oscar
	"LINUX CD",		// john
	"ARMY KNIFE",		// Steve
};

void print_info(void) {
	int i;

	text();
	home();

	/* Inverse Space */
	/* 0x30=COLOR */
	ram[0x30]=0x20;

	/* Draw boxes */
	hlin_double(0,0,39,0);
	hlin_double(0,0,39,4);
	hlin_double(0,0,39,8);
	hlin_double(0,0,39,46);

	basic_vlin(0,48,0);
	basic_vlin(0,48,20);
	basic_vlin(0,48,39);

	basic_htab(3);
	basic_vtab(2);
	basic_print(nameo);

	basic_htab(23);
	basic_print("LEVEL ");
	print_u8(level);

	basic_htab(3);
	basic_vtab(4);
	basic_print("INVENTORY");
	basic_htab(23);
	basic_print("STATS");


	for(i=0;i<8;i++) {
		basic_htab(4);
		basic_vtab(6+i);
		if (items1&(1<<i)) basic_print(item_names1[i]);

		basic_htab(4);
		basic_vtab(14+i);
		if (items2&(1<<i)) basic_print(item_names2[i]);
	}

	basic_htab(23);
	basic_vtab(6);
	basic_print("HP:      ");
	print_u8(hp);
	basic_print("/");
	print_u8(max_hp);

	basic_htab(23);
	basic_vtab(7);
	basic_print("MP:       0/0");

	basic_htab(23);
	basic_vtab(9);
	basic_print("EXPERIENCE: ");
	print_u8(experience);

	basic_htab(23);
	basic_vtab(10);
	basic_print("NEXT LEVEL: ");

	basic_htab(23);
	basic_vtab(12);
	basic_print("MONEY: $");
	print_u8(money);

	basic_htab(23);
	basic_vtab(13);
	basic_print("TIME: ");
	if (time_hours<10) basic_print("0");
	print_u8(time_hours);
	basic_print(":");
	if (time_minutes<10) basic_print("0");
	print_u8(time_minutes);

	grsim_update();

	repeat_until_keypressed();
	home();
	gr();
}

