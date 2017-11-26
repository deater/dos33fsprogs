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
#define OVER_LAND	0x7d
#define NUM1L		0x7E
#define NUM1H		0x7F
#define NUM2L		0x80
#define NUM2H		0x81
#define RESULT		0x82	// 83,84,85
#define NEGATE		0x86	// UNUSED?
#define LAST_SPACEX_I   0x87
#define LAST_SPACEY_I	0x88
#define LAST_MAP_COLOR	0x89
#define DRAW_SKY	0x8A

#define SHIPY		0xE4

/* constants */
#define	CONST_SCALE_I	0x14		// 20.0
#define CONST_SCALE_F	0x00

#define CONST_BETA_I	0xff		// -0.5 ??
#define CONST_BETA_F	0x80

#define CONST_SHIPX	15

#define CONST_LOWRES_HALF_I	0xec	// -20 (LOWRES_W/2)
#define CONST_LOWRES_HALF_F	0x0


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

static int displayed=1;

struct cycle_counts {
	int flying;
	int getkey;
	int page_flip;
	int mode7;
	int multiply;
	int lookup_map;
	int put_sprite;
} cycles;

static int last_color=0,last_xx=0,last_yy=0;

static int lookup_map(int xx, int yy) {

	int color,offset;

	last_xx=xx;
	xx=xx&MASK_X;

	last_yy=yy;
	yy=yy&MASK_Y;


	if (!displayed) {
		printf("XX,YY! %x,%x\n",xx,yy);
	}


//	if ( ((y&0x3)==1) && ((x&7)==0) ) color=14;
//	if ( ((y&0x3)==3) && ((x&7)==4) ) color=14;

	offset=yy<<3;
	offset+=xx;

				cycles.lookup_map+=34;

	if ((yy>7) || (xx>7)) {
			cycles.lookup_map+=14;
		color=water_map[offset&0x1f];
			cycles.lookup_map+=11;
		goto update_cache;

	}

	/* 2 2 2 2  2 2 2 2 */
	/* e 2 2 2  2 2 2 2 */
	/* 2 2 2 2  2 2 2 2 */
	/* 2 2 2 2  e 2 2 2 */

	color=flying_map[offset];
				cycles.lookup_map+=8;

	if (!displayed) {
		printf("COLOR! %x\n",color);
	}


update_cache:
				cycles.lookup_map+=9;
	last_color=color;
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

//static unsigned char horizontal_lookup[7][16] = {
//	{0x0C,0x0A,0x09,0x08,0x07,0x06,0x05,0x05,0x04,0x04,0x04,0x04,0x03,0x03,0x03,0x03,},
//	{0x26,0x20,0x1B,0x18,0x15,0x13,0x11,0x10,0x0E,0x0D,0x0C,0x0C,0x0B,0x0A,0x0A,0x09,},
//	{0x40,0x35,0x2D,0x28,0x23,0x20,0x1D,0x1A,0x18,0x16,0x15,0x14,0x12,0x11,0x10,0x10,},
//	{0x59,0x4A,0x40,0x38,0x31,0x2C,0x28,0x25,0x22,0x20,0x1D,0x1C,0x1A,0x18,0x17,0x16,},
//	{0x73,0x60,0x52,0x48,0x40,0x39,0x34,0x30,0x2C,0x29,0x26,0x24,0x21,0x20,0x1E,0x1C,},
//	{0x8C,0x75,0x64,0x58,0x4E,0x46,0x40,0x3A,0x36,0x32,0x2E,0x2C,0x29,0x27,0x25,0x23,},
//	{0xA6,0x8A,0x76,0x68,0x5C,0x53,0x4B,0x45,0x40,0x3B,0x37,0x34,0x30,0x2E,0x2B,0x29,},
//};

//static unsigned char horizontal_lookup[7][32] = {
static unsigned char horizontal_lookup[7*32] = {
	0x0C,0x0B,0x0A,0x09,0x09,0x08,0x08,0x07,
	0x07,0x06,0x06,0x06,0x05,0x05,0x05,0x05,
	0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x03,
	0x03,0x03,0x03,0x03,0x03,0x03,0x03,0x03,
	0x26,0x22,0x20,0x1D,0x1B,0x19,0x18,0x16,
	0x15,0x14,0x13,0x12,0x11,0x10,0x10,0x0F,
	0x0E,0x0E,0x0D,0x0D,0x0C,0x0C,0x0C,0x0B,
	0x0B,0x0A,0x0A,0x0A,0x0A,0x09,0x09,0x09,
	0x40,0x3A,0x35,0x31,0x2D,0x2A,0x28,0x25,
	0x23,0x21,0x20,0x1E,0x1D,0x1B,0x1A,0x19,
	0x18,0x17,0x16,0x16,0x15,0x14,0x14,0x13,
	0x12,0x12,0x11,0x11,0x10,0x10,0x10,0x0F,
	0x59,0x51,0x4A,0x44,0x40,0x3B,0x38,0x34,
	0x31,0x2F,0x2C,0x2A,0x28,0x26,0x25,0x23,
	0x22,0x21,0x20,0x1E,0x1D,0x1C,0x1C,0x1B,
	0x1A,0x19,0x18,0x18,0x17,0x16,0x16,0x15,
	0x73,0x68,0x60,0x58,0x52,0x4C,0x48,0x43,
	0x40,0x3C,0x39,0x36,0x34,0x32,0x30,0x2E,
	0x2C,0x2A,0x29,0x27,0x26,0x25,0x24,0x22,
	0x21,0x20,0x20,0x1F,0x1E,0x1D,0x1C,0x1C,
	0x8C,0x80,0x75,0x6C,0x64,0x5D,0x58,0x52,
	0x4E,0x4A,0x46,0x43,0x40,0x3D,0x3A,0x38,
	0x36,0x34,0x32,0x30,0x2E,0x2D,0x2C,0x2A,
	0x29,0x28,0x27,0x26,0x25,0x24,0x23,0x22,
	0xA6,0x97,0x8A,0x80,0x76,0x6E,0x68,0x61,
	0x5C,0x57,0x53,0x4F,0x4B,0x48,0x45,0x42,
	0x40,0x3D,0x3B,0x39,0x37,0x35,0x34,0x32,
	0x30,0x2F,0x2E,0x2C,0x2B,0x2A,0x29,0x28,
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


// Description: Unsigned 16-bit multiplication with unsigned 32-bit result.
// Input: 16-bit unsigned value in T1
// 16-bit unsigned value in T2
// Carry=0: Re-use T1 from previous multiplication (faster)
// Carry=1: Set T1 (slower)
//
// Output: 32-bit unsigned value in PRODUCT
// Clobbered: PRODUCT, X, A, C
// Allocation setup: T1,T2 and PRODUCT preferably on Zero-page.
//                   square1_lo, square1_hi, square2_lo, square2_hi must be
//                   page aligned. Each table are 512 bytes. Total 2kb.
//
// Table generation: I:0..511
//                   square1_lo = <((I*I)/4)
//                   square1_hi = >((I*I)/4)
//                   square2_lo = <(((I-255)*(I-255))/4)
//                   square2_hi = >(((I-255)*(I-255))/4)

static unsigned char square1_lo[512];
static unsigned char square1_hi[512];
static unsigned char square2_lo[512];
static unsigned char square2_hi[512];
static int sm1a,sm3a,sm5a,sm7a;
static int sm2a,sm4a,sm6a,sm8a;
static int sm1b,sm3b,sm5b,sm7b;
static int sm2b,sm4b,sm6b,sm8b;


static int table_ready=0;

static void init_table(void) {

	int i;

	for(i=0;i<512;i++) {
		square1_lo[i]=((i*i)/4)&0xff;
		square1_hi[i]=(((i*i)/4)>>8)&0xff;
		square2_lo[i]=( ((i-255)*(i-255))/4)&0xff;
		square2_hi[i]=(( ((i-255)*(i-255))/4)>>8)&0xff;
//		printf("%d %x:%x %x:%x\n",i,square1_hi[i],square1_lo[i],
//			square2_hi[i],square2_lo[i]);
	}
	table_ready=1;

	// 3 * 2
	// 3+2 = 5
	// 3-2 = 1
	// (25 - 1) = 24/4 = 6

//	int num1l,num2l,a1,a2;

//	num1l=7;
//	num2l=9;

//	printf("Trying %d*%d\n",num1l,num2l);
//	a1=square1_lo[num1l+num2l];
//	printf("((%d+%d)^2)/4: %d\n",num1l,num2l,a1);
//	a2=square2_lo[((~num1l)&0xff)+num2l];
//	printf("((%d-%d)^2)/4: %d\n",num1l,num2l,a2);

//	printf("%d*%d=%d\n",num1l,num2l,a1-a2);

}

static unsigned int product[4];

static int fixed_mul_unsigned(
		unsigned char x_i, unsigned char x_f,
	 	unsigned char y_i, unsigned char y_f,
		unsigned char *z_i, unsigned char *z_f,
			int debug, int reuse) {

//	<T1 * <T2 = AAaa
//	<T1 * >T2 = BBbb
//	>T1 * <T2 = CCcc
//	>T1 * >T2 = DDdd
//
//	       AAaa
//	     BBbb
//	     CCcc
//	 + DDdd
//	 ----------
//	   PRODUCT!

//                ; Setup T1 if changed
	int c=0;
	int a,x;

	int _AA,_BB,_CC,_DD,_aa,_bb,_cc,_dd;

	if (!table_ready) init_table();

//	printf("\t\t\tMultiplying %2x:%2x * %2x:%2x\n",x_i,x_f,y_i,y_f);

	/* Set up self-modifying code */
	if (reuse==0) {
		a=(x_f)&0xff;		// lda T1+0		; 3
		sm1a=a;			// sta sm1a+1		; 3
		sm3a=a;			// sta sm3a+1		; 3
		sm5a=a;			// sta sm5a+1		; 3
		sm7a=a;			// sta sm7a+1		; 3
		a=(~a)&0xff;		// eor #$ff		; 2
		sm2a=a;			// sta sm2a+1		; 3
		sm4a=a;			// sta sm4a+1		; 3
		sm6a=a;			// sta sm6a+1		; 3
		sm8a=a;			// sta sm8a+1		; 3
		a=(x_i)&0xff;		// lda T1+1		; 3
		sm1b=a;			// sta sm1b+1		; 3
		sm3b=a;			// sta sm3b+1		; 3
		sm5b=a;			// sta sm5b+1		; 3
		sm7b=a;			// sta sm7b+1		; 3
		a=(~a)&0xff;		// eor #$ff		; 2
		sm2b=a;			// sta sm2b+1		; 3
		sm4b=a;			// sta sm4b+1		; 3
		sm6b=a;			// sta sm6b+1		; 3
		sm8b=a;			// sta sm8b+1		; 3
					cycles.multiply+=58;
	}

	/* Perform <T1 * <T2 = AAaa */
	x=(y_f)&0xff;			// ldx T2+0 (low le)		; 3
	c=1;					// sec			; 2
//sm1a:
	a=square1_lo[sm1a+x];			// lda square1_lo,x	; 4
//sm2a:
	a+=~(square2_lo[sm2a+x])+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;

//	printf("\t\t\t\ta=(%d+%d)^2/4=%d "
//		"b=(%d+%d)^2/4=%d\n",
//		sm1a,x,square1_lo[sm1a+x],
//		sm2a,x,square2_lo[sm2a+x]);
	product[0]=a;				// sta PRODUCT+0	; 3
	_aa=a;
//	printf("\t\t\t\ta-b aa=%2x\n",a);
//sm3a:
	a=square1_hi[sm3a+x];			// lda square1_hi,x	; 4
//sm4a:
	a+=(~(square2_hi[sm4a+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_AA=a;					// sta _AA+1		; 3
						//		;===========
						//		;	27

					cycles.multiply+=27;

	/* Perform >T1_hi * <T2 = CCcc */
	c=1;					// sec			; 2
//sm1b:
	a=square1_lo[sm1b+x];			// lda square1_lo,x	; 4
//sm2b:
	a+=(~(square2_lo[sm2b+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;

	_cc=a;					// sta _cc+1		; 3
//sm3b:
	a=square1_hi[sm3b+x];			// lda square1_hi,x	; 4
//sm4b:
	a+=(~(square2_hi[sm4b+x]))+c;		// sbc square2_hi,x	; 4
	c=!!(a&0x100);
	a&=0xff;
	_CC=a;					// sta _CC+1		; 3
					cycles.multiply+=24;


	/* Perform <T1 * >T2 = BBbb */
	x=(y_i)&0xff;				// ldx T2+1		; 3
	c=1;					// sec			; 2
//sm5a:
	a=square1_lo[sm5a+x];			// lda square1_lo,x	; 4
//sm6a:
	a+=(~(square2_lo[sm6a+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_bb=a;					// sta _bb+1		; 3
//	printf("\t\t\t\tbb=%x c=%d\n",_bb,c);
//sm7a:
	a=square1_hi[sm7a+x];			// lda square1_hi,x	; 4
//sm8a:
	a+=(~(square2_hi[sm8a+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_BB=a;					// sta _BB+1		; 3
					cycles.multiply+=27;

	/* Perform >T1 * >T2 = DDdd */
	c=1;					// sec			; 2
//sm5b:
	a=square1_lo[sm5b+x];			// lda square1_lo,x	; 4
//sm6b:
	a+=(~(square2_lo[sm6b+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_dd=a;					// sta _dd+1		; 3
//sm7b:
	a=square1_hi[sm7b+x];			// lda square1_hi,x	; 4
//sm8b:
	a+=(~(square2_hi[sm8b+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;

	product[3]=a;				// sta PRODUCT+3	; 3
	_DD=a;
					cycles.multiply+=24;
	/*********************************************/
	/* Add the separate multiplications together */
	/*********************************************/

	// product[0]=_aa;
	if (debug) printf("product[0]=0.%02x\n",_aa);

	// product[1]=_AA+_bb+(_cc)
	if (debug) printf("product[1]=%02x+%02x+0=",_AA,_bb);

	c=0;					// clc			; 2
//_AA:
	a=_AA;					// lda #0		; 2
//_bb:
	a+=(c+_bb);				// adc #0		; 2
	c=!!(a&0x100);
	a&=0xff;
	product[1]=a;				// sta PRODUCT+1	; 3
	if (debug) printf("%x.%02x\n",c,a);
					cycles.multiply+=9;
	// product[2]=_BB+_CC+c
	if (debug) printf("product[2]=%02x+%02x+%d=",_BB,_CC,c);
//_BB:
	a=_BB;					// lda #0		; 2
//_CC:
	a+=(c+_CC);				// adc #0		; 2
	c=!!(a&0x100);
	a&=0xff;
	product[2]=a;				// sta PRODUCT+2	; 3
	if (debug) printf("%x.%02x\n",c,a);
					cycles.multiply+=10;
	// product[3]=_DD+c
	if (debug) printf("product[3]=%02x+%d=",_DD,c);
	if (c==0) goto urgh2;			// bcc :+		; 2nt/3
	product[3]++;				// inc PRODUCT+3	; 5
	product[3]&=0xff;
	c=0;					// clc			; 2
					cycles.multiply+=6;
urgh2:
	if (debug) printf("%x.%02x\n",c,product[3]);
	// product[1]=_AA+_bb+_cc
	if (debug) printf("product[1]=%02x+%02x+%d=",product[1],_cc,c);
//_cc:
	a=_cc;					// lda #0		; 2
	a+=c+product[1];			// adc PRODUCT+1	; 3
	c=!!(a&0x100);
	a&=0xff;
	product[1]=a;				// sta PRODUCT+1	; 3
	if (debug) printf("%x.%02x\n",c,product[1]);

	// product[2]=_BB+_CC+_dd+c
	if (debug) printf("product[2]=%02x+%02x+%d=",product[2],_dd,c);
//_dd:
	a=_dd;					// lda #0		; 2
	a+=c+product[2];			// adc PRODUCT+2	; 3
	c=!!(a&0x100);
	a&=0xff;
	product[2]=a;				// sta PRODUCT+2	; 3
	if (debug) printf("%x.%02x\n",c,product[2]);

	// product[3]=_DD+c
	if (debug) printf("product[3]=%02x+%d=",product[3],c);
					cycles.multiply+=19;
	if (c==0) goto urgh;			// bcc :+		; 2nt/3
	product[3]++;				// inc PRODUCT+3	; 5
	product[3]&=0xff;
					cycles.multiply+=4;
urgh:
	if (debug) printf("%x.%02x\n",c,product[3]);
	*z_i=product[1];
	*z_f=product[0];

//	printf("Result=%02x:%02x\n",*z_i,*z_f);

	if (debug) {
		printf("    AAaa        %02x:%02x\n",_AA,_aa);
		printf("  BBbb       %02x:%02x\n",_BB,_bb);
		printf("  CCcc       %02x:%02x\n",_CC,_cc);
		printf("DDdd      %02x:%02x\n",_DD,_dd);
	}

					cycles.multiply+=6;

	return (product[3]<<24)|(product[2]<<16)|(product[1]<<8)|product[0];
						// rts			; 6
}

/* signed */
static void fixed_mul(unsigned char x_i, unsigned char x_f,
		unsigned char y_i, unsigned char y_f,
		unsigned char *z_i, unsigned char *z_f, int reuse) {

	int a,c;

	fixed_mul_unsigned(x_i,x_f,y_i,y_f,z_i,z_f,0,reuse);
					// jsr multiply_16bit_unsigned	; 6

	a=(x_i&0xff);			// lda T1+1			; 3
					cycles.multiply+=12;
	if ((a&0x80)==0) goto x_positive;	// bpl :+		; 3/2nt
					cycles.multiply--;
	c=1;				// sec				; 2
	a=product[2];			// lda PRODUCT+2		; 3
	a+=(~y_f)+c;			// sbc T2+0			; 3
	c=!(a&0x100);
	a&=0xff;
	product[2]=a;			// sta PRODUCT+2		; 3
	a=product[3];			// lda PRODUCT+3		; 3
	a+=(~y_i)+c;			// sbc T2+1			; 3
	c=!(a&0x100);
	a&=0xff;
	product[3]=a;			// sta PRODUCT+3		; 3
					cycles.multiply+=20;

x_positive:

	a=(y_i&0xff);			// lda T2+1			; 3
					cycles.multiply+=6;
	if ((a&0x80)==0) goto y_positive;	// bpl :+		; 3/2nt
					cycles.multiply--;

	c=1;				// sec				; 2
	a=product[2];			// lda PRODUCT+2		; 3
	a+=(~x_f)+c;			// sbc T1+0			; 3
	c=!(a&0x100);
	a&=0xff;
	product[2]=a;			// sta PRODUCT+2		; 3
	a=product[3];			// lda PRODUCT+3		; 3
	a+=(~x_i)+c;			// sbc T1+1			; 3
	c=!(a&0x100);
	a&=0xff;
	product[3]=a;			// sta PRODUCT+3		; 3
					cycles.multiply+=20;
y_positive:
	*z_i=product[2];
	*z_f=product[1];

//	return (product[3]<<24)|(product[2]<<16)|(product[1]<<8)|product[0];
						// rts			; 6
					cycles.multiply+=12;
}


static void draw_background_mode7(void) {


	int map_color;

						cycles.mode7+=6;
	if (ram[DRAW_SKY]) {

		ram[DRAW_SKY]--;

		/* Draw Sky */
		/* Originally wanted to be fancy and have sun too, but no */

		color_equals(COLOR_MEDIUMBLUE);
						cycles.mode7+=11;

		for(ram[SCREEN_Y]=0;ram[SCREEN_Y]<6;ram[SCREEN_Y]+=2) {
			hlin_double(ram[DRAW_PAGE], 0, 40, ram[SCREEN_Y]);
		}
						cycles.mode7+=(63+(16*40)+23)*5;
		/* Draw hazy horizon */
		color_equals(COLOR_GREY);
		hlin_double(ram[DRAW_PAGE], 0, 40, 6);
						cycles.mode7+=14+63+(16*40);
	}


						cycles.mode7+=30;

	/* FIXME: only do this if SPACEZ changes? */
// mul1
	fixed_mul(ram[SPACEZ_I],ram[SPACEZ_F],
		CONST_BETA_I,CONST_BETA_F,
		&ram[FACTOR_I],&ram[FACTOR_F],0);

	if (!displayed) {
		printf("SPACEZ/BETA/FACTOR %x %x * %x %x = %x %x\n",
			ram[SPACEZ_I],ram[SPACEZ_F],
			CONST_BETA_I, CONST_BETA_F,
			ram[FACTOR_I],ram[FACTOR_F]);
	}

							cycles.mode7+=11;

	ram[SCREEN_Y]=8;

	do {

		y=0;
		hlin_setup(ram[DRAW_PAGE],y,0,ram[SCREEN_Y]);
							cycles.mode7+=39;

		// then calculate the horizontal scale, or the distance between
		// space points on this horizontal line
		ram[HORIZ_SCALE_I]=0;

		ram[HORIZ_SCALE_F]=
			//horizontal_lookup[ram[SPACEZ_I]&0xf]
			//			[(ram[SCREEN_Y]-8)];
			horizontal_lookup[((ram[SPACEZ_I]&0xf)<<5)+
						(ram[SCREEN_Y]-8)];

							cycles.mode7+=37;

		if (!displayed) {
			printf("HORIZ_SCALE %x %x\n",
			ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F]);
		}

//mul2		// calculate the distance of the line we are drawing
		fixed_mul(ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F],
			CONST_SCALE_I,CONST_SCALE_F,
			&ram[DISTANCE_I],&ram[DISTANCE_F],0);
							cycles.mode7+=34;
		if (!displayed) {
			printf("DISTANCE %x:%x\n",ram[DISTANCE_I],ram[DISTANCE_F]);
		}

		// calculate the dx and dy of points in space when we step
		// through all points on this line
		ram[DX_I]=fixed_sin[(ram[ANGLE]+8)&0xf].i;	// -sin()
		ram[DX_F]=fixed_sin[(ram[ANGLE]+8)&0xf].f;	// -sin()
							cycles.mode7+=29;

// mul3
		fixed_mul(ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F],
			ram[DX_I],ram[DX_F],
			&ram[DX_I],&ram[DX_F],1);
							cycles.mode7+=14;
		if (!displayed) {
			printf("DX %x:%x\n",ram[DX_I],ram[DX_F]);
		}


		ram[DY_I]=fixed_sin[(ram[ANGLE]+4)&0xf].i;	// cos()
		ram[DY_F]=fixed_sin[(ram[ANGLE]+4)&0xf].f;	// cos()
							cycles.mode7+=29;
// mul4
		fixed_mul(ram[HORIZ_SCALE_I],ram[HORIZ_SCALE_F],
			ram[DY_I],ram[DY_F],
			&ram[DY_I],&ram[DY_F],1);
							cycles.mode7+=14;
		if (!displayed) {
			printf("DY %x:%x\n",ram[DY_I],ram[DY_F]);
		}

		// calculate the starting position
		fixed_add(ram[DISTANCE_I],ram[DISTANCE_F],
			ram[FACTOR_I],ram[FACTOR_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);
		fixed_add(ram[DISTANCE_I],ram[DISTANCE_F],
			ram[FACTOR_I],ram[FACTOR_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);
							cycles.mode7+=26;

		ram[TEMP_I]=fixed_sin[(ram[ANGLE]+4)&0xf].i; // cos
		ram[TEMP_F]=fixed_sin[(ram[ANGLE]+4)&0xf].f; // cos
							cycles.mode7+=29;
// mul5
		fixed_mul(ram[SPACEX_I],ram[SPACEX_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEX_I],&ram[SPACEX_F],0);
							cycles.mode7+=26;

		fixed_add(ram[SPACEX_I],ram[SPACEX_F],
			ram[CX_I],ram[CX_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);


		ram[TEMP_I]=fixed_sin[ram[ANGLE]&0xf].i;
		ram[TEMP_F]=fixed_sin[ram[ANGLE]&0xf].f;
							cycles.mode7+=25;
// mul6
		fixed_mul(ram[SPACEY_I],ram[SPACEY_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEY_I],&ram[SPACEY_F],0);
							cycles.mode7+=26;

		fixed_add(ram[SPACEY_I],ram[SPACEY_F],
			ram[CY_I],ram[CY_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);


// mul7
		fixed_mul(CONST_LOWRES_HALF_I,CONST_LOWRES_HALF_F,
			ram[DX_I],ram[DX_F],
			&ram[TEMP_I],&ram[TEMP_F],0);
							cycles.mode7+=32;

		fixed_add(ram[SPACEX_I],ram[SPACEX_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEX_I],&ram[SPACEX_F]);
							cycles.mode7+=20;
		if (!displayed) {
			printf("SPACEX! %x:%x\n",
			ram[SPACEX_I],ram[SPACEX_F]);
		}

// mul8
		fixed_mul(CONST_LOWRES_HALF_I,CONST_LOWRES_HALF_F,
			ram[DY_I],ram[DY_F],
			&ram[TEMP_I],&ram[TEMP_F],1);
							cycles.mode7+=20;
		fixed_add(ram[SPACEY_I],ram[SPACEY_F],
			ram[TEMP_I],ram[TEMP_F],
			&ram[SPACEY_I],&ram[SPACEY_F]);
							cycles.mode7+=25;
		if (!displayed) {
			printf("SPACEY! %x:%x\n",ram[SPACEY_I],ram[SPACEY_F]);
		}

		// go through all points in this screen line
		for (ram[SCREEN_X] = 0;
			ram[SCREEN_X] < LOWRES_W;
			ram[SCREEN_X]++) {

			// get a pixel from the tile and put it on the screen

			/* cache last value */
						cycles.mode7+=9;
			if (ram[SPACEY_I]==last_yy) {
						cycles.mode7+=8;
				if (ram[SPACEX_I]==last_xx) {
						cycles.mode7+=6;
					map_color=last_color;
					goto match;
				}
			}

			map_color=lookup_map(ram[SPACEX_I],ram[SPACEY_I]);
						cycles.mode7+=6;
match:

			ram[COLOR]=(map_color&0xf);
//			ram[COLOR]|=map_color<<4;

			y=0;
			if ((ram[SCREEN_Y]&1)==0) {
				ram[y_indirect(GBASL,y)]=ram[COLOR];
			}
			else {
				a=ram[COLOR];
				ram[y_indirect(GBASL,y)]|=(a<<4);

			}

			ram[GBASL]++;
							cycles.mode7+=25;

			// advance to the next position in space
			fixed_add(ram[SPACEX_I],ram[SPACEX_F],
				ram[DX_I],ram[DX_F],
				&ram[SPACEX_I],&ram[SPACEX_F]);
			fixed_add(ram[SPACEY_I],ram[SPACEY_F],
				ram[DY_I],ram[DY_F],
				&ram[SPACEY_I],&ram[SPACEY_F]);
							cycles.mode7+=53;
		}

		ram[SCREEN_Y]+=1;
							cycles.mode7+=15;
	} while(ram[SCREEN_Y] < LOWRES_H);

	displayed=1;
							cycles.mode7+=6;
}





static int iterations=0;

int flying(void) {

	unsigned char ch;

	/************************************************/
	/* Flying					*/
	/************************************************/

	/* Benchmark the multiply */
	memset(&cycles,0,sizeof(cycles));
	fixed_mul(0x1,0x0,
		0x2,0x0,
		&ram[TEMP_I],&ram[TEMP_F],0);
	printf("Multiplying 1.0 * 2.0 = %d.%d, took %d cycles\n",
		ram[TEMP_I],ram[TEMP_F],cycles.multiply);

	memset(&cycles,0,sizeof(cycles));
	fixed_mul(0xff,0xff,
		0xff,0xff,
		&ram[TEMP_I],&ram[TEMP_F],0);
	printf("Multiplying ff.ff * ff.ff = %d.%d, took %d cycles\n",
		ram[TEMP_I],ram[TEMP_F],cycles.multiply);

	gr();
	clear_bottom(PAGE0);
	clear_bottom(PAGE1);

	ram[SHIPY]=20;
	ram[TURNING]=0;
	ram[SPACEX_I]=0;
	ram[SPACEY_I]=0;
	ram[CX_I]=0;
	ram[CX_F]=0;
	ram[CY_I]=0;
	ram[CY_F]=0;
	ram[DRAW_SPLASH]=0;
	ram[SPEED]=0;
	ram[SPLASH_COUNT]=0;

	ram[ANGLE]=1;		/* 1 so you can see island */

	ram[DRAW_SKY]=2;

	ram[SPACEZ_I]=4;
	ram[SPACEZ_F]=0x80;	/* Z=4.5 */

	while(1) {
		memset(&cycles,0,sizeof(cycles));
						cycles.flying+=6;
		if (ram[SPLASH_COUNT]>0) {
						cycles.flying--;
			ram[SPLASH_COUNT]--;
						cycles.flying+=5;
		}

		ch=grsim_input();
						cycles.getkey=46;

						cycles.flying+=3;

		if ((ch=='q') || (ch==27))  break;
						cycles.flying+=5;
		if ((ch=='w') || (ch==APPLE_UP)) {
			if (ram[SHIPY]>16) {
				ram[SHIPY]-=2;
				ram[SPACEZ_I]++;
			}
			ram[SPLASH_COUNT]=0;
		}
						cycles.flying+=5;
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			if (ram[SHIPY]<28) {
				ram[SHIPY]+=2;
				ram[SPACEZ_I]--;
			}
			else {
				ram[SPLASH_COUNT]=10;
			}
		}
						cycles.flying+=5;
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
						cycles.flying+=5;
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
						cycles.flying+=5;
		/* Used to be able to go backwards */
		if (ch=='z') {
			if (ram[SPEED]<3) ram[SPEED]++;
		}
						cycles.flying+=5;
		if (ch=='x') {
			if (ram[SPEED]>0) ram[SPEED]--;
		}
						cycles.flying+=5;
		if (ch==' ') {
			ram[SPEED]=SPEED_STOPPED;
		}
						cycles.flying+=5;
		if (ch=='h') {
			print_help();
		}
						cycles.flying+=5;
		/* Ending */
		if (ch==13) {
			int landing_color,tx,ty;
			tx=ram[CX_I];	ty=ram[CY_I];

			landing_color=lookup_map(tx,ty);
			printf("Trying to land at %d %d\n",tx,ty);
			printf("Color=%d\n",landing_color);
			if (landing_color==12) {
				int loop;

				/* Land the ship */
				for(loop=ram[SPACEZ_I];loop>0;loop--) {
					draw_background_mode7();
					cycles.put_sprite+=grsim_put_sprite(shadow_forward,CONST_SHIPX+3,31+ram[SPACEZ_I]);
					cycles.put_sprite+=grsim_put_sprite(ship_forward,CONST_SHIPX,ram[SHIPY]);
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
						cycles.flying+=5;

// check_done:
						cycles.flying+=14;
		if (ram[SPEED]!=SPEED_STOPPED) {
						cycles.flying--;

			int ii;

			ram[DX_I] = fixed_sin_scale[(ram[ANGLE]+4)&0xf].i;        // cos
			ram[DX_F] = fixed_sin_scale[(ram[ANGLE]+4)&0xf].f;        // cos
			ram[DY_I] = fixed_sin_scale[ram[ANGLE]&0xf].i;
			ram[DY_F] = fixed_sin_scale[ram[ANGLE]&0xf].f;
						cycles.flying+=54;
			for(ii=0;ii<ram[SPEED];ii++) {
				fixed_add(ram[CX_I],ram[CX_F],
					ram[DX_I],ram[DX_F],
					&ram[CX_I],&ram[CX_F]);
				fixed_add(ram[CY_I],ram[CY_F],
					ram[DY_I],ram[DY_F],
					&ram[CY_I],&ram[CY_F]);
						cycles.flying+=45;
			}
						cycles.flying--;

		}

		draw_background_mode7();

		{	int landing_color,tx,ty;
			tx=ram[CX_I];	ty=ram[CY_I];

			landing_color=lookup_map(tx,ty);
			if (landing_color==2) ram[OVER_LAND]=0;
			else ram[OVER_LAND]=1;
		}
						cycles.flying+=31;

		ram[DRAW_SPLASH]=0;
						cycles.flying+=11;
		if (ram[SPEED]>0) {

			if ((ram[SHIPY]>25) && (ram[TURNING]!=0)) {
				ram[SPLASH_COUNT]=1;
			}

			if ((!ram[OVER_LAND]) && (ram[SPLASH_COUNT])) {
				ram[DRAW_SPLASH]=1;
			}
		}

		if (ram[TURNING]==0) {
			if (ram[DRAW_SPLASH]) {
				cycles.put_sprite+=grsim_put_sprite(splash_forward,
					CONST_SHIPX+1,ram[SHIPY]+9);
						cycles.flying+=33;
			}
			cycles.put_sprite+=grsim_put_sprite(shadow_forward,CONST_SHIPX+3,31+ram[SPACEZ_I]);
			cycles.put_sprite+=grsim_put_sprite(ship_forward,CONST_SHIPX,ram[SHIPY]);
						cycles.flying+=46;
		}
		else if (ram[TURNING]>128) {

			if (ram[DRAW_SPLASH]) {
				cycles.put_sprite+=grsim_put_sprite(splash_left,
						CONST_SHIPX+1,36);
						cycles.flying+=28;
			}
			cycles.put_sprite+=grsim_put_sprite(shadow_left,CONST_SHIPX+3,31+ram[SPACEZ_I]);
			cycles.put_sprite+=grsim_put_sprite(ship_left,CONST_SHIPX,ram[SHIPY]);
			ram[TURNING]++;
						cycles.flying+=48;
		}
		else {

			if (ram[DRAW_SPLASH]) {
				cycles.put_sprite+=grsim_put_sprite(splash_right,
						CONST_SHIPX+1,36);
						cycles.flying+=28;
			}
			cycles.put_sprite+=grsim_put_sprite(shadow_right,CONST_SHIPX+3,31+ram[SPACEZ_I]);
			cycles.put_sprite+=grsim_put_sprite(ship_right,CONST_SHIPX,ram[SHIPY]);
			ram[TURNING]--;
						cycles.flying+=51;
		}

						cycles.flying+=17;
		page_flip();			cycles.page_flip+=26;
						cycles.flying+=9;

		iterations++;
		if (iterations==100) {
			int total_cycles;
			total_cycles=cycles.flying+cycles.getkey+
				cycles.page_flip+cycles.multiply+
				cycles.mode7+cycles.lookup_map+
				cycles.put_sprite;
			printf("Cycles: flying=%d\n",cycles.flying);
			printf("Cycles: getkey=%d\n",cycles.getkey);
			printf("Cycles: page_flip=%d\n",cycles.page_flip);
			printf("Cycles: multiply=%d\n",cycles.multiply);
			printf("Cycles: mode7=%d\n",cycles.mode7);
			printf("Cycles: lookup_map=%d\n",cycles.lookup_map);
			printf("Cycles: put_sprite=%d\n",cycles.put_sprite);
			printf("Total = %d\n",total_cycles);
			printf("Frame Rate = %.2lf fps\n",
				(1000000.0 / (double)total_cycles));
			iterations=0;
		}

		usleep(20000);

	}
	return 0;
}

