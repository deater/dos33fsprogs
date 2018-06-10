#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"




#if 0

WORLDMAP_LOCATIONS
	COLLEGE_PARK
	HARFORD_COUNTY
	LANDING_SITE

	umcp_rle
		"TALBOT HALL",X1,Y1,X2,Y2,TALBOT_HALL,
		"SOUTH CAMPUS DINING",X1,Y1,X2,Y2,SOUTH_CAMPUS,
		"METRO STATION",X1,Y1,X2,Y2,METRO_STATION,
		"FOUNTAIN" -- drink from it restore heatlh?

	bel_air_rle
		"C. MILTON",
		"JOHN CARROLL",
		"SHOPPING MALL",
		"MINIGOLF",

	jc_rle:
		"VIDEO HOMEROOM"
		"AP CALCULUS, TEAM I-1"
		"DEUTSCH"
		"HOMEROOM"
		"MATH OFFICE"


	dining_rle
		"OSCAR",
		"NICOLE",
		"CINDY",
		"ELAINE",
		"CAFETERIA LADY",
		"PATRIOT ROOM"

	metro_rle:
		"METRO WORKER",
		"TINY CAPABARA",
		"GIANT GUINEA PIG",
		"LARGE BIRD",

	talbot_rle:
		"LIZ AND WILL",
		"PETE",
		"KENJESU",
		"MATHEMAGICIAN",
		"DARTH TATER",


	math_office_rle:
		"CAPTAIN STEVE",
		"BRIGHID",
		"RACHAEL YRBK",
		"MREE",

	video_hr_rle:
		"GUS",
		"RAISTLIN",
		"FORD",
		"SISTER SCARYNUN",

#endif







/* In Town */

int city_map(void) {

	int ch;
	int direction=1;
	int newx=0,newy=0,moved;

	gr();

	color_equals(COLOR_BLACK);

	direction=1;
	int odd=0;
	int refresh=1;

	while(1) {
		moved=0;
		newx=tfv_x;
		newy=tfv_y;

		ch=grsim_input();

		if ((ch=='q') || (ch==27))  break;

		if ((ch=='w') || (ch==APPLE_UP)) {
			newy=tfv_y-2;
			moved=1;
		}
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			newy=tfv_y+2;
			moved=1;
		}
		if ((ch=='a') || (ch==APPLE_LEFT)) {
			if (direction>0) {
				direction=-1;
				odd=0;
			}
			else {
				newx=tfv_x-1;
				moved=1;
			}
		}
		if ((ch=='d') || (ch==APPLE_RIGHT)) {
			if (direction<0) {
				direction=1;
				odd=0;
			}
			else {
				newx=tfv_x+1;
				moved=1;
			}
		}

		if (ch=='h') print_help();
		if (ch=='b') do_battle();
		if (ch=='i') print_info();
		if (ch=='m') {
			show_map();
			refresh=1;
		}


		/* Collision detection + Movement */
		if (moved) {
			odd=!odd;
			steps++;

//			if (collision(newx,newy+10,ground_color)) {
//			}
//			else {
				tfv_x=newx;
				tfv_y=newy;
//			}

			if (tfv_x>36) {
				map_x++;
				tfv_x=0;
				refresh=1;
			}
			else if (tfv_x<=0) {
				map_x--;
				tfv_x=35;
				refresh=1;
			}

			if ((tfv_y<4) && (map_x>=4)) {
				map_x-=4;
				tfv_y=28;
				refresh=1;
			}
			else if (tfv_y>=28) {
				map_x+=4;
				tfv_y=4;
				refresh=1;
			}
		}

		if (refresh) {
			grsim_unrle(umcp_rle,0xc00);
			refresh=0;
		}

		gr_copy_to_current(0xc00);

		if (direction==-1) {
			if (odd) grsim_put_sprite(tfv_walk_left,tfv_x,tfv_y);
			else grsim_put_sprite(tfv_stand_left,tfv_x,tfv_y);
		}
		if (direction==1) {
			if (odd) grsim_put_sprite(tfv_walk_right,tfv_x,tfv_y);
			else grsim_put_sprite(tfv_stand_right,tfv_x,tfv_y);
		}

		page_flip();

		if (steps>=60) {
			steps=0;
			time_minutes++;
			if (time_minutes>=60) {
				time_hours++;
				time_minutes=0;
			}
		}

		usleep(10000);
	}

	return 0;
}
