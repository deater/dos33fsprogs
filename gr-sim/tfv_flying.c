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

// 1 = use reduced fixed point
// 0 = use fancy hi-res floating point
#define FIXEDPT	1


#if FIXEDPT

// map coordinates
static struct fixed_type cx = {0,0};
static struct fixed_type cy = {0,0};
static struct fixed_type dx;
static struct fixed_type dy;

// the distance and horizontal scale of the line we are drawing
static struct fixed_type distance;
static struct fixed_type horizontal_scale;

// current space position
static struct fixed_type space_x;
static struct fixed_type space_y;

// height of the camera above the plane
static struct fixed_type space_z= {0x04,0x80};	// 4.5;
static struct fixed_type BETA = {0xff,0x80}; 	// -0.5;
static struct fixed_type factor;

static struct fixed_type fixed_temp;

static struct fixed_type scale={0x14,0x00};	// 20.0

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

static unsigned char horizontal_lookup[7][16] = {
	{0x0C,0x0A,0x09,0x08,0x07,0x06,0x05,0x05,0x04,0x04,0x04,0x04,0x03,0x03,0x03,0x03,},
	{0x26,0x20,0x1B,0x18,0x15,0x13,0x11,0x10,0x0E,0x0D,0x0C,0x0C,0x0B,0x0A,0x0A,0x09,},
	{0x40,0x35,0x2D,0x28,0x23,0x20,0x1D,0x1A,0x18,0x16,0x15,0x14,0x12,0x11,0x10,0x10,},
	{0x59,0x4A,0x40,0x38,0x31,0x2C,0x28,0x25,0x22,0x20,0x1D,0x1C,0x1A,0x18,0x17,0x16,},
	{0x73,0x60,0x52,0x48,0x40,0x39,0x34,0x30,0x2C,0x29,0x26,0x24,0x21,0x20,0x1E,0x1C,},
	{0x8C,0x75,0x64,0x58,0x4E,0x46,0x40,0x3A,0x36,0x32,0x2E,0x2C,0x29,0x27,0x25,0x23,},
	{0xA6,0x8A,0x76,0x68,0x5C,0x53,0x4B,0x45,0x40,0x3B,0x37,0x34,0x30,0x2E,0x2B,0x29,},
};



double fixed_to_double(struct fixed_type *f) {

	double out;

	out=f->i;
	out+=((double)(f->f))/256.0;

	return out;

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

//static void double_to_fixed(double d, struct fixed_type *f) {
//
//	int temp;
//
//	temp=d*256;
//
//	f->i=(temp>>8)&0xff;
//
//	f->f=temp&0xff;
//}


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

//	fixed_to_double(&space_z,&double_space_z);
//	double_factor=double_space_z*double_BETA;

	fixed_mul(&space_z,&BETA,&factor,0);

	if (!displayed) {
		printf("SPACEZ/BETA/FACTOR %x %x * %x %x = %x %x\n",
			space_z.i,space_z.f,BETA.i,BETA.f,factor.i,factor.f);
	}

//	printf("spacez=%lf beta=%lf factor=%lf\n",
//		fixed_to_double(&space_z),
//		fixed_to_double(&BETA),
//		fixed_to_double(&factor));

	for (screen_y = 8; screen_y < LOWRES_H; screen_y+=2) {

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
//		double_horizontal_scale = double_space_z  / (screen_y + horizon);
//		double_to_fixed(double_horizontal_scale,&horizontal_scale);
		horizontal_scale.i=0;
		horizontal_scale.f=
			horizontal_lookup[space_z.i&0xf][(screen_y-8)/2];

		if (!displayed) {
			printf("HORIZ_SCALE %x %x\n",
			horizontal_scale.i,horizontal_scale.f);
		}

		// calculate the distance of the line we are drawing
		fixed_mul(&horizontal_scale,&scale,&distance,0);
		//fixed_to_double(&distance,&double_distance);

//		printf("Distance=%lf, horizontal-scale=%lf\n",
//			distance,horizontal_scale);


		if (!displayed) {
			printf("DISTANCE %x:%x\n",
			distance.i,distance.f);
		}

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		dx.i=fixed_sin[(angle+8)&0xf].i;	// -sin()
		dx.f=fixed_sin[(angle+8)&0xf].f;	// -sin()
		fixed_mul(&dx,&horizontal_scale,&dx,0);

		if (!displayed) {
			printf("DX %x:%x\n",
			dx.i,dx.f);
		}


		dy.i=fixed_sin[(angle+4)&0xf].i;	// cos()
		dy.f=fixed_sin[(angle+4)&0xf].f;	// cos()
		fixed_mul(&dy,&horizontal_scale,&dy,0);

		if (!displayed) {
			printf("DY %x:%x\n",
			dy.i,dy.f);
		}

		// calculate the starting position
		//double_space_x =(double_distance+double_factor);
		fixed_add(&distance,&factor,&space_x);
//		double_to_fixed(double_space_x,&space_x);
		fixed_temp.i=fixed_sin[(angle+4)&0xf].i; // cos
		fixed_temp.f=fixed_sin[(angle+4)&0xf].f; // cos
		fixed_mul(&space_x,&fixed_temp,&space_x,0);
		fixed_add(&space_x,&cx,&space_x);
		fixed_temp.i=0xec;	// -20 (LOWRES_W/2)
		fixed_temp.f=0;
		fixed_mul(&fixed_temp,&dx,&fixed_temp,0);
		fixed_add(&space_x,&fixed_temp,&space_x);

		if (!displayed) {
			printf("SPACEX! %x:%x\n",
			space_x.i,space_x.f);
		}

		fixed_add(&distance,&factor,&space_y);
//		double_space_y =(double_distance+double_factor);
//		double_to_fixed(double_space_y,&space_y);
		fixed_temp.i=fixed_sin[angle&0xf].i;
		fixed_temp.f=fixed_sin[angle&0xf].f;
		fixed_mul(&space_y,&fixed_temp,&space_y,0);
		fixed_add(&space_y,&cy,&space_y);
		fixed_temp.i=0xec;	// -20 (LOWRES_W/2)
		fixed_temp.f=0;
		fixed_mul(&fixed_temp,&dy,&fixed_temp,0);
		fixed_add(&space_y,&fixed_temp,&space_y);

		if (!displayed) {
			printf("SPACEY! %x:%x\n",
			space_y.i,space_y.f);
		}

		// go through all points in this screen line
		for (screen_x = 0; screen_x < LOWRES_W-1; screen_x++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map(space_x.i,space_y.i);

			ram[COLOR]=map_color;
			ram[COLOR]|=map_color<<4;

			if ((screen_x==20) && (screen_y==38)) {
				if (map_color==COLOR_DARKBLUE) over_water=1;
			}

			hlin_double(ram[DRAW_PAGE], screen_x, screen_x+1,
				screen_y);

			// advance to the next position in space
			fixed_add(&space_x,&dx,&space_x);
			fixed_add(&space_y,&dy,&space_y);
		}
	}
	displayed=1;
}



















#else

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


#endif


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
	clear_bottom(PAGE0);
	clear_bottom(PAGE1);

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
#if FIXEDPT
				space_z.i++;
#else
				space_z+=1;
#endif
			}
			splash_count=0;

//			printf("Z=%lf\n",space_z);
		}
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			if (shipy<28) {
				shipy+=2;
#if FIXEDPT
				space_z.i--;
#else
				space_z-=1;
#endif
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
#if FIXEDPT
			tx=cx.i;	ty=cy.i;
#else
			tx=cx;		ty=cy;
#endif
			landing_color=lookup_map(tx,ty);
			printf("Trying to land at %d %d\n",tx,ty);
			printf("Color=%d\n",landing_color);
			if (landing_color==12) {
				int loop;

#if FIXEDPT
				zint=space_z.i;
#else
				zint=space_z;
#endif

				/* Land the ship */
				for(loop=zint;loop>0;loop--) {

					draw_background_mode7();
					grsim_put_sprite(shadow_forward,SHIPX+3,31+zint);
					grsim_put_sprite(ship_forward,SHIPX,shipy);
					page_flip();
					usleep(200000);

#if FIXEDPT
					space_z.i--;
#else
					space_z--;
#endif

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
#if FIXEDPT
			int ii;

			dx.i = fixed_sin_scale[(angle+4)&0xf].i;        // cos
			dx.f = fixed_sin_scale[(angle+4)&0xf].f;        // cos
			dy.i = fixed_sin_scale[angle&0xf].i;
			dy.f = fixed_sin_scale[angle&0xf].f;

			for(ii=0;ii<speed;ii++) {
				fixed_add(&cx,&dx,&cx);
				fixed_add(&cy,&dy,&cy);
			}

#else
			dx = (double)speed * 0.25 * our_cos (angle);
			dy = (double)speed * 0.25 * our_sin (angle);

			cx += dx;
			cy += dy;
#endif
		}

		draw_background_mode7();

#if FIXEDPT
		zint=space_z.i;
#else
		zint=space_z;
#endif

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
