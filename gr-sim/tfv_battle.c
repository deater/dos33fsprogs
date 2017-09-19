#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"


/* Do Battle */


/* Metrocat Easter Egg (summon?) */

/* Enemies: */
/*   Killer Crab, Evil Tree, Deadly Bees, Big Fish, Procrastinon */

/* Battle.
Forest? Grassland? Artic? Ocean?



          1         2         3
0123456789012345678901234567890123456789|
----------------------------------------|
            |            HP      LIMIT  |  -> FIGHT/LIMIT       21
KILLER CRAB | DEATER   128/255    128   |     ZAP               22
            |                           |     REST              23
            |                           |     RUN AWAY          24

Sound effects?

List hits

******    **    ****    ****    **  **  ******    ****  ******  ******  ******
**  **  ****        **      **  **  **  **      **          **  **  **  **  **
**  **    **      ****  ****    ******  ****    ******    **    ******  ******
**  **    **    **          **      **      **  **  **    **    **  **      **
******  ******  ******  ****        **  ****    ******    **    ******      **

*/



/* Background depend on map location? */
/* Room for guinea pig in party? */

/* Attacks -> HIT, ZAP, HEAL, RUNAWAY */


int do_battle(void) {

	int i,ch;

	int enemy_x=2;
	int saved_drawpage;
	//int enemy_hp=20;

	int tfv_x=34;

//	home();
//	gr();


	clear_bottom(PAGE2);

	saved_drawpage=ram[DRAW_PAGE];
	ram[DRAW_PAGE]=PAGE2;	// 0xc00

	vtab(22);
	htab(1);
	move_cursor();
	print("KILLER CRAB");

	vtab(21);
	htab(27);
	move_cursor();
	print("HP");

	vtab(21);
	htab(34);
	move_cursor();
	print("LIMIT");

	vtab(22);
	htab(15);
	move_cursor();
	print("DEATER");

	vtab(22);
	htab(24);
	move_cursor();
	print_byte(hp);
	print("/");
	print_byte(max_hp);

	ram[COLOR]=0x20;
	hlin_double(ram[DRAW_PAGE],33,33+limit,42);

//	basic_htab(34);
//	basic_vtab(22);
//	basic_inverse();
//	for(i=0;i<limit;i++) {
//		basic_print(" ");
//	}
//	basic_normal();
//	for(i=limit;i<5;i++) {
//		basic_print(" ");
//	}

	ram[COLOR]=0xa0;
	hlin_double_continue(5-limit);

	ram[COLOR]=0x20;

//	basic_inverse();
	for(i=40;i<50;i+=2) {
		hlin_double(ram[DRAW_PAGE],12,12,i);
//		basic_vtab(i);
//		basic_htab(13);
//		basic_print(" ");
	}
	//basic_normal();

	color_equals(COLOR_MEDIUMBLUE);
	for(i=0;i<10;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}
	color_equals(COLOR_LIGHTGREEN);
	for(i=10;i<40;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	ram[DRAW_PAGE]=saved_drawpage;

	while(1) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tfv_x,20);
		grsim_put_sprite(tfv_led_sword,tfv_x-5,20);

		grsim_put_sprite(killer_crab,enemy_x,20);

		page_flip();

		ch=grsim_input();
		if (ch=='q') break;

		usleep(100000);
	}

	clear_bottom(PAGE0);
	clear_bottom(PAGE1);

	return 0;
}


