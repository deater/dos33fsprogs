// http://www.6502.org/users/mycorner/6502/code/prng.html

//; returns pseudo random 8 bit number in A. Affects A. (r_seed) is the
//; byte from which the number is generated and MUST be initialised to a
//; non zero value or this function will always return zero. Also r_seed
//; must be in RAM, you can see why......

//rand_8
//	LDA	r_seed		; get seed
//	ASL			; shift byte
//	BCC	no_eor		; branch if no carry
//
//	EOR	#$CF		; else EOR with $CF
//no_eor
//	STA	r_seed		; save number as next seed
//	RTS			; done

//r_seed
//	.byte	1		; prng seed byte, must not be zero


#include <stdio.h>

unsigned char r_seed=1;

int rand8(void) {
	if (r_seed&0x80) {
		r_seed<<=1;
		r_seed^=0xcf;
	}
	else {
		r_seed<<=1;
	}
	return r_seed;
}

int main(int argc, char **argv) {

	int i,r;

	for(i=0;i<1024;i++) {
		r=rand8();
		printf("%d: %02X m%02X\n",i,r,r&0x1f);
	}

	return 0;
}
