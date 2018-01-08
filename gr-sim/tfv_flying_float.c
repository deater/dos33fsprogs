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

static unsigned char water_map[32]={
	2,2,2,2,  2,2,2,2,
	14,2,2,2, 2,2,2,2,
	2, 2,2,2, 2,2,2,2,
	2,2,2,2,  14,2,2,2,
};

#define TILE_W	64
#define TILE_H	64
#define MASK_X	(TILE_W - 1)
#define MASK_Y	(TILE_H - 1)

#define LOWRES_W	40
#define LOWRES_H	40

static int displayed=0;

static int over_water=0;

static int lookup_map(int xx, int yy) {

	int color,offset;

	color=2;

	xx=xx&MASK_X;
	yy=yy&MASK_Y;

	if (!displayed) {
		printf("XX,YY! %x,%x\n",xx,yy);
	}


//	if ( ((y&0x3)==1) && ((x&7)==0) ) color=14;
//	if ( ((y&0x3)==3) && ((x&7)==4) ) color=14;

	offset=yy<<3;
	offset+=xx;

//	color=water_map[((yy*8)+xx)&0x1f];
	color=water_map[offset&0x1f];

	/* 2 2 2 2  2 2 2 2 */
	/* e 2 2 2  2 2 2 2 */
	/* 2 2 2 2  2 2 2 2 */
	/* 2 2 2 2  e 2 2 2 */

	if ((yy<8) && (xx<8)) {
		color=flying_map[offset];
	}

	if (!displayed) {
		printf("COLOR! %x\n",color);
	}



	return color;
}




	// current screen position
static int screen_x, screen_y;
static char angle=1;

// Speed
#define SPEED_STOPPED	0
static unsigned char speed=SPEED_STOPPED;	// 0..4, with 0=stopped




// map coordinates
double dx,dy;
double cx=0.0,cy=0.0;
static double space_z=4.5; // height of the camera above the plane
static int horizon=-2;    // number of pixels line 0 is below the horizon
static double scale_x=20, scale_y=20;

double factor;
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


	// Move camera back a bit
	factor=space_z*BETA;
	printf("space_z=%lf BETA=%lf factor=%lf\n",space_z,BETA,factor);

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

		// calculate the starting position
		space_x = cx + ((distance+factor) * our_cos(angle)) - LOWRES_W/2 * line_dx;
		space_y = cy + ((distance+factor) * our_sin(angle)) - LOWRES_W/2 * line_dy;

		// go through all points in this screen line
		for (screen_x = 0; screen_x < LOWRES_W-1; screen_x++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map((int)space_x,(int)space_y);

			color_equals(map_color);

			if ((screen_x==20) && (screen_y==38)) {
				if (map_color==COLOR_DARKBLUE) over_water=1;
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
	int draw_splash=0,splash_count=0;
	int zint;



	/************************************************/
	/* Flying					*/
	/************************************************/

	gr();
	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();

	shipy=20;

	while(1) {
		if (splash_count>0) splash_count--;

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
			splash_count=0;

//			printf("Z=%lf\n",space_z);
		}
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			if (shipy<28) {
				shipy+=2;
				space_z-=1;

			}
			else {
				splash_count=10;
			}
//			printf("Z=%lf\n",space_z);
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

		/* Used to be able to go backwards */
		if (ch=='z') {
			if (speed<3) speed++;
		}

		if (ch=='x') {
			if (speed>0) speed--;
		}

		if (ch==' ') {
			speed=SPEED_STOPPED;
		}

		if (ch=='h') {
			print_help();
		}

		/* Ending */
		if (ch==13) {
			int landing_color,tx,ty;

			tx=cx;		ty=cy;

			landing_color=lookup_map(tx,ty);
			printf("Trying to land at %d %d\n",tx,ty);
			printf("Color=%d\n",landing_color);
			if (landing_color==12) {
				int loop;

				zint=space_z;

				/* Land the ship */
				for(loop=zint;loop>0;loop--) {

					draw_background_mode7();
					grsim_put_sprite(shadow_forward,SHIPX+3,31+zint);
					grsim_put_sprite(ship_forward,SHIPX,shipy);
					page_flip();
					usleep(200000);

					space_z--;


				}

				return 0;
			}
			else {
				htab(11);
				vtab(22);
				move_cursor();
				print_both_pages("NEED TO LAND ON GRASS!");
			}
		}



		if (speed!=SPEED_STOPPED) {

			dx = (double)speed * 0.25 * our_cos (angle);
			dy = (double)speed * 0.25 * our_sin (angle);

			cx += dx;
			cy += dy;

		}

		draw_background_mode7();

		zint=space_z;

		draw_splash=0;


		if (speed>0) {

			if ((shipy>25) && (turning!=0)) {
				splash_count=1;
			}

			if ((over_water) && (splash_count)) {
				draw_splash=1;
			}
		}

//		printf("VMW: %d %d\n",draw_splash,splash_count);

		if (turning==0) {
			if (draw_splash) {
				grsim_put_sprite(splash_forward,
					SHIPX+1,shipy+9);
			}
			grsim_put_sprite(shadow_forward,SHIPX+3,31+zint);
			grsim_put_sprite(ship_forward,SHIPX,shipy);
		}
		if (turning<0) {

			if (draw_splash) {
				grsim_put_sprite(splash_left,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_left,SHIPX+3,31+zint);
			grsim_put_sprite(ship_left,SHIPX,shipy);
			turning++;
		}
		if (turning>0) {

			if (draw_splash) {
				grsim_put_sprite(splash_right,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_right,SHIPX+3,31+zint);
			grsim_put_sprite(ship_right,SHIPX,shipy);
			turning--;
		}

		page_flip();

		usleep(20000);

	}
	return 0;
}
