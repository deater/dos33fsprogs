#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "6502_emulate.h"
#include "gr-sim.h"

#define TEMP_Q	0xff
#define TEMP_R	0xfe

static void fancy_div(int d, int *q, int *r) {

	//;Divide by 7 (From December '84 Apple Assembly Line)
	//;15 bytes, 27 cycles

	// y=xhigh x=xlow a=??
	// q in y, r in x

	y=(d>>8)&0xff;
	x=d&0xff;

	a=x;

	sta(TEMP_R);

	c=0;
	sta(TEMP_Q);		// 0
	lsr();			// 0
	lsr();			// 0
	lsr();			// 0
	adc_mem(TEMP_Q);	// 0
	ror();			// 0
	lsr();			// 0
	lsr();			// 0
	adc_mem(TEMP_Q);	// 0
	ror();			// 0
	lsr();			// 0
	lsr();			// 0

	c=0;
	sta(TEMP_Q);
	asl();
	adc_mem(TEMP_Q);
	asl();
	adc_mem(TEMP_Q);

	c=1;
	sta(TEMP_R);
	txa();
	sbc_mem(TEMP_R);
	tax();

	if (y) {
		x+=4;
		lda(TEMP_Q);
		c=0;
		adc(36);
		sta(TEMP_Q);
	}

	y=ram[TEMP_Q];

	if (x>6) {
		c=1;
		txa();
		sbc(7);
		tax();
		y++;
	}

	*q=y;
	*r=x;
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
