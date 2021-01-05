#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "6502_emulate.h"

int main(int argc, char **argv) {

	int yy;

	grsim_init();
	gr();

	yy=0;
	printf("****yy=%d\n",yy);

	y=yy;			// ldy	   #0
	x=3;			// ldx     #3
L1:
	ram[0x3c]=x;		// stx     $3c
	a=x;			// txa
	asl();			// asl
	bit_mem(0x3c);		// bit     $3c
	if (z==1) goto L3;	// beq     L3
	ora_mem(0x3c);		// ora     $3c
	eor(0xff);		// eor     #$ff
	and(0x7e);		// and     #$7e
L2:
	if (c==1) goto L3;	// bcs     L3
	lsr();			// lsr
	if (z==0) goto L2;	// bne     L2

	a=y;			// tya
	printf("%x=%x\n",x,a);	// sta     nibtbl, x
	y++;			// iny
L3:
	x++;			// inx
	if (!(x&0x80)) goto L1;	// bpl     L1



	return 0;
}

