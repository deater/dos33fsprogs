#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"

/* Zero page allocations */

#define TURNING		0x60
#define SCREEN_X	0x61	// current screen position
#define SCREEN_Y	0x62
#define ANGLE		0x63	// ship angle
#define HORIZ_SCALE_I	0x64	// horizontal scale
#define HORIZ_SCALE_F	0x65
#define FACTOR_I	0x66
#define FACTOR_F	0x67
#define DX_I		0x68
#define DX_F		0x69
#define SPACEX_I	0x6a	// current space position
#define SPACEX_F	0x6b
#define CX_I		0x6c	// map coordinates
#define CX_F		0x6d
#define DY_I		0x6e
#define DY_F		0x6f
#define SPACEY_I	0x70
#define SPACEY_F	0x71
#define CY_I		0x72
#define CY_F		0x73
#define TEMP_I		0x74
#define TEMP_F		0x75
#define DISTANCE_I	0x76	// the distance and horizontal scale of the line we are drawing
#define DISTANCE_F	0x77
#define SPACEZ_I	0x78	// height of the camera above the plane
#define SPACEZ_F	0x79
#define DRAW_SPLASH	0x7a
#define SPEED		0x7b
#define SPLASH_COUNT	0x7c
#define OVER_WATER	0x7d

#define SHIPY		0xE4

/* constants */
#define	CONST_SCALE_I	0x14		// 20.0
#define CONST_SCALE_F	0x00

#define CONST_BETA_I	0xff		// -0.5 ??
#define CONST_BETA_F	0x80


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

// Speed
#define SPEED_STOPPED	0

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


static void fixed_add(unsigned char x_i,unsigned char x_f,
			unsigned char y_i, unsigned char y_f,
			unsigned char *z_i, unsigned char *z_f) {

	int carry;
	short sum;

	sum=(short)(x_f)+(short)(y_f);

	if (sum>=256) carry=1;
	else carry=0;

	*z_f=sum&0xff;

	*z_i=x_i+y_i+carry;
}


static void fixed_mul(unsigned char x_i, unsigned char x_f,
			unsigned char y_i, unsigned char y_f,
			unsigned char *z_i, unsigned char *z_f) {


	int num1h,num1l;
	int num2h,num2l;
	int result3;
	int result2,result1,result0;
	int aa,xx,cc=0,cc2,yy;
	int negate=0;

	num1h=x_i;
	num1l=x_f;

	if (!(num1h&0x80)) goto check_num2;	// bpl check_num2

	negate++;				// inc negate

	num1l=~num1l;
	num1h=~num1h;

	num1l&=0xff;
	num1h&=0xff;

	num1l+=1;
	cc=!!(num1l&0x100);
	num1h+=cc;

	num1l&=0xff;
	num1h&=0xff;
check_num2:

	num2h=y_i;
	num2l=y_f;

	if (!(num2h&0x80)) goto unsigned_multiply;

	negate++;

	num2l=~num2l;
	num2h=~num2h;

	num2l&=0xff;
	num2h&=0xff;

	num2l+=1;
	cc=!!(num2l&0x100);
	num2h+=cc;

	num2l&=0xff;
	num2h&=0xff;

unsigned_multiply:

//	if (debug) {
//		printf("Using %02x:%02x * %02x:%02x\n",num1h,num1l,num2h,num2l);
//	}

	result0=0;
	result1=0;

	aa=0;		// lda #0 (sz)
	result2=aa;	// sta result+2
	xx=16;		// ldx #16 (sz)
label_l1:
	cc=(num2h&1);	//lsr NUM2+1 (szc)
	num2h>>=1;
	num2h&=0x7f;
//	if (num2_neg) {
//		num2h|=0x80;
//	}

	cc2=(num2l&1);	// ror NUM2 (szc)
	num2l>>=1;
	num2l&=0x7f;


	num2l|=(cc<<7);
	cc=cc2;

	if (cc==0) goto label_l2;	// bcc L2

	yy=aa;				// tay (sz)
	cc=0;				// clc
	aa=num1l;			// lda NUM1 (sz)
	aa=aa+cc+result2;		// adc RESULT+2 (svzc)
	cc=!!(aa&0x100);
	aa&=0xff;
	result2=aa;			// sta RESULT+2
	aa=yy;				// tya
	aa=aa+cc+num1h;			// adc NUM1+1
	cc=!!(aa&0x100);
	aa=aa&0xff;

label_l2:
	cc2=aa&1;
	aa=aa>>1;
	aa&=0x7f;
	aa|=cc<<7;
	cc=cc2;		// ror A

	cc2=result2&1;
	result2=result2>>1;
	result2&=0x7f;
	result2|=(cc<<7);
	cc=cc2;		// ror result+2

	cc2=result1&1;
	result1=result1>>1;
	result1&=0x7f;
	result1|=cc<<7;
	cc=cc2;		// ror result+1

	cc2=result0&1;
	result0=result0>>1;
	result0&=0x7f;
	result0|=cc<<7;
	cc=cc2;		// ror result+0

	xx--;				// dex
	if (xx!=0) goto label_l1;	// bne L1

	result3=aa&0xff;		// sta result+3


//	if (debug) {
//		printf("RAW RESULT = %02x:%02x:%02x:%02x\n",
//			result3&0xff,result2&0xff,result1&0xff,result0&0xff);
//	}

	if (negate&1) {
//		printf("NEGATING!\n");

		cc=0;

		aa=0;
		aa-=result0+cc;
		cc=!!(aa&0x100);
		result0=aa;

		aa=0;
		aa-=result1+cc;
		cc=!!(aa&0x100);
		result1=aa;

		aa=0;
		aa-=result2+cc;
		cc=!!(aa&0x100);
		result2=aa;

		aa=0;
		aa-=result3+cc;
		cc=!!(aa&0x100);
		result3=aa;

	}

	*z_i=result2&0xff;
	*z_f=result1&0xff;

	result3&=0xff;
	result2&=0xff;
	result1&=0xff;
	result0&=0xff;


//	if (debug) {
//		printf("%02x:%02x * %02x:%02x = %02x:%02x:%02x:%02x\n",
//			num1h,num1l,y->i,y->f,
//			result3&0xff,result2&0xff,result1&0xff,result0&0xff);

//		printf("%02x%02x * %02x%02x = %02x%02x%02x%02x\n",
//			num1h,num1l,y->i,y->f,
//			result3,result2,result1,result0);
//	}

//	int a2;
//	int s1,s2;
//	s1=(num1h<<8)|(num1l);
//	s2=(y->i<<8)|(y->f);
//	a2=(result3<<24)|(result2<<16)|(result1<<8)|result0;
//	printf("%d * %d = %d (0x%x)\n",s1,s2,a2,a2);


	return;

}

void draw_background_mode7(void) {


	int map_color;

	ram[OVER_WATER]=0;

	/* Draw Sky */
	/* Originally wanted to be fancy and have sun too, but no */
	color_equals(COLOR_MEDIUMBLUE);
	for(ram[SCREEN_Y]=0;ram[SCREEN_Y]<6;ram[SCREEN_Y]+=2) {
		hlin_double(ram[DRAW_PAGE], 0, 40, ram[SCREEN_Y]);
	}

	/* Draw hazy horizon */
	color_equals(COLOR_GREY);
	hlin_double(ram[DRAW_PAGE], 0, 40, 6);

	fixed_mul(ram[SPACEZ_I],ram[SPACEZ_F],
		CONST_BETA_I,CONST_BETA_F,
		&ram[FACTOR_I],&ram[FACTOR_F]);

	if (!displayed) {
		printf("SPACEZ/BETA/FACTOR %x %x * %x %x = %x %x\n",
			ram[SPACEZ_I],ram[SPACEZ_F],
			CONST_BETA_I, CONST_BETA_F,
			ram[FACTOR_I],ram[FACTOR_F]);
	}

//	printf("spacez=%lf beta=%lf factor=%lf\n",
//		fixed_to_double(ram[SPACEZ_I],ram[SPACEZ_F],),
//		fixed_to_double(&BETA),
//		fixed_to_double(ram[FACTOR_I],ram[FACTOR_F]));

	for (ram[SCREEN_Y] = 8; ram[SCREEN_Y] < LOWRES_H; ram[SCREEN_Y]+=2) {

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
		ram[HORIZ_SCALE_I]=0;
		ram[HORIZ_SCALE_F]=
			horizontal_lookup[ram[SPACEZ_I]&0xf]
						[(ram[SCREEN_Y]-8)/2];

		if (!displayed) {
			printf("HORIZ_SCALE %x %x\n",
			ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F]);
		}

		// calculate the distance of the line we are drawing
		fixed_mul(ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F],
			CONST_SCALE_I,CONST_SCALE_F,
			&ram[DISTANCE_I],&ram[DISTANCE_F]);

		if (!displayed) {
			printf("DISTANCE %x:%x\n",ram[DISTANCE_I],ram[DISTANCE_F]);
		}

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		ram[DX_I]=fixed_sin[(ram[ANGLE]+8)&0xf].i;	// -sin()
		ram[DX_F]=fixed_sin[(ram[ANGLE]+8)&0xf].f;	// -sin()
		fixed_mul(ram[DX_I],ram[DX_F],
			ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F],
			&ram[DX_I],&ram[DX_F]);

		if (!displayed) {
			printf("DX %x:%x\n",ram[DX_I],ram[DX_F]);
		}


		ram[DY_I]=fixed_sin[(ram[ANGLE]+4)&0xf].i;	// cos()
		ram[DY_F]=fixed_sin[(ram[ANGLE]+4)&0xf].f;	// cos()
		fixed_mul(ram[DY_I],ram[DY_F],
			ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F],
			&ram[DY_I],&ram[DY_F]);

		if (!displayed) {
			printf("DY %x:%x\n",ram[DY_I],ram[DY_F]);
		}

		// calculate the starting position
		fixed_add(ram[DISTANCE_I],ram[DISTANCE_F],
			ram[FACTOR_I],ram[FACTOR_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);
		ram[TEMP_I]=fixed_sin[(ram[ANGLE]+4)&0xf].i; // cos
		ram[TEMP_F]=fixed_sin[(ram[ANGLE]+4)&0xf].f; // cos
		fixed_mul(ram[SPACEX_I],ram[SPACEX_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);
		fixed_add(ram[SPACEX_I],ram[SPACEX_F],
			ram[CX_I],ram[CX_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);
		ram[TEMP_I]=0xec;	// -20 (LOWRES_W/2)
		ram[TEMP_F]=0;
		fixed_mul(ram[TEMP_I],ram[TEMP_F],
			ram[DX_I],ram[DX_F],
			&ram[TEMP_I],&ram[TEMP_F]);
		fixed_add(ram[SPACEX_I],ram[SPACEX_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);

		if (!displayed) {
			printf("SPACEX! %x:%x\n",
			ram[SPACEX_I],ram[SPACEX_F]);
		}

		fixed_add(ram[DISTANCE_I],ram[DISTANCE_F],
			ram[FACTOR_I],ram[FACTOR_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);
		ram[TEMP_I]=fixed_sin[ram[ANGLE]&0xf].i;
		ram[TEMP_F]=fixed_sin[ram[ANGLE]&0xf].f;
		fixed_mul(ram[SPACEY_I],ram[SPACEY_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);
		fixed_add(ram[SPACEY_I],ram[SPACEY_F],
			ram[CY_I],ram[CY_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);
		ram[TEMP_I]=0xec;	// -20 (LOWRES_W/2)
		ram[TEMP_F]=0;
		fixed_mul(ram[TEMP_I],ram[TEMP_F],
			ram[DY_I],ram[DY_F],
			&ram[TEMP_I],&ram[TEMP_F]);
		fixed_add(ram[SPACEY_I],ram[SPACEY_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);

		if (!displayed) {
			printf("SPACEY! %x:%x\n",ram[SPACEY_I],ram[SPACEY_F]);
		}

		// go through all points in this screen line
		for (ram[SCREEN_X] = 0; ram[SCREEN_X] < LOWRES_W-1; ram[SCREEN_X]++) {
			// get a pixel from the tile and put it on the screen

			map_color=lookup_map(ram[SPACEX_I],ram[SPACEY_I]);

			ram[COLOR]=map_color;
			ram[COLOR]|=map_color<<4;

			if ((ram[SCREEN_X]==20) && (ram[SCREEN_Y]==38)) {
				if (map_color==COLOR_DARKBLUE) ram[OVER_WATER]=1;
			}

			hlin_double(ram[DRAW_PAGE], ram[SCREEN_X], ram[SCREEN_X]+1,
				ram[SCREEN_Y]);

			// advance to the next position in space
			fixed_add(ram[SPACEX_I],ram[SPACEX_F],
				ram[DX_I],ram[DX_F],
				&ram[SPACEX_I],&ram[SPACEX_F]);
			fixed_add(ram[SPACEY_I],ram[SPACEY_F],
				ram[DY_I],ram[DY_F],
				&ram[SPACEY_I],&ram[SPACEY_F]);
		}
	}
	displayed=1;
}


#define SHIPX	15

int flying(void) {

	unsigned char ch;
	int draw_splash=0,splash_count=0;
	int zint;

	long long cycles=0;

	/************************************************/
	/* Flying					*/
	/************************************************/

	gr();
	clear_bottom(PAGE0);	/* jsr clear_screens */
	clear_bottom(PAGE1);	/* jsr set_gr_page0 */

	ram[SHIPY]=20;		/* lda #20 */
				/* sta SHIPY */
				/* lda #0 */
	ram[TURNING]=0;		/* sta TURNING */
	ram[SPACEX_I]=0;	/* sta SPACEX_I */
	ram[SPACEY_I]=0;	/* sta SPACEY_I */
	ram[CX_I]=0;		/* sta CX_I */
	ram[CX_F]=0;		/* sta CX_F */
	ram[CY_I]=0;		/* sta CY_I */
	ram[CY_F]=0;		/* sta CY_F */
	ram[DRAW_SPLASH]=0;	/* sta DRAW_SPLASH */
	ram[SPEED]=0;		/* sta SPEED */
	ram[SPLASH_COUNT]=0;	/* sta SPLASH_COUNT */
	ram[OVER_WATER]=0;	/* sta OVER_WATER */

				/* lda #1 */
	ram[ANGLE]=1;		/* sta ANGLE */

				/* lda #4 */
	ram[SPACEZ_I]=4;	/* sta SPACEZ_I */
				/* lda #$80 */
	ram[SPACEZ_F]=0x80;	/* sta SPACEZ_F */

	while(1) {
		cycles=0;

		if (splash_count>0) splash_count--;

		ch=grsim_input();

		if ((ch=='q') || (ch==27))  break;

		if ((ch=='w') || (ch==APPLE_UP)) {
			if (ram[SHIPY]>16) {
				ram[SHIPY]-=2;
				ram[SPACEZ_I]++;
			}
			splash_count=0;
		}
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			if (ram[SHIPY]<28) {
				ram[SHIPY]+=2;
				ram[SPACEZ_I]--;
			}
			else {
				splash_count=10;
			}
		}
		if ((ch=='a') || (ch==APPLE_LEFT)) {
			if ((ram[TURNING]>0) && (!(ram[TURNING]&0x80))) {
				ram[TURNING]=0;
			}
			else {
				ram[TURNING]=235; // -20

				ram[ANGLE]-=1;
				if (ram[ANGLE]<0) ram[ANGLE]+=ANGLE_STEPS;
			}
		}
		if ((ch=='d') || (ch==APPLE_RIGHT)) {
			if (ram[TURNING]>128) {
				ram[TURNING]=0;
			}
			else {
				ram[TURNING]=20;
				ram[ANGLE]+=1;
				if (ram[ANGLE]>=ANGLE_STEPS) ram[ANGLE]-=ANGLE_STEPS;
			}

		}

		/* Used to be able to go backwards */
		if (ch=='z') {
			if (ram[SPEED]<3) ram[SPEED]++;
		}

		if (ch=='x') {
			if (ram[SPEED]>0) ram[SPEED]--;
		}

		if (ch==' ') {
			ram[SPEED]=SPEED_STOPPED;
		}

		if (ch=='h') {
			print_help();
		}

		/* Ending */
		if (ch==13) {
			int landing_color,tx,ty;
			tx=ram[CX_I];	ty=ram[CY_I];

			landing_color=lookup_map(tx,ty);
			printf("Trying to land at %d %d\n",tx,ty);
			printf("Color=%d\n",landing_color);
			if (landing_color==12) {
				int loop;

				zint=ram[SPACEZ_I];

				/* Land the ship */
				for(loop=zint;loop>0;loop--) {

					draw_background_mode7();
					grsim_put_sprite(shadow_forward,SHIPX+3,31+zint);
					grsim_put_sprite(ship_forward,SHIPX,ram[SHIPY]);
					page_flip();
					usleep(200000);

					ram[SPACEZ_I]--;


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



		if (ram[SPEED]!=SPEED_STOPPED) {

			int ii;

			ram[DX_I] = fixed_sin_scale[(ram[ANGLE]+4)&0xf].i;        // cos
			ram[DX_F] = fixed_sin_scale[(ram[ANGLE]+4)&0xf].f;        // cos
			ram[DY_I] = fixed_sin_scale[ram[ANGLE]&0xf].i;
			ram[DY_F] = fixed_sin_scale[ram[ANGLE]&0xf].f;

			for(ii=0;ii<ram[SPEED];ii++) {
				fixed_add(ram[CX_I],ram[CX_F],
					ram[DX_I],ram[DX_F],
					&ram[CX_I],&ram[CX_F]);
				fixed_add(ram[CY_I],ram[CY_F],
					ram[DY_I],ram[DY_F],
					&ram[CY_I],&ram[CY_F]);
			}

		}

		draw_background_mode7();

		zint=ram[SPACEZ_I];

		draw_splash=0;


		if (ram[SPEED]>0) {

			if ((ram[SHIPY]>25) && (ram[TURNING]!=0)) {
				splash_count=1;
			}

			if ((ram[OVER_WATER]) && (splash_count)) {
				draw_splash=1;
			}
		}

//		printf("VMW: %d %d\n",draw_splash,splash_count);

		if (ram[TURNING]==0) {
			if (draw_splash) {
				grsim_put_sprite(splash_forward,
					SHIPX+1,ram[SHIPY]+9);
			}
			grsim_put_sprite(shadow_forward,SHIPX+3,31+zint);
			grsim_put_sprite(ship_forward,SHIPX,ram[SHIPY]);
		}
		else if (ram[TURNING]>128) {

			if (draw_splash) {
				grsim_put_sprite(splash_left,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_left,SHIPX+3,31+zint);
			grsim_put_sprite(ship_left,SHIPX,ram[SHIPY]);
			ram[TURNING]++;
		}
		else {

			if (draw_splash) {
				grsim_put_sprite(splash_right,
						SHIPX+1,36);
			}
			grsim_put_sprite(shadow_right,SHIPX+3,31+zint);
			grsim_put_sprite(ship_right,SHIPX,ram[SHIPY]);
			ram[TURNING]--;
		}

		page_flip();

		printf("Cycles: %lld\n",cycles);
		usleep(20000);

	}
	return 0;
}






