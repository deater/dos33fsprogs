#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "6502_emulate.h"
#include "gr-sim.h"

#define HGR_HORIZ	0xff
#define TEMP_R	0xfe

static void fancy_div(int d, int *q, int *r) {

	//;Divide by 7 (From December '84 Apple Assembly Line)
	//;15 bytes, 27 cycles

	// y=xhigh x=xlow a=??
	// q in y, r in a

	y=(d>>8)&0xff;
	x=d&0xff;

	a=x;

	sta(TEMP_R);

	c=0;
	sta(HGR_HORIZ);		// 0
	lsr();			// 0
	lsr();			// 0
	lsr();			// 0
	adc_mem(HGR_HORIZ);	// 0
	ror();			// 0
	lsr();			// 0
	lsr();			// 0
	adc_mem(HGR_HORIZ);	// 0
	ror();			// 0
	lsr();			// 0
	lsr();			// 0

	// calc remainder

	c=0;
	sta(HGR_HORIZ);
	asl();
	adc_mem(HGR_HORIZ);
	asl();
	adc_mem(HGR_HORIZ);
	// HGR_HORIZ=x/7, A=HGR_HORIZ*7


	c=1;
	eor(0xff);
//	printf("%d+%d=",d&0xff,a);
	adc(d&0xff);
//	printf("%d\n",a);


//	sta(TEMP_R);
//	txa();
//	sbc_mem(TEMP_R);
//	tax();

	if (y) {
		c=0;
		adc(4);
		pha();
		lda(HGR_HORIZ);
		adc(36);
		sta(HGR_HORIZ);
		pla();
	}

	if (a>6) {
		c=1;
		sbc(7);
		ram[HGR_HORIZ]++;
	}

	y=ram[HGR_HORIZ];

	*q=y;
	*r=a;
}


int main(int argc, char **argv) {

	int i,actual_q,actual_r;
	int fancy_q,fancy_r;

	grsim_init();

	for(i=0;i<280;i++) {

		fancy_div(i,&fancy_q,&fancy_r);

		actual_q=i/7;
		actual_r=i%7;

		if ((fancy_q!=actual_q) || (fancy_r!=actual_r)) {
			printf("%03x\t%d,%d\t%d,%d\n",
				i,actual_q,actual_r,fancy_q,fancy_r);
		}
	}

	return 0;
}
