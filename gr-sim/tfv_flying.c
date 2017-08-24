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
struct fixed_type speed = {0,0};

// step for points in space between two pixels on a horizontal line
struct fixed_type line_dx = {0,0};
struct fixed_type line_dy = {0,0};

// current space position

// height of the camera above the plane
struct fixed_type space_z= {0x04,0x80};	// 4.5;

struct fixed_type BETA = {0xff,0x80}; 	// -0.5;
#else


// map coordinates
static double double_cx;
static double double_cy;
static struct fixed_type cx = {0,0};
static struct fixed_type cy = {0,0};
static struct fixed_type dx;
static struct fixed_type dy;

#define SPEED_STOPPED	0

static unsigned char speed=SPEED_STOPPED;	// 0..4, with 0=stopped

// the distance and horizontal scale of the line we are drawing
static double double_distance=0;
static double double_horizontal_scale=0;
static struct fixed_type distance;
static struct fixed_type horizontal_scale;

// step for points in space between two pixels on a horizontal line
static double line_dx=0;
static double line_dy=0;

// current space position
static double double_space_x,double_space_y;
static struct fixed_type space_x;
static struct fixed_type space_y;

// height of the camera above the plane
static double space_z=4.5;
static double BETA=-0.5;

#endif

static int horizon=-2;    // number of pixels line 0 is below the horizon

static double SCALE=16.0;

#define ANGLE_STEPS	16

// FIXME: take advantage of symmetry?

static struct fixed_type fixed_sin[ANGLE_STEPS]={
	{0x00,0x00}, //  0.000000=00.00
	{0x00,0x61}, //  0.382683=00.61
	{0x00,0xb5}, //  0.707107=00.b5
	{0x00,0xec}, //  0.923880=00.ec
	{0x01,0x00}, //  1.000000=01.00
	{0x00,0xec}, //  0.923880=00.ec
	{0x00,0xb5}, //  0.707107=00.b5
	{0x00,0x61}, //  0.382683=00.61
	{0x00,0x00}, //  0.000000=00.00
	{0xff,0x9f}, // -0.382683=ff.9f
	{0xff,0x4b}, // -0.707107=ff.4b
	{0xff,0x14}, // -0.923880=ff.14
	{0xff,0x00}, // -1.000000=ff.00
	{0xff,0x14}, // -0.923880=ff.14
	{0xff,0x4b}, // -0.707107=ff.4b
	{0xff,0x9f}, // -0.382683=ff.9f
};

// div by 8
static struct fixed_type fixed_sin_scale[ANGLE_STEPS]={
	{0x00,0x00},
	{0x00,0x0c},
	{0x00,0x16},
	{0x00,0x1d},
	{0x00,0x20},
	{0x00,0x1d},
	{0x00,0x16},
	{0x00,0x0c},
	{0x00,0x00},
	{0xff,0xf4},
	{0xff,0xea},
	{0xff,0xe3},
	{0xff,0xe0},
	{0xff,0xe3},
	{0xff,0xea},
	{0xff,0xf4},
};

static double sin_table[ANGLE_STEPS]={
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

static double our_sin(unsigned char angle) {
	return sin_table[angle&0xf];
}

static double our_cos(unsigned char angle) {

	return sin_table[(angle+4)&0xf];
}

static void fixed_to_double(struct fixed_type *f, double *d) {

	*d=f->i;
	*d+=((double)(f->f))/256.0;
}

static void fixed_add(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {
	int carry;
	short sum;

	sum=(short)(x->f)+(short)(y->f);

	if (sum>=256) carry=1;
	else carry=0;

	z->f=sum&0xff;

	z->i=x->i+y->i+carry;
}

static void double_to_fixed(double d, struct fixed_type *f) {

        int temp;

        temp=d*256;

        f->i=(temp>>8)&0xff;

        f->f=temp&0xff;
}

static void fixed_mul(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {

        int a,b,c;

        a=((x->i)<<8)+(x->f);
        b=((y->i)<<8)+(y->f);

        c=a*b;

        c>>=8;

        z->i=(c>>8);
        z->f=(c&0xff);
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

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
		double_horizontal_scale = space_z  / (screen_y + horizon);
		double_to_fixed(double_horizontal_scale,&horizontal_scale);

		// calculate the distance of the line we are drawing
		double_distance = double_horizontal_scale * SCALE;
		double_to_fixed(double_distance,&distance);

//		printf("Distance=%lf, horizontal-scale=%lf\n",
//			distance,horizontal_scale);

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		dx.i=fixed_sin[(angle+8)&0xf].i;	// -sin()
		dx.f=fixed_sin[(angle+8)&0xf].f;	// -sin()
		fixed_mul(&dx,&horizontal_scale,&dx);

		dy.i=fixed_sin[(angle+4)&0xf].i;	// cos()
		dy.f=fixed_sin[(angle+4)&0xf].f;	// cos()
		fixed_mul(&dy,&horizontal_scale,&dy);

		fixed_to_double(&dx,&line_dx);
		fixed_to_double(&dy,&line_dy);


		// Move camera back a bit
		double factor;
		factor=space_z*BETA;

		// calculate the starting position
		double_space_x = double_cx +
			((double_distance+factor) * our_cos(angle)) -
			(LOWRES_W/2 * line_dx);
		double_space_y = double_cy +
			((double_distance+factor) * our_sin(angle)) -
			(LOWRES_W/2 * line_dy);

		double_to_fixed(double_space_x,&space_x);
		double_to_fixed(double_space_y,&space_y);

		// go through all points in this screen line
		for (screen_x = 0; screen_x < LOWRES_W-1; screen_x++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map(space_x.i,space_y.i);

			ram[COLOR]=map_color;
			ram[COLOR]|=map_color<<4;

			if (screen_x==20) {
				if (map_color==COLOR_DARKBLUE) over_water=1;
				else over_water=0;
			}

			hlin_double(ram[DRAW_PAGE], screen_x, screen_x+1,
				screen_y);

			// advance to the next position in space
			fixed_add(&space_x,&dx,&space_x);
			fixed_add(&space_y,&dy,&space_y);
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

		if (ch=='h') {
			horizon--;
			if (horizon<-4) horizon=4;

			printf("horizon=%d\n",horizon);
		}

		if (ch=='y') {
			if (SCALE==20) SCALE=16;
			else SCALE=20;
			printf("SCALE=%lf\n",SCALE);
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

			dx.i = fixed_sin_scale[(angle+4)&0xf].i;	// cos
			dx.f = fixed_sin_scale[(angle+4)&0xf].f;	// cos
			dy.i = fixed_sin_scale[angle&0xf].i;
			dy.f = fixed_sin_scale[angle&0xf].f;


			for(ii=0;ii<speed;ii++) {
				fixed_add(&cx,&dx,&cx);
				fixed_add(&cy,&dy,&cy);
			}
			fixed_to_double(&cx,&double_cx);
			fixed_to_double(&cy,&double_cy);

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
