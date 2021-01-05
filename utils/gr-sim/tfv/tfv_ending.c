#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_defines.h"
#include "tfv_definitions.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"


int do_ending(void) {

	int i,ch;
	int saved_drawpage;


	/*********************************/
	/* Do the puzzle		 */
	/*********************************/
	grsim_unrle(puzzle_rle,0xc00);
	gr_copy_to_current(0xc00);

	saved_drawpage=ram[DRAW_PAGE];
	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();
	ram[DRAW_PAGE]=saved_drawpage;

	ram[CH]=0;
	ram[CV]=20;
	move_and_print("TO UNLOCK THE DOOR THE LED MUST HAVE:");
	ram[CH]=0;
	ram[CV]=21;
	move_and_print("* 660 NANOMETER LIGHT");
	ram[CH]=0;
	ram[CV]=22;
	move_and_print("* 9 MILIAMPS OF CURRENT");

	page_flip();

	while(1) {
		ch=grsim_input();
		if (ch!=0) break;
	}

	/*********************************/
	/* Animate the boss arrival	 */
	/*********************************/


	saved_drawpage=ram[DRAW_PAGE];
	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();
	ram[DRAW_PAGE]=saved_drawpage;

	grsim_unrle(jc_office_rle,0xc00);

	for(i=0;i<20;i++) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(roboknee1,2,i);

		grsim_put_sprite(tfv_stand_left,12,24);

		ram[CH]=0;
		ram[CV]=20;
		move_and_print("NOT SO FAST");

		page_flip();
		usleep(100000);
	}


	ram[CH]=0;
	ram[CV]=21;
	move_and_print(" SINCE WE HAVE NO ELECTRICITY");
	ram[CH]=0;
	ram[CV]=22;
	move_and_print(" WE HAVE NO LIGHTS");

	page_flip();

	while(1) {
		ch=grsim_input();
		if (ch!=0) break;
	}


	/*********************************/
	/* Do the boss battle		 */
	/*********************************/

	boss_battle();


	/*********************************/
	/* Draw the sky beam		 */
	/*********************************/



	grsim_unrle(harfco_rle,0xc00);
	gr_copy_to_current(0xc00);

	saved_drawpage=ram[DRAW_PAGE];
	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();
	ram[DRAW_PAGE]=saved_drawpage;


	page_flip();

	for(i=0;i<10;i++) {
		usleep(100000);
	}

	for(i=0;i<20;i++) {
		gr_copy_to_current(0xc00);
		color_equals(COLOR_AQUA);
                vlin(20-i,20,21);
		page_flip();

		usleep(50000);
	}
	for(i=0;i<30;i+=2) {
		gr_copy_to_current(0xc00);
		color_equals(COLOR_YELLOW);
		hlin_double(ram[DRAW_PAGE],0,39,0);
		if (i>2) hlin_double(ram[DRAW_PAGE],0,39,2);
		if (i>4) hlin_double(ram[DRAW_PAGE],0,39,4);
		if (i>6) hlin_double(ram[DRAW_PAGE],0,39,6);
		if (i>8) hlin_double(ram[DRAW_PAGE],0,39,8);
		page_flip();

		usleep(100000);
	}

	gr_copy_to_current(0xc00);
	ram[CH]=13;
	ram[CV]=21;
	move_and_print("YOU HAVE WON!!");
	page_flip();

	usleep(3400000);

	/* clear keyboard buffer */
	while(grsim_input()!=0) ;

	/*********************************/
	/* Run the credits		 */
	/*********************************/

	credits();

	return 0;
}
