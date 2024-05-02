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

#if 0
	x=0;
first_loop:
	a=0;
loop1:
	y=0;
yloop:
	values[x]=a;
	if (y==0) goto skip;
	a+=16;
skip:
	x++;
	y++;
	if (y!=16) goto yloop;

	a+=17;

	if (x==16) goto first_loop;

	if(x!=256) goto loop1;
#endif

#if 0
	x=0;
first_loop:
	a=0;
loop1:
	values[x]=a;
	if ((x&0xf)==0) goto skip;
	a+=16;
skip:
	x++;
	if(x==256) goto done;

	if(x==16) goto first_loop;

	if ((x&0xf)==0) {
		a+=17;
	}

	goto loop1;
#endif

#if 0
	x=0;
first_loop:
	a=0;
loop1:
	y=0;
	values[x]=a;
	x++;
loop2:
	values[x]=a;
	a+=16;

	y++;
	x++;
	if(x==256) goto done;

	if(x==16) goto first_loop;

	if (y==15) {
		a+=17;
		goto loop1;
	}
	goto loop2;

#endif

#if 0
	x=0;
first_loop:
	y=0;
loop1:
	a=y;
	values[x]=a;
	x++;
yloop:
	a=y;
	values[x]=a;
	y++;
	x++;
	if(x==256) goto done;
	if(x==16) goto first_loop;
	a=y;
	a=a&0xf;
	if (a!=0xf) goto yloop;
	y++;
	goto loop1;
#endif
	x=0;	// offset
first_loop:
	y=0xff;	// value
yloop:
	y=y+1;
yloop2:
	a=y;

	values[x]=a;
	y++;
	x++;
	if(x==256) goto done;
	if(x==16) goto first_loop;
	a=x;
	a=a&0xf;
	if (a==0x0) goto yloop;
	a=(a&0xff)>>1;
	if (a!=0) goto yloop2;
	else y=y-1; // a==1
	goto yloop2;

// x  0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
// y  0  0  1  2  3  4  5  6  7  8  9  a  b  c  d  e
// a
//    00 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e

// x  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
// y  0  0  1  2  3  4  5  6  7  8  9  a  b  c  d  e
// a

//    00 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e

// x  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
// y  10 10 11 12  3  4  5  6  7  8  9  a  b  c  d  e
// a

//    10 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e

//	printf("%d\n",x);


done:

	for(x=0;x<256;x++) {
		if (x%16==0) printf("\n");
		printf("$%02X ",values[x]);
	}
	printf("\n\n");

	int newx;
	for(x=0;x<64;x++) {

		newx=(x-64);
		printf("$%02X,",89-(newx*newx)/96);
//		printf("$%02X,",26-(x*x)/64+2*x);
	}




	return 0;
}
