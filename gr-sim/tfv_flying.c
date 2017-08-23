#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"


static unsigned char flying_map[64]= {
	  2,15,15,15, 15,15,15, 2,
	 13,12,12, 8,  4, 4, 0,13,
	 13,12,12,12,  8, 4, 4,13,
	 13,12,12, 8,  4, 4, 4,13,
	 13,12, 9, 9,  8, 4, 4,13,
	 13,12, 9, 8,  4, 4, 4,13,
	 13,12, 9, 9,  1, 4, 4,13,
	 2,13,13,13, 13,13,13, 2};

#define TILE_W	64
#define TILE_H	64
#define MASK_X	(TILE_W - 1)
#define MASK_Y	(TILE_H - 1)

#define LOWRES_W	40
#define LOWRES_H	40

#if 1

//
// Detailed version
//
//

static int lookup_map(int x, int y) {

	int color;

	color=2;

	x=x&MASK_X;
	y=y&MASK_Y;

	if ( ((y&0x3)==1) && ((x&7)==0) ) color=14;
	if ( ((y&0x3)==3) && ((x&7)==4) ) color=14;


	if ((y<8) && (x<8)) {
		color=flying_map[(y*8)+x];
	}


	/* 2   2 2 2  2  2 2 2 */
	/* 14 14 2 2  2  2 2 2 */
	/* 2   2 2 2 14 14 2 2 */
	/* 2   2 2 2  2  2 2 2 */

	return color;

}





/* http://www.helixsoft.nl/articles/circle/sincos.htm */

static double space_z=4.5; // height of the camera above the plane
static int horizon=-2;    // number of pixels line 0 is below the horizon
static double scale_x=20, scale_y=20;


//void mode_7 (BITMAP *bmp, BITMAP *tile, fixed angle, fixed cx, fixed cy, MODE_7_PARAMS params)

double BETA=-0.5;

static int over_water;

void draw_background_mode7(double angle, double cx, double cy) {

	// current screen position
	int screen_x, screen_y;

	// the distance and horizontal scale of the line we are drawing
	double distance, horizontal_scale;

	// step for points in space between two pixels on a horizontal line
	double  line_dx, line_dy;

	// current space position
	double space_x, space_y;
	int map_color;

	over_water=0;

	/* Draw Sky */
	/* Originally wanted to be fancy and have sun too, but no */
	color_equals(COLOR_MEDIUMBLUE);
	for(screen_y=0;screen_y<6;screen_y+=2) {
		hlin_double(ram[DRAW_PAGE], 0, 40, screen_y);
	}

	/* Draw hazy horizon */
	color_equals(COLOR_GREY);
	hlin_double(ram[DRAW_PAGE], 0, 40, 6);


	for (screen_y = 8; screen_y < LOWRES_H; screen_y++) {
		// first calculate the distance of the line we are drawing
		distance = (space_z * scale_y) / (screen_y + horizon);

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
		horizontal_scale = (distance / scale_x);

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		line_dx = -sin(angle) * horizontal_scale;
		line_dy = cos(angle) * horizontal_scale;

		// calculate the starting position
		space_x = cx + (distance * cos(angle)) - LOWRES_W/2 * line_dx;
		space_y = cy + (distance * sin(angle)) - LOWRES_W/2 * line_dy;

		// Move camera back a bit

		double factor;

		factor=space_z*BETA;

//		factor=2.0*BETA;

		space_x+=factor*cos(angle);
		space_y+=factor*sin(angle);


		// go through all points in this screen line
		for (screen_x = 0; screen_x < LOWRES_W-1; screen_x++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map((int)space_x,(int)space_y);

			//ram[COLOR]=map_color;
			//ram[COLOR]|=map_color<<4;


			color_equals(map_color);

			if (screen_x==20) {
				if (map_color==COLOR_DARKBLUE) over_water=1;
				else over_water=0;
			}

			//hlin_double(ram[DRAW_PAGE], screen_x, screen_x+1,
			//	screen_y);

			plot(screen_x,screen_y);

			// advance to the next position in space
			space_x += line_dx;
			space_y += line_dy;
		}
	}
}

#else

//
// Non-detailed version
//
//
//

static int lookup_map(int x, int y) {

	int color;

	color=2;

	x=x&MASK_X;
	y=y&MASK_Y;

	if ( ((y&0x3)==1) && ((x&7)==0) ) color=14;
	if ( ((y&0x3)==3) && ((x&7)==4) ) color=14;


	if ((y<8) && (x<8)) {
		color=flying_map[(y*8)+x];
	}


	/* 2   2 2 2  2  2 2 2 */
	/* 14 14 2 2  2  2 2 2 */
	/* 2   2 2 2 14 14 2 2 */
	/* 2   2 2 2  2  2 2 2 */

	return color;

}





/* http://www.helixsoft.nl/articles/circle/sincos.htm */

static double space_z=4.5; // height of the camera above the plane
static int horizon=-2;    // number of pixels line 0 is below the horizon
static double scale_x=20, scale_y=20;


//void mode_7 (BITMAP *bmp, BITMAP *tile, fixed angle, fixed cx, fixed cy, MODE_7_PARAMS params)

double BETA=-0.5;

static int over_water;

void draw_background_mode7(double angle, double cx, double cy) {

	// current screen position
	int screen_x, screen_y;

	// the distance and horizontal scale of the line we are drawing
	double distance, horizontal_scale;

	// step for points in space between two pixels on a horizontal line
	double  line_dx, line_dy;

	// current space position
	double space_x, space_y;
	int map_color;

	over_water=0;

	/* Draw Sky */
	/* Originally wanted to be fancy and have sun too, but no */
	color_equals(COLOR_MEDIUMBLUE);
	for(screen_y=0;screen_y<6;screen_y+=2) {
		hlin_double(ram[DRAW_PAGE], 0, 40, screen_y);
	}

	/* Draw hazy horizon */
	color_equals(COLOR_GREY);
	hlin_double(ram[DRAW_PAGE], 0, 40, 6);


	for (screen_y = 8; screen_y < LOWRES_H; screen_y++) {
		// first calculate the distance of the line we are drawing
		distance = (space_z * scale_y) / (screen_y + horizon);

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
		horizontal_scale = (distance / scale_x);

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		line_dx = -sin(angle) * horizontal_scale;
		line_dy = cos(angle) * horizontal_scale;

		// calculate the starting position
		space_x = cx + (distance * cos(angle)) - LOWRES_W/2 * line_dx;
		space_y = cy + (distance * sin(angle)) - LOWRES_W/2 * line_dy;

		// Move camera back a bit

		double factor;

		factor=space_z*BETA;

//		factor=2.0*BETA;

		space_x+=factor*cos(angle);
		space_y+=factor*sin(angle);


		// go through all points in this screen line
		for (screen_x = 0; screen_x < LOWRES_W-1; screen_x++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map((int)space_x,(int)space_y);

			ram[COLOR]=map_color;
			ram[COLOR]|=map_color<<4;


			if (screen_x==20) {
				if (map_color==COLOR_DARKBLUE) over_water=1;
				else over_water=0;
			}

			hlin_double(ram[DRAW_PAGE], screen_x, screen_x+1,
				screen_y);

			//basic_plot(screen_x,screen_y);

			// advance to the next position in space
			space_x += line_dx;
			space_y += line_dy;
		}
	}
}

#endif


#define SHIPX	15

int flying(void) {

	unsigned char ch;
	int shipy;
	int turning=0;
	double flyx=0,flyy=0;
	double our_angle=0.0;
	double dy,dx,speed=0;
	int draw_splash=0;

	/************************************************/
	/* Flying					*/
	/************************************************/

	gr();
	shipy=20;

	while(1) {
		if (draw_splash>0) draw_splash--;

		ch=grsim_input();

		if ((ch=='q') || (ch==27))  break;

#if 0
		if (ch=='g') {
			BETA+=0.1;
			printf("Horizon=%lf\n",BETA);
		}
		if (ch=='h') {
			BETA-=0.1;
			printf("Horizon=%lf\n",BETA);
		}

		if (ch=='s') {
			scale_x++;
			scale_y++;
			printf("Scale=%lf\n",scale_x);
		}
#endif

		if ((ch=='w') || (ch==APPLE_UP)) {
			if (shipy>16) {
				shipy-=2;
				space_z+=1;
			}

			printf("Z=%lf\n",space_z);
		}
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			if (shipy<28) {
				shipy+=2;
				space_z-=1;
			}
			else {
				draw_splash=10;
			}
			printf("Z=%lf\n",space_z);
		}
		if ((ch=='a') || (ch==APPLE_LEFT)) {
			if (turning>0) {
				turning=0;
			}
			else {
				turning=-20;

				our_angle-=(6.28/32.0);
				if (our_angle<0.0) our_angle+=6.28;
			}

		//	printf("Angle %lf\n",our_angle);
		}
		if ((ch=='d') || (ch==APPLE_RIGHT)) {
			if (turning<0) {
				turning=0;
			}
			else {
				turning=20;
				our_angle+=(6.28/32.0);
				if (our_angle>6.28) our_angle-=6.28;
			}

		}

		if (ch=='z') {
			if (speed>0.5) speed=0.5;
			speed+=0.05;
		}

		if (ch=='x') {
			if (speed<-0.5) speed=-0.5;
			speed-=0.05;
		}

		if (ch==' ') {
			speed=0;
		}


		dx = speed * cos (our_angle);
		dy = speed * sin (our_angle);

		flyx += dx;
		flyy += dy;

		draw_background_mode7(our_angle, flyx, flyy);

		if (turning==0) {
			if ((speed>0.0) && (over_water)&&(draw_splash)) {
				grsim_put_sprite(splash_forward,
					SHIPX+1,shipy+9);
			}
			grsim_put_sprite(shadow_forward,SHIPX+3,31+space_z);
			grsim_put_sprite(ship_forward,SHIPX,shipy);
		}
		if (turning<0) {

			if ((shipy>25) && (speed>0.0)) draw_splash=1;

			if (over_water&&draw_splash) {
				grsim_put_sprite(splash_left,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_left,SHIPX+3,31+space_z);
			grsim_put_sprite(ship_left,SHIPX,shipy);
			turning++;
		}
		if (turning>0) {


			if ((shipy>25) && (speed>0.0)) draw_splash=1;

			if (over_water&&draw_splash) {
				grsim_put_sprite(splash_right,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_right,SHIPX+3,31+space_z);
			grsim_put_sprite(ship_right,SHIPX,shipy);
			turning--;
		}

		page_flip();

		usleep(20000);

	}
	return 0;
}

