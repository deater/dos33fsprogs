#include <stdio.h>

#include "gr-sim.h"
#include "tfv_zp.h"
#include "6502_emulate.h"

static void color_shift(void) {

	// F47E
	asl();
	cmp(0xc0);

	if (!n) goto done_color_shift;

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
		c=0;
		goto hposn_2;
	} else {
		c=1;
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
	lsr();
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

static void move_left_or_right(void) {
	// F465
	if (n==0) goto move_right;

	a=ram[HMASK];
	lsr();
	if (c==1) goto lr_2;
	a=a^0xc0;
lr_1:
	ram[HMASK]=a;
	return;
lr_2:
	dey();
	if (n==0) goto lr_3;
	y=39;
lr_3:
	a=0xc0;
lr_4:
	ram[HMASK]=a;
	ram[HGR_HORIZ]=y;
	a=ram[HGR_BITS];
	color_shift();
	return;

move_right:
	a=ram[HMASK];
	asl();
	a=a^0x80;
	if (a&0x80) goto lr_1;
	a=0x81;
	iny();
	cpy(40);
	if (c==0) goto lr_4;
	y=0;
	goto lr_4;

}

static void move_up_or_down(void) {
	// F4D3
	if (n==1) goto move_down;

	c=0;
	lda(GBASH);
	bit(0x1c);		// CON.1C
	if (z!=1) goto mu_5;
	asl_mem(GBASL);
	if (c==1) goto mu_3;
	bit(0x03);		// CON.03
	if (z==1) goto mu_1;
	adc(0x1f);
	c=1;
	goto mu_4;
	// F4Eb
mu_1:
	adc(0x23);
	pha();
	lda(GBASL);
	adc(0xb0);
	if (c==1) goto mu_2;
	adc(0xf0);
	// f4f6
mu_2:
	ram[GBASL]=a;
	pla();
	goto mu_4;
mu_3:
	adc(0x1f);
mu_4:
	ror_mem(GBASL);
mu_5:
	adc(0xfc);
ud_1:
	ram[GBASH]=a;
	return;

	// f505
move_down:
	lda(GBASH);
	adc(4);
	bit(0x1c);
	if (z!=1) goto ud_1;
	asl_mem(GBASL);
	if (c==0) goto md_2;
	adc(0xe0);
	c=0;
	bit(0x4);
	if (z==1) goto md_3;
	lda(GBASL);
	adc(0x50);
	a=a^0xf0;
	if (a==0) goto md_1;
	a=a^0xf0;
md_1:
	ram[GBASL]=a;
	lda(HGR_PAGE);
	goto md_3;
md_2:
	adc(0xe0);
md_3:
	ror_mem(GBASL);
	goto ud_1;

}

static void hglin(void) {

	// F53A
	pha();
	c=1;
	sbc(ram[HGR_X]);
	pha();
	a=x;
	sbc(ram[HGR_X+1]);
	ram[HGR_QUADRANT]=a;
	// F544
	if (c==1) goto hglin_1;
	pla();
	a=a^0xff;
	adc(1);
	pha();
	lda_const(0);
	sbc(ram[HGR_QUADRANT]);
	// F550
hglin_1:
	ram[HGR_DX+1]=a;
	ram[HGR_E+1]=a;
	pla();
	ram[HGR_DX]=a;
	ram[HGR_E]=a;
	pla();
	ram[HGR_X]=a;
	ram[HGR_X+1]=x;
	a=y;
	c=0;
	sbc(ram[HGR_Y]);
	if (c==0) goto hglin_2;
	a=a^0xff;
	adc(0xfe);
hglin_2:
	// F568
	ram[HGR_DY]=a;
	ram[HGR_Y]=y;
	ror_mem(HGR_QUADRANT);
	c=1;
	sbc(ram[HGR_DX]);
	x=a;
	lda_const(0xff);
	sbc(ram[HGR_DX+1]);
	ram[HGR_COUNT]=a;
	ldy(HGR_HORIZ);
	goto movex2;	// always?
	// f57c
movex:
	asl();
	move_left_or_right();
	c=1;

	// f581
movex2:
	lda(HGR_E);
	adc(ram[HGR_DY]);
	ram[HGR_E]=a;
	lda(HGR_E+1);
	sbc(0);
movex2_1:
	ram[HGR_E+1]=a;
	lda(y_indirect(GBASL,y));
	a=a^ram[HGR_BITS];
	a=a&ram[HMASK];
	a=a^ram[y_indirect(GBASL,y)];
	ram[y_indirect(GBASL,y)]=a;
	inx();
	if (z!=1) goto movex2_2;
	ram[HGR_COUNT]++;
	if (ram[HGR_COUNT]==0) return;
	// F59e
movex2_2:
	lda(HGR_QUADRANT);
	if (c==1) goto movex;
	move_up_or_down();
	c=0;
	lda(HGR_E);
	adc(ram[HGR_DX]);
	ram[HGR_E]=a;
	lda(HGR_E+1);
	adc(ram[HGR_DX+1]);
	goto movex2_1;
}

int hplot_to(int xx, int yy) {

	// F712
	hfns(xx,yy);
	ram[DSCTMP]=y;
	y=a;
	a=x;
	x=ram[DSCTMP];
	hglin();

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

