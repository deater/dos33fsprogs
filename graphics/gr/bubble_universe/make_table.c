#include <stdio.h>

int main(int argc, char **argv) {

	int a,x,y;

	unsigned char values[256];

//
//	ldy #0			; 2
//xloop:
//	ldx #15			; 2
//loop:
//	tya			; 1
//	sec			; 1
//	sbc	#$11		; 2

//	cpx	#15		; 2
//	bne	skip2		; 2
//	and	#$f0		; 2
//	clc			; 1
//	adc	#$10		; 2

// skip2:

//	cpy	#16		; 2
//	bcs	skip		; 2
//	and	#$f		; 2


// skip:
//	sta	table,Y		; 3
//	iny			; 1
//	beq	done		; 2
//	dex			; 1
//	bmi	xloop		; 2
//	bpl	loop		; 2
//done:

#if 0
	for(x=0;x<256;x++) {
		values[x]=x-0x11;
		if (x%16==0) values[x]=(values[x]&0xf0)+0x10;
		if (x<16) values[x]&=0xf;
	}
#endif

#if 0
	y=0;
loop2:
	a=0;
loop1:
	values[y]=a;
	y++;
	for(x=0;x<15;x++) {
		values[y]=a;
		a+=16;
		y++;

	}
	a+=17;
	if (y==16) goto loop2;
	if(y!=256) goto loop1;
#endif

	y=0;
loop2:
	a=0;
loop1:
//	values[y]=a;
//	y++;
	for(x=0;x<16;x++) {
		values[y]=a;
		if (x) a+=16;
		y++;

	}
	a+=17;
	if (y==16) goto loop2;
	if(y!=256) goto loop1;


	for(x=0;x<256;x++) {
		if (x%16==0) printf("\n");
		printf("$%02X ",values[x]);
	}
	printf("\n");

	return 0;
}
