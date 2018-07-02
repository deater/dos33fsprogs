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


int hplot(int xx, int yy) {

	return 0;
}

int hplot_to(int xx, int yy) {

	return 0;
}

int hcolor_equals(int color) {

	return 0;
}





