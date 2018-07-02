#include <stdio.h>

#include "gr-sim.h"
#include "tfv_zp.h"
#include "6502_emulate.h"

static void color_shift(void) {
	// F47E
	a=a<<1;
	if (a>=0xc0) goto done_color_shift;

	a=ram[HGR_BITS];
	a=a^0x7f;
	ram[HGR_BITS]=a;

done_color_shift:
	;	// rts
}

static void bkgnd(void) {
	// F3F6
	a=ram[HGR_PAGE];
	ram[HGR_SHAPE+1]=a;
	y=0;
	ram[HGR_SHAPE]=y;
bkgnd_loop:
	a=ram[HGR_BITS];

	ram[y_indirect(HGR_SHAPE,y)]=a;

	color_shift();

	y++;
	if (y==0) {
	}
	else {
		goto bkgnd_loop;
	}
	ram[HGR_SHAPE+1]+=1;
	a=ram[HGR_SHAPE+1];
	a&=0x1f;			// see if $40 or $60
	if (a!=0) {
		goto bkgnd_loop;
	}
	// rts
}

static void hclr(void) {
	// F3F2
	a=0;			// black background
	ram[HGR_BITS]=a;
	bkgnd();

}

static void sethpg(void) {
	// F3EA
	ram[HGR_PAGE]=a;
	soft_switch(HIRES);	// LDA SW.HIRES
	soft_switch(TXTCLR);	// LDA SW.TXTCLR

	hclr();

}

int hgr(void) {

	// F3E2
	a=0x20;			// HIRES Page 1 at $2000
	soft_switch(LOWSCR);	// BIT SW.LOWSCR Use PAGE1 ($C054)
        soft_switch(MIXSET);    // BIT SW.MIXSET (Mixed text)
	sethpg();

        return 0;
}

int hgr2(void) {

	// F3D8
	soft_switch(HISCR);	// BIT SW.HISCR Use PAGE2 ($C055)
	soft_switch(MIXCLR);	// BIT SW.MIXCLR
	a=0x40;			// HIRES Page 2 at $4000
	sethpg();

        return 0;
}

static void hposn(void) {

	unsigned char s;
	unsigned char msktbl[]={0x81,0x82,0x84,0x88,0x90,0xA0,0xC0};

	// F411
	ram[HGR_Y]=a;
	ram[HGR_X]=x;
	ram[HGR_X+1]=y;
	s=a;			// pha
	a=a&0xC0;
	ram[GBASL]=a;
	lsr();
	lsr();
	a=a|ram[GBASL];
	ram[GBASL]=a;
	a=s;
	// F423
	ram[GBASH]=a;
	asl();
	asl();
	asl();
	rol_mem(GBASH);
	asl();
	rol_mem(GBASH);
	asl();
	ror_mem(GBASL);
	a=ram[GBASH];
	a=a&0x1f;
	a=a|ram[HGR_PAGE];
	ram[GBASH]=a;

	// F438
	a=x;
	if (y==0) {
		goto hposn_2;
	}
	y=35;
	adc(4);
hposn_1:
	y++;
	// f442
hposn_2:
	sbc(7);
	if (c==1) goto hposn_1;
	ram[HGR_HORIZ]=y;
	x=a;
	a=msktbl[(x-0x100)+7];		// LDA MSKTBL-$100+7,X  BIT MASK
					// MSKTBL=F5B8
	ram[HMASK]=a;
	a=y;
	c=a&1;
	a=a>>1;
	a=ram[HGR_COLOR];
	ram[HGR_BITS]=a;
	if (c) color_shift();
}

static void hplot0(void) {
	// F457
	hposn();
	a=ram[HGR_BITS];
	a=a^ram[y_indirect(GBASL,y)];
	a=a&ram[HMASK];
	a=a^ram[y_indirect(GBASL,y)];
	ram[y_indirect(GBASL,y)]=a;
}

static void hfns(int xx, int yy) {
	// (y,x) = x co-ord
	// (a) = y co-ord

	if (xx>=280) {
		printf("X-coord out of range!\n");
		return;
	}
	if (yy>192) {
		printf("Y-coord out of range!\n");
		return;
	}

	x=(xx&0xff);
	y=(xx>>8);
	a=yy;

}

int hplot(int xx, int yy) {

	// F6FE
	hfns(xx,yy);
	hplot0();


	return 0;
}

int hplot_to(int xx, int yy) {

	return 0;
}

int hcolor_equals(int color) {

	unsigned char colortbl[8]={0x00,0x2A,0x55,0x7F,0x80,0xAA,0xD5,0xFF};

	// F6E9
	x=color;
	if (x>7) {
		printf("HCOLOR out of range!\n");
		return -1;
	}

	a=colortbl[x];
	ram[HGR_COLOR]=a;

	return 0;
}

