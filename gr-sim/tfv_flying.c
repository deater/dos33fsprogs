#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"

/* Mode7 code based on code from: */
/* http://www.helixsoft.nl/articles/circle/sincos.htm */

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


static int over_water;

	// current screen position
static int screen_x, screen_y;
static char angle=0;



#if 1

struct fixed_type {
	char i;
	unsigned char f;
};


#if 0
// map coordinates
struct fixed_type cx = {0,0};
struct fixed_type cy = {0,0};
struct fixed_type dx = {0,0};
struct fixed_type dy = {0,0};
struct fixed_type speed = {0,0};

// the distance and horizontal scale of the line we are drawing
struct fixed_type distance = {0,0};
struct fixed_type horizontal_scale = {0,0};

// step for points in space between two pixels on a horizontal line
struct fixed_type line_dx = {0,0};
struct fixed_type line_dy = {0,0};

// current space position
struct fixed_type space_x;
struct fixed_type space_y;

// height of the camera above the plane
struct fixed_type space_z= {0x04,0x80};	// 4.5;

struct fixed_type BETA = {0xff,0x80}; 	// -0.5;
#else


// map coordinates
double cx=0;
double cy=0;
double dx=0;
double dy=0;

#define SPEED_STOPPED	0

unsigned char speed=SPEED_STOPPED;	// 0..4, with 0=stopped

// the distance and horizontal scale of the line we are drawing
double distance=0;
double horizontal_scale=0;

// step for points in space between two pixels on a horizontal line
double line_dx=0;
double line_dy=0;

// current space position
double space_x,space_y;

// height of the camera above the plane
double space_z=4.5;
double BETA=-0.5;

#endif

static int horizon=-2;    // number of pixels line 0 is below the horizon

#define SCALE_X	20.0
#define SCALE_Y	20.0


#define ANGLE_STEPS	16

double sin_table[ANGLE_STEPS]={
	0.000000,
	0.382683,
	0.707107,
	0.923880,
	1.000000,
	0.923880,
	0.707107,
	0.382683,
	0.000000,
	-0.382683,
	-0.707107,
	-0.923880,
	-1.000000,
	-0.923880,
	-0.707107,
	-0.382683,
};

double our_sin(unsigned char angle) {
	return sin_table[angle&0xf];
}

double our_cos(unsigned char angle) {

	return sin_table[(angle+4)&0xf];
}

//
// Non-detailed version
//
//

void draw_background_mode7(void) {


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

	for (screen_y = 8; screen_y < LOWRES_H; screen_y+=2) {
		// first calculate the distance of the line we are drawing
		distance = (space_z * SCALE_Y) / (screen_y + horizon);

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
		horizontal_scale = (distance / SCALE_X);

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		line_dx = -our_sin(angle) * horizontal_scale;
		line_dy = our_cos(angle) * horizontal_scale;


		// Move camera back a bit
		double factor;
		factor=space_z*BETA;

//		space_x+=factor*our_cos(angle);
//		space_y+=factor*our_sin(angle);

		// calculate the starting position
		space_x = cx + ((distance+factor) * our_cos(angle)) - LOWRES_W/2 * line_dx;
		space_y = cy + ((distance+factor) * our_sin(angle)) - LOWRES_W/2 * line_dy;




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

			// advance to the next position in space
			space_x += line_dx;
			space_y += line_dy;
		}
	}
}

#define SHIPX	15

int flying(void) {

	unsigned char ch;
	int shipy;
	int turning=0;
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

				angle-=1;
				if (angle<0) angle+=ANGLE_STEPS;
			}
		}
		if ((ch=='d') || (ch==APPLE_RIGHT)) {
			if (turning<0) {
				turning=0;
			}
			else {
				turning=20;
				angle+=1;
				if (angle>=ANGLE_STEPS) angle-=ANGLE_STEPS;
			}

		}

		// increase speed
		if (ch=='z') {
			if (speed<3) speed++;
		}

		// decrease speed
		if (ch=='x') {
			if (speed>0) speed--;
		}

		// emergency break
		if (ch==' ') {
			speed=SPEED_STOPPED;
		}

		if (speed!=SPEED_STOPPED) {

			int ii;

			dx = our_cos(angle)/8.0;
			dy = our_sin(angle)/8.0;

			for(ii=0;ii<speed;ii++) {
				cx += dx;
				cy += dy;
			}

		}

		draw_background_mode7();//our_angle, flyx, flyy);

		if (turning==0) {
			if ((speed!=SPEED_STOPPED) && (over_water)&&(draw_splash)) {
				grsim_put_sprite(splash_forward,
					SHIPX+1,shipy+9);
			}
			grsim_put_sprite(shadow_forward,SHIPX+3,31+space_z);
			grsim_put_sprite(ship_forward,SHIPX,shipy);
		}
		if (turning<0) {

			if ((shipy>25) && (speed!=SPEED_STOPPED)) draw_splash=1;

			if (over_water&&draw_splash) {
				grsim_put_sprite(splash_left,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_left,SHIPX+3,31+space_z);
			grsim_put_sprite(ship_left,SHIPX,shipy);
			turning++;
		}
		if (turning>0) {


			if ((shipy>25) && (speed!=SPEED_STOPPED)) draw_splash=1;

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































#else

// map coordinates
double cx=0.0,cy=0.0;
static double space_z=4.5; // height of the camera above the plane
static int horizon=-2;    // number of pixels line 0 is below the horizon
static double scale_x=20, scale_y=20;

double BETA=-0.5;


#define ANGLE_STEPS	32

double our_sin(unsigned char angle) {

	double r;

	r=3.14159265358979*2.0*(double)angle/(double)ANGLE_STEPS;

	return sin(r);
}

double our_cos(unsigned char angle) {

	double r;

	r=3.14159265358979*2.0*(double)angle/(double)ANGLE_STEPS;

	return cos(r);
}

//
// Detailed version
//
//

void draw_background_mode7(void) {


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
		line_dx = -our_sin(angle) * horizontal_scale;
		line_dy = our_cos(angle) * horizontal_scale;

		double factor;
		// Move camera back a bit
		factor=space_z*BETA;

		// calculate the starting position
		space_x = cx + ((distance+factor) * our_cos(angle)) - LOWRES_W/2 * line_dx;
		space_y = cy + ((distance+factor) * our_sin(angle)) - LOWRES_W/2 * line_dy;

		// go through all points in this screen line
		for (screen_x = 0; screen_x < LOWRES_W-1; screen_x++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map((int)space_x,(int)space_y);

			color_equals(map_color);

			if (screen_x==20) {
				if (map_color==COLOR_DARKBLUE) over_water=1;
				else over_water=0;
			}

			plot(screen_x,screen_y);

			// advance to the next position in space
			space_x += line_dx;
			space_y += line_dy;
		}
	}
}




#define SHIPX	15

int flying(void) {

	unsigned char ch;
	int shipy;
	int turning=0;
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

				angle-=1;
				if (angle<0) angle+=ANGLE_STEPS;
			}
		}
		if ((ch=='d') || (ch==APPLE_RIGHT)) {
			if (turning<0) {
				turning=0;
			}
			else {
				turning=20;
				angle+=1;
				if (angle>=ANGLE_STEPS) angle-=ANGLE_STEPS;
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


		dx = speed * our_cos (angle);
		dy = speed * our_sin (angle);

		cx += dx;
		cy += dy;

		draw_background_mode7();//our_angle, flyx, flyy);

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

#endif
