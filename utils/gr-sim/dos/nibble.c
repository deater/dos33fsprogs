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

	Y=yy;			// ldy	   #0
	X=3;			// ldx     #3
L1:
	ram[0x3c]=X;		// stx     $3c
	A=X;			// txa
	asl();			// asl
	bit_mem(0x3c);		// bit     $3c
	if (Z==1) goto L3;	// beq     L3
	ora_mem(0x3c);		// ora     $3c
	eor(0xff);		// eor     #$ff
	and(0x7e);		// and     #$7e
L2:
	if (C==1) goto L3;	// bcs     L3
	lsr();			// lsr
	if (Z==0) goto L2;	// bne     L2

	A=Y;			// tya
	printf("%x=%x\n",X,A);	// sta     nibtbl, x
	Y++;			// iny
L3:
	X++;			// inx
	if (!(X&0x80)) goto L1;	// bpl     L1



	return 0;
}

