#include <stdio.h>

#include "gr-sim.h"
#include "tfv_zp.h"
#include "6502_emulate.h"

static void color_shift(void) {

	// F47E
	asl();
	cmp(0xc0);

	if (!N) goto done_color_shift;

	A=ram[HGR_BITS];
	A=A^0x7f;
	ram[HGR_BITS]=A;

done_color_shift:
	;	// rts
}

void bkgnd(void) {
	// F3F6
	A=ram[HGR_PAGE];
	ram[HGR_SHAPE+1]=A;
	Y=0;
	ram[HGR_SHAPE]=Y;
bkgnd_loop:
	A=ram[HGR_BITS];

	ram[y_indirect(HGR_SHAPE,Y)]=A;

	color_shift();

	Y++;
	if (Y==0) {
	}
	else {
		goto bkgnd_loop;
	}
	ram[HGR_SHAPE+1]+=1;
	A=ram[HGR_SHAPE+1];
	A&=0x1f;			// see if $40 or $60
	if (A!=0) {
		goto bkgnd_loop;
	}
	// rts
}

void hclr(void) {
	// F3F2
	A=0;			// black background
	ram[HGR_BITS]=A;
	bkgnd();

}

static void sethpg(void) {
	// F3EA
	ram[HGR_PAGE]=A;
	soft_switch(HIRES);	// LDA SW.HIRES
	soft_switch(TXTCLR);	// LDA SW.TXTCLR

	hclr();

}

int hgr(void) {

	// F3E2
	A=0x20;			// HIRES Page 1 at $2000
	soft_switch(LOWSCR);	// BIT SW.LOWSCR Use PAGE1 ($C054)
        soft_switch(MIXSET);    // BIT SW.MIXSET (Mixed text)
	sethpg();

        return 0;
}

int hgr2(void) {

	// F3D8
	soft_switch(HISCR);	// BIT SW.HISCR Use PAGE2 ($C055)
	soft_switch(MIXCLR);	// BIT SW.MIXCLR
	A=0x40;			// HIRES Page 2 at $4000
	sethpg();

        return 0;
}

void hposn(void) {

	unsigned char msktbl[]={0x81,0x82,0x84,0x88,0x90,0xA0,0xC0};

	// F411
	ram[HGR_Y]=A;
	ram[HGR_X]=X;
	ram[HGR_X+1]=Y;
	pha();
	A=A&0xC0;
	ram[GBASL]=A;
	lsr();
	lsr();
	A=A|ram[GBASL];
	ram[GBASL]=A;
	pla();
	// F423
	ram[GBASH]=A;
	asl();
	asl();
	asl();
	rol_mem(GBASH);
	asl();
	rol_mem(GBASH);
	asl();
	ror_mem(GBASL);
	lda(GBASH);
	A=A&0x1f;
	A=A|ram[HGR_PAGE];
	ram[GBASH]=A;

	// F438
	A=X;
	cpy(0);
	if (Z==1) goto hposn_2;

	Y=35;
	adc(4);
hposn_1:
	iny();
	// f442
hposn_2:
	sbc(7);
	if (C==1) goto hposn_1;
	ram[HGR_HORIZ]=Y;
	X=A;
	A=msktbl[(X-0x100)+7];		// LDA MSKTBL-$100+7,X  BIT MASK
					// MSKTBL=F5B8
	ram[HMASK]=A;
	A=Y;
	lsr();
	A=ram[HGR_COLOR];
	ram[HGR_BITS]=A;
	if (C) color_shift();
}

static void hplot0(void) {
	// F457
	hposn();
	A=ram[HGR_BITS];
	A=A^ram[y_indirect(GBASL,Y)];
	A=A&ram[HMASK];
	A=A^ram[y_indirect(GBASL,Y)];
	ram[y_indirect(GBASL,Y)]=A;
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

	X=(xx&0xff);
	Y=(xx>>8);
	A=yy;

}

int hplot(int xx, int yy) {

	// F6FE
	hfns(xx,yy);
	hplot0();


	return 0;
}

static void move_left_or_right(void) {
	// F465
	if (N==0) goto move_right;

	A=ram[HMASK];
	lsr();
	if (C==1) goto lr_2;
	A=A^0xc0;
lr_1:
	ram[HMASK]=A;
	return;
lr_2:
	dey();
	if (N==0) goto lr_3;
	Y=39;
lr_3:
	A=0xc0;
lr_4:
	ram[HMASK]=A;
	ram[HGR_HORIZ]=Y;
	A=ram[HGR_BITS];
	color_shift();
	return;

move_right:
	A=ram[HMASK];
	asl();
	A=A^0x80;
	if (A&0x80) goto lr_1;
	A=0x81;
	iny();
	cpy(40);
	if (C==0) goto lr_4;
	Y=0;
	goto lr_4;

}

static void move_up_or_down(void) {
	// F4D3
	if (N==1) goto move_down;

	C=0;
	lda(GBASH);
	bit(0x1c);		// CON.1C
	if (Z!=1) goto mu_5;
	asl_mem(GBASL);
	if (C==1) goto mu_3;
	bit(0x03);		// CON.03
	if (Z==1) goto mu_1;
	adc(0x1f);
	C=1;
	goto mu_4;
	// F4Eb
mu_1:
	adc(0x23);
	pha();
	lda(GBASL);
	adc(0xb0);
	if (C==1) goto mu_2;
	adc(0xf0);
	// f4f6
mu_2:
	ram[GBASL]=A;
	pla();
	goto mu_4;
mu_3:
	adc(0x1f);
mu_4:
	ror_mem(GBASL);
mu_5:
	adc(0xfc);
ud_1:
	ram[GBASH]=A;
	return;

	// f505
move_down:
	lda(GBASH);
	adc(4);
	bit(0x1c);
	if (Z!=1) goto ud_1;
	asl_mem(GBASL);
	if (C==0) goto md_2;
	adc(0xe0);
	C=0;
	bit(0x4);
	if (Z==1) goto md_3;
	lda(GBASL);
	adc(0x50);
	A=A^0xf0;
	if (A==0) goto md_1;
	A=A^0xf0;
md_1:
	ram[GBASL]=A;
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
	C=1;
	sbc(ram[HGR_X]);
	pha();
	A=X;
	sbc(ram[HGR_X+1]);
	ram[HGR_QUADRANT]=A;
	// F544
	if (C==1) goto hglin_1;
	pla();
	A=A^0xff;
	adc(1);
	pha();
	lda_const(0);
	sbc(ram[HGR_QUADRANT]);
	// F550
hglin_1:
	ram[HGR_DX+1]=A;
	ram[HGR_E+1]=A;
	pla();
	ram[HGR_DX]=A;
	ram[HGR_E]=A;
	pla();
	ram[HGR_X]=A;
	ram[HGR_X+1]=X;
	A=Y;
	C=0;
	sbc(ram[HGR_Y]);
	if (C==0) goto hglin_2;
	A=A^0xff;
	adc(0xfe);
hglin_2:
	// F568
	ram[HGR_DY]=A;
	ram[HGR_Y]=Y;
	ror_mem(HGR_QUADRANT);
	C=1;
	sbc(ram[HGR_DX]);
	X=A;
	lda_const(0xff);
	sbc(ram[HGR_DX+1]);
	ram[HGR_COUNT]=A;
	ldy(HGR_HORIZ);
	goto movex2;	// always?
	// f57c
movex:
	asl();
	move_left_or_right();
	C=1;

	// f581
movex2:
	lda(HGR_E);
	adc(ram[HGR_DY]);
	ram[HGR_E]=A;
	lda(HGR_E+1);
	sbc(0);
movex2_1:
	ram[HGR_E+1]=A;
	lda(y_indirect(GBASL,Y));
	A=A^ram[HGR_BITS];
	A=A&ram[HMASK];
	A=A^ram[y_indirect(GBASL,Y)];
	ram[y_indirect(GBASL,Y)]=A;
	inx();
	if (Z!=1) goto movex2_2;
	ram[HGR_COUNT]++;
	if (ram[HGR_COUNT]==0) return;
	// F59e
movex2_2:
	lda(HGR_QUADRANT);
	if (C==1) goto movex;
	move_up_or_down();
	C=0;
	lda(HGR_E);
	adc(ram[HGR_DX]);
	ram[HGR_E]=A;
	lda(HGR_E+1);
	adc(ram[HGR_DX+1]);
	goto movex2_1;
}

int hplot_to(int xx, int yy) {

	// F712
	hfns(xx,yy);
	ram[DSCTMP]=Y;
	Y=A;
	A=X;
	X=ram[DSCTMP];
	hglin();

	return 0;
}

int hcolor_equals(int color) {

	unsigned char colortbl[8]={0x00,0x2A,0x55,0x7F,0x80,0xAA,0xD5,0xFF};

	// F6E9
	X=color;
	if (X>7) {
		printf("HCOLOR out of range!\n");
		return -1;
	}

	A=colortbl[X];
	ram[HGR_COLOR]=A;

	return 0;
}
