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
	//int enemy_hp=20;

	int tfv_x=34;

	home();
	gr();

	basic_htab(1);
	basic_vtab(22);
	basic_normal();
	basic_print("KILLER CRAB");

	basic_htab(27);
	basic_vtab(21);
	basic_print("HP");

	basic_htab(34);
	basic_vtab(21);
	basic_print("LIMIT");

	basic_htab(15);
	basic_vtab(22);
	basic_print("DEATER");

	basic_htab(24);
	basic_vtab(22);
	print_byte(hp);
	basic_print("/");
	print_byte(max_hp);

	basic_htab(34);
	basic_vtab(22);
	basic_inverse();
	for(i=0;i<limit;i++) {
		basic_print(" ");
	}
	basic_normal();
	for(i=limit;i<5;i++) {
		basic_print(" ");
	}

	basic_inverse();
	for(i=21;i<25;i++) {
		basic_vtab(i);
		basic_htab(13);
		basic_print(" ");
	}
	basic_normal();


	while(1) {
		color_equals(COLOR_MEDIUMBLUE);
		for(i=0;i<10;i++) {
			basic_hlin(0,39,i);
		}
		color_equals(COLOR_LIGHTGREEN);
		for(i=10;i<40;i++) {
			basic_hlin(0,39,i);
		}

		grsim_put_sprite_page(0,tfv_stand_left,tfv_x,20);
		grsim_put_sprite_page(0,tfv_led_sword,tfv_x-5,20);

		grsim_put_sprite_page(0,killer_crab,enemy_x,20);

		grsim_update();

		ch=grsim_input();
		if (ch=='q') break;

		usleep(100000);
	}

	return 0;
}


