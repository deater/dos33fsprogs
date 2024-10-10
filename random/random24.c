// https://wimcouwenberg.wordpress.com/2020/11/15/a-fast-24-bit-prng-algorithm-for-the-6502-processor/

// lda a           ; Operation 7 (with carry clear).
// asl
// eor b
// sta b
// rol             ; Operation 9.
// eor c
// sta c
// eor a           ; Operation 5.
// sta a
// lda b           ; Operation 15.
// ror
// eor c
// sta c
// eor b           ; Operation 6.
// sta b


#include <stdio.h>

unsigned char a=0,b=0,c=1,carry,carry_new,accum;

int rand24(void) {
	accum=a;			// LDA A
	carry=!!(accum&0x80);
	accum<<=1;			// ASL
	accum=accum^b;			// EOR B
	b=accum;			// STA B
	carry_new=!!(accum&0x80);	// ROL
	accum<<=1;
	accum|=carry;
	carry=carry_new;
	accum=accum^c;			// EOR C
	c=accum;			// STA C
	accum=accum^a;			// EOR A
	a=accum;			// STA A
	accum=b;			// LDA B
	carry_new=accum&1;		// ROR
	accum>>=1;
	accum|=(carry<<7);
	carry=carry_new;
	accum=accum^c;			// EOR C
	c=accum;			// STA C
	accum=accum^b;			// EOR B
	b=accum;			// STA B

	return (a<<16)|(b<<8)|c;

}

int main(int argc, char **argv) {

	int i,r;

	for(i=0;i<1024;i++) {
		r=rand24();
		printf("%d: %06X m%02X\n",i,r,r&0x1f);
	}

	return 0;
}
