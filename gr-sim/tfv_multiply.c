#include <stdio.h>
#include <stdlib.h>

//#define FIXED_IMPLEMENTATION	0
//#define FIXED_IMPLEMENTATION	1
//#define FIXED_IMPLEMENTATION	2
#define FIXED_IMPLEMENTATION	3


#if FIXED_IMPLEMENTATION==0
int fixed_mul(int x_i,int x_f,
		int y_i,int y_f,
		int *z_i,int *z_f,
		int debug) {

        short a,b;
	int c;

        a=((x_i)<<8)+(x_f);
        b=((y_i)<<8)+(y_f);

        c=a*b;

	if (debug) {
		printf("%x:%x (%d) * %x:%x (%d) = %x (%d)\n",
			x_i,x_f,a,
			y_i,y_f,b,
			c,c);
	}

        c>>=8;

	*z_i=(c>>8);
	*z_f=(c&0xff);


	return a*b;
}
#endif


#if FIXED_IMPLEMENTATION==1
int fixed_mul(int x_i,int x_f,
		int y_i, int y_f,
		int *z_i, int *z_f,
			int debug) {

	int num1h,num1l;
	int num2h,num2l;
	int result3;
	int result2,result1,result0;
	int aa,xx,cc=0,cc2,yy;
	int negate=0;

	num1h=x_i;
	num1l=x_f;

	if (!(num1h&0x80)) goto check_num2;	// bpl check_num2

	negate++;				// inc negate

	num1l=~num1l;
	num1h=~num1h;

	num1l&=0xff;
	num1h&=0xff;

	num1l+=1;
	cc=!!(num1l&0x100);
	num1h+=cc;

	num1l&=0xff;
	num1h&=0xff;
check_num2:

	num2h=y_i;
	num2l=y_f;

	if (!(num2h&0x80)) goto unsigned_multiply;

	negate++;

	num2l=~num2l;
	num2h=~num2h;

	num2l&=0xff;
	num2h&=0xff;

	num2l+=1;
	cc=!!(num2l&0x100);
	num2h+=cc;

	num2l&=0xff;
	num2h&=0xff;

unsigned_multiply:

	if (debug) {
		printf("Using %02x:%02x * %02x:%02x\n",num1h,num1l,num2h,num2l);
	}

	result0=0;
	result1=0;


//label_multiply:
	aa=0;		// lda #0 (sz)
	result2=aa;	// sta result+2
	xx=16;		// ldx #16 (sz)
label_l1:
	cc=(num2h&1);	//lsr NUM2+1 (szc)
	num2h>>=1;
	num2h&=0x7f;
//	if (num2_neg) {
//		num2h|=0x80;
//	}

	cc2=(num2l&1);	// ror NUM2 (szc)
	num2l>>=1;
	num2l&=0x7f;


	num2l|=(cc<<7);
	cc=cc2;

	if (cc==0) goto label_l2;	// bcc L2

	yy=aa;				// tay (sz)
	cc=0;				// clc
	aa=num1l;			// lda NUM1 (sz)
	aa=aa+cc+result2;		// adc RESULT+2 (svzc)
	cc=!!(aa&0x100);
	aa&=0xff;
	result2=aa;			// sta RESULT+2
	aa=yy;				// tya
	aa=aa+cc+num1h;			// adc NUM1+1
	cc=!!(aa&0x100);
	aa=aa&0xff;

label_l2:
	cc2=aa&1;
	aa=aa>>1;
	aa&=0x7f;
	aa|=cc<<7;
	cc=cc2;		// ror A

	cc2=result2&1;
	result2=result2>>1;
	result2&=0x7f;
	result2|=(cc<<7);
	cc=cc2;		// ror result+2

	cc2=result1&1;
	result1=result1>>1;
	result1&=0x7f;
	result1|=cc<<7;
	cc=cc2;		// ror result+1

	cc2=result0&1;
	result0=result0>>1;
	result0&=0x7f;
	result0|=cc<<7;
	cc=cc2;		// ror result+0

	xx--;				// dex
	if (xx!=0) goto label_l1;	// bne L1

	result3=aa&0xff;		// sta result+3


	if (debug) {
		printf("RAW RESULT = %02x:%02x:%02x:%02x\n",
			result3&0xff,result2&0xff,result1&0xff,result0&0xff);
	}

	if (negate&1) {
//		printf("NEGATING!\n");

		cc=0;

		aa=0;
		aa-=result0+cc;
		cc=!!(aa&0x100);
		result0=aa;

		aa=0;
		aa-=result1+cc;
		cc=!!(aa&0x100);
		result1=aa;

		aa=0;
		aa-=result2+cc;
		cc=!!(aa&0x100);
		result2=aa;

		aa=0;
		aa-=result3+cc;
		cc=!!(aa&0x100);
		result3=aa;

	}

	*z_i=result2&0xff;
	*z_f=result1&0xff;

	result3&=0xff;
	result2&=0xff;
	result1&=0xff;
	result0&=0xff;


	if (debug) {
		printf("%02x:%02x * %02x:%02x = %02x:%02x:%02x:%02x\n",
			num1h,num1l,y_i,y_f,
			result3&0xff,result2&0xff,result1&0xff,result0&0xff);

//		printf("%02x%02x * %02x%02x = %02x%02x%02x%02x\n",
//			num1h,num1l,y_i,y_f,
//			result3,result2,result1,result0);
	}

	int a2;
//	int s1,s2;
//	s1=(num1h<<8)|(num1l);
//	s2=(y_i<<8)|(y_f);
	a2=(result3<<24)|(result2<<16)|(result1<<8)|result0;
//	printf("%d * %d = %d (0x%x)\n",s1,s2,a2,a2);


	return a2;

}
#endif


#if FIXED_IMPLEMENTATION==2

// Description: Unsigned 16-bit multiplication with unsigned 32-bit result.
// Input: 16-bit unsigned value in T1
// 16-bit unsigned value in T2
// Carry=0: Re-use T1 from previous multiplication (faster)
// Carry=1: Set T1 (slower)
//
// Output: 32-bit unsigned value in PRODUCT
// Clobbered: PRODUCT, X, A, C
// Allocation setup: T1,T2 and PRODUCT preferably on Zero-page.
//                   square1_lo, square1_hi, square2_lo, square2_hi must be
//                   page aligned. Each table are 512 bytes. Total 2kb.
//
// Table generation: I:0..511
//                   square1_lo = <((I*I)/4)
//                   square1_hi = >((I*I)/4)
//                   square2_lo = <(((I-255)*(I-255))/4)
//                   square2_hi = >(((I-255)*(I-255))/4)

static unsigned char square1_lo[512];
static unsigned char square1_hi[512];
static unsigned char square2_lo[512];
static unsigned char square2_hi[512];

static int table_ready=0;

static void init_table(void) {

	int i;

	for(i=0;i<512;i++) {
		square1_lo[i]=((i*i)/4)&0xff;
		square1_hi[i]=(((i*i)/4)>>8)&0xff;
		square2_lo[i]=( ((i-255)*(i-255))/4)&0xff;
		square2_hi[i]=(( ((i-255)*(i-255))/4)>>8)&0xff;
//		printf("%d %x:%x %x:%x\n",i,square1_hi[i],square1_lo[i],
//			square2_hi[i],square2_lo[i]);
	}
	table_ready=1;

	// 3 * 2
	// 3+2 = 5
	// 3-2 = 1
	// (25 - 1) = 24/4 = 6

//	int num1l,num2l,a1,a2;

//	num1l=7;
//	num2l=9;

//	printf("Trying %d*%d\n",num1l,num2l);
//	a1=square1_lo[num1l+num2l];
//	printf("((%d+%d)^2)/4: %d\n",num1l,num2l,a1);
//	a2=square2_lo[((~num1l)&0xff)+num2l];
//	printf("((%d-%d)^2)/4: %d\n",num1l,num2l,a2);

//	printf("%d*%d=%d\n",num1l,num2l,a1-a2);

}

static unsigned int product[4];

int fixed_mul_unsigned(int x_i,int x_f,
		int y_i, int y_f,
		int *z_i, int *z_f,
			int debug) {

//	<T1 * <T2 = AAaa
//	<T1 * >T2 = BBbb
//	>T1 * <T2 = CCcc
//	>T1 * >T2 = DDdd
//
//	       AAaa
//	     BBbb
//	     CCcc
//	 + DDdd
//	 ----------
//	   PRODUCT!

//                ; Setup T1 if changed
	int c=0;
	int a,x;
	int sm1a,sm3a,sm5a,sm7a;
	int sm2a,sm4a,sm6a,sm8a;
	int sm1b,sm3b,sm5b,sm7b;
	int sm2b,sm4b,sm6b,sm8b;

	int _AA,_BB,_CC,_DD,_aa,_bb,_cc,_dd;

	if (!table_ready) init_table();

//	printf("\t\t\tMultiplying %2x:%2x * %2x:%2x\n",x_i,x_f,y_i,y_f);

	/* Set up self-modifying code */
	if (c==0) {
		a=(x_f)&0xff;		// lda T1+0		; 3
		sm1a=a;			// sta sm1a+1		; 3
		sm3a=a;			// sta sm3a+1		; 3
		sm5a=a;			// sta sm5a+1		; 3
		sm7a=a;			// sta sm7a+1		; 3
		a=(~a)&0xff;		// eor #$ff		; 2
		sm2a=a;			// sta sm2a+1		; 3
		sm4a=a;			// sta sm4a+1		; 3
		sm6a=a;			// sta sm6a+1		; 3
		sm8a=a;			// sta sm8a+1		; 3
		a=(x_i)&0xff;		// lda T1+1		; 3
		sm1b=a;			// sta sm1b+1		; 3
		sm3b=a;			// sta sm3b+1		; 3
		sm5b=a;			// sta sm5b+1		; 3
		sm7b=a;			// sta sm7b+1		; 3
		a=(~a)&0xff;		// eor #$ff		; 2
		sm2b=a;			// sta sm2b+1		; 3
		sm4b=a;			// sta sm4b+1		; 3
		sm6b=a;			// sta sm6b+1		; 3
		sm8b=a;			// sta sm8b+1		; 3
	}

	/* Perform <T1 * <T2 = AAaa */
	x=(y_f)&0xff;			// ldx T2+0 (low le)		; 3
	c=1;					// sec			; 2
//sm1a:
	a=square1_lo[sm1a+x];			// lda square1_lo,x	; 4
//sm2a:
	a+=~(square2_lo[sm2a+x])+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;

//	printf("\t\t\t\ta=(%d+%d)^2/4=%d "
//		"b=(%d+%d)^2/4=%d\n",
//		sm1a,x,square1_lo[sm1a+x],
//		sm2a,x,square2_lo[sm2a+x]);
	product[0]=a;				// sta PRODUCT+0	; 3
	_aa=a;
//	printf("\t\t\t\ta-b aa=%2x\n",a);
//sm3a:
	a=square1_hi[sm3a+x];			// lda square1_hi,x	; 4
//sm4a:
	a+=(~(square2_hi[sm4a+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;

//	printf("\t\t\t\ta=%d b=%d\n",square1_hi[sm3a+x],square2_hi[sm4a+x]);

	_AA=a;					// sta _AA+1		; 3
//	printf("\t\t\t\tAA=%2x\n",a);

	/* Perform >T1_hi * <T2 = CCcc */
	c=1;					// sec			; 2
//sm1b:
	a=square1_lo[sm1b+x];			// lda square1_lo,x	; 4
//sm2b:
	a+=(~(square2_lo[sm2b+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;

	_cc=a;					// sta _cc+1		; 3
//sm3b:
	a=square1_hi[sm3b+x];			// lda square1_hi,x	; 4
//sm4b:
	a+=(~(square2_hi[sm4b+x]))+c;		// sbc square2_hi,x	; 4
	c=!!(a&0x100);
	a&=0xff;
	_CC=a;					// sta _CC+1		; 3

	/* Perform <T1 * >T2 = BBbb */
	x=(y_i)&0xff;				// ldx T2+1		; 3
	c=1;					// sec			; 2
//sm5a:
	a=square1_lo[sm5a+x];			// lda square1_lo,x	; 4
//sm6a:
	a+=(~(square2_lo[sm6a+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_bb=a;					// sta _bb+1		; 3
//	printf("\t\t\t\tbb=%x c=%d\n",_bb,c);
//sm7a:
	a=square1_hi[sm7a+x];			// lda square1_hi,x	; 4
//sm8a:
	a+=(~(square2_hi[sm8a+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_BB=a;					// sta _BB+1

	/* Perform >T1 * >T2 = DDdd */
	c=1;					// sec			; 2
//sm5b:
	a=square1_lo[sm5b+x];			// lda square1_lo,x	; 4
//sm6b:
	a+=(~(square2_lo[sm6b+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_dd=a;					// sta _dd+1		; 3
//sm7b:
	a=square1_hi[sm7b+x];			// lda square1_hi,x	; 4
//sm8b:
	a+=(~(square2_hi[sm8b+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;

	product[3]=a;				// sta PRODUCT+3	; 3
	_DD=a;

	/*********************************************/
	/* Add the separate multiplications together */
	/*********************************************/

	// product[0]=_aa;
	if (debug) printf("product[0]=0.%02x\n",_aa);

	// product[1]=_AA+_bb+(_cc)
	if (debug) printf("product[1]=%02x+%02x+0=",_AA,_bb);

	c=0;					// clc			; 2
//_AA:
	a=_AA;					// lda #0		; 2
//_bb:
	a+=(c+_bb);				// adc #0		; 2
	c=!!(a&0x100);
	a&=0xff;
	product[1]=a;				// sta PRODUCT+1	; 3
	if (debug) printf("%x.%02x\n",c,a);

	// product[2]=_BB+_CC+c
	if (debug) printf("product[2]=%02x+%02x+%d=",_BB,_CC,c);
//_BB:
	a=_BB;					// lda #0		; 2
//_CC:
	a+=(c+_CC);				// adc #0		; 2
	c=!!(a&0x100);
	a&=0xff;
	product[2]=a;				// sta PRODUCT+2	; 3
	if (debug) printf("%x.%02x\n",c,a);

	// product[3]=_DD+c
	if (debug) printf("product[3]=%02x+%d=",_DD,c);
	if (c==0) goto urgh2;			// bcc :+		; 2nt/3
	product[3]++;				// inc PRODUCT+3	; 5
	product[3]&=0xff;
	c=0;					// clc			; 2
urgh2:
	if (debug) printf("%x.%02x\n",c,product[3]);
	// product[1]=_AA+_bb+_cc
	if (debug) printf("product[1]=%02x+%02x+%d=",product[1],_cc,c);
//_cc:
	a=_cc;					// lda #0		; 2
	a+=c+product[1];			// adc PRODUCT+1	; 3
	c=!!(a&0x100);
	a&=0xff;
	product[1]=a;				// sta PRODUCT+1	; 3
	if (debug) printf("%x.%02x\n",c,product[1]);

	// product[2]=_BB+_CC+_dd+c
	if (debug) printf("product[2]=%02x+%02x+%d=",product[2],_dd,c);
//_dd:
	a=_dd;					// lda #0		; 2
	a+=c+product[2];			// adc PRODUCT+2	; 3
	c=!!(a&0x100);
	a&=0xff;
	product[2]=a;				// sta PRODUCT+2	; 3
	if (debug) printf("%x.%02x\n",c,product[2]);

	// product[3]=_DD+c
	if (debug) printf("product[3]=%02x+%d=",product[3],c);
	if (c==0) goto urgh;			// bcc :+		; 2nt/3
	product[3]++;				// inc PRODUCT+3	; 5
	product[3]&=0xff;
urgh:
	if (debug) printf("%x.%02x\n",c,product[3]);
	*z_i=product[1];
	*z_f=product[0];

//	printf("Result=%02x:%02x\n",*z_i,*z_f);

	if (debug) {
		printf("    AAaa        %02x:%02x\n",_AA,_aa);
		printf("  BBbb       %02x:%02x\n",_BB,_bb);
		printf("  CCcc       %02x:%02x\n",_CC,_cc);
		printf("DDdd      %02x:%02x\n",_DD,_dd);
	}

	return (product[3]<<24)|(product[2]<<16)|(product[1]<<8)|product[0];
						// rts			; 6
}

/* signed */
int fixed_mul(int x_i,int x_f,
		int y_i, int y_f,
		int *z_i, int *z_f,
			int debug) {

	int a,c;

	fixed_mul_unsigned(x_i,x_f,y_i,y_f,z_i,z_f,debug);
					// jsr multiply_16bit_unsigned	; 6

	a=(x_i&0xff);			// lda T1+1			; 3
	if ((a&0x80)==0) goto x_positive;	// bpl :+		; 3/2nt
	if (debug) printf("Before:   %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

//	a=0xff;			// lda #$ff	; 2
//	c=1;			// sec		; 2
//	a=product[0]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[0]=a;		// sta product[0]; 3


//	a=0xff;			// lda #$ff	; 2
//	a=product[1]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[1]=a;		// sta product[0]; 3


//	a=0xff;
//	a=product[2]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[2]=a;		// sta product[0]; 3


//	a=0xff;
//	a=product[3]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[3]=a;		// sta product[0]; 3

//	product[1]^=a;
//	product[2]^=a;
//	product[3]^=a;


	c=1;				// sec				; 2
	a=product[2];			// lda PRODUCT+2		; 3
	a+=(~y_f)+c;			// sbc T2+0			; 3
	c=!(a&0x100);
	a&=0xff;
	product[2]=a;			// sta PRODUCT+2		; 3
	a=product[3];			// lda PRODUCT+3		; 3
	a+=(~y_i)+c;			// sbc T2+1			; 3
	c=!(a&0x100);
	a&=0xff;
	product[3]=a;			// sta PRODUCT+3		; 3
	if (debug) printf("After:    %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

x_positive:

	a=(y_i&0xff);				// lda T2+1			; 3
	if ((a&0x80)==0) goto y_positive;	// bpl :+		; 3/2nt

	if (debug) printf("Before:   %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);
//	a=0xff;			// lda #$ff	; 2
//	c=1;			// sec		; 2
//	a=product[0]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[0]=a;		// sta product[0]; 3


//	a=0xff;			// lda #$ff	; 2
//	a=product[1]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[1]=a;		// sta product[0]; 3


//	a=0xff;
//	a=product[2]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[2]=a;		// sta product[0]; 3


//	a=0xff;
//	a=product[3]^a;		// eor product[0]; 3
//	a&=0xff;
//	a+=0+c;			// adc #0	; 2
//	c=!!(a&0x100);
//	a&=0xff;
//	product[3]=a;		// sta product[0]; 3


	c=1;				// sec				; 2
	a=product[2];			// lda PRODUCT+2		; 3
	a+=(~x_f)+c;			// sbc T1+0			; 3
	c=!(a&0x100);
	a&=0xff;
	product[2]=a;			// sta PRODUCT+2		; 3
	a=product[3];			// lda PRODUCT+3		; 3
	a+=(~x_i)+c;			// sbc T1+1			; 3
	c=!(a&0x100);
	a&=0xff;
	product[3]=a;			// sta PRODUCT+3		; 3

	if (debug) printf("After:    %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

y_positive:
	*z_i=product[2];
	*z_f=product[1];

	return (product[3]<<24)|(product[2]<<16)|(product[1]<<8)|product[0];
						// rts			; 6
}

#endif



#if FIXED_IMPLEMENTATION==3

// Description: Unsigned 16-bit multiplication with unsigned 32-bit result.
// Input: 16-bit unsigned value in T1
// 16-bit unsigned value in T2
// Carry=0: Re-use T1 from previous multiplication (faster)
// Carry=1: Set T1 (slower)
//
// Output: 32-bit unsigned value in PRODUCT
// Clobbered: PRODUCT, X, A, C
// Allocation setup: T1,T2 and PRODUCT preferably on Zero-page.
//                   square1_lo, square1_hi, square2_lo, square2_hi must be
//                   page aligned. Each table are 512 bytes. Total 2kb.
//
// Table generation: I:0..511
//                   square1_lo = <((I*I)/4)
//                   square1_hi = >((I*I)/4)
//                   square2_lo = <(((I-255)*(I-255))/4)
//                   square2_hi = >(((I-255)*(I-255))/4)

static unsigned char square1_lo[512];
static unsigned char square1_hi[512];
static unsigned char square2_lo[512];
static unsigned char square2_hi[512];

static int table_ready=0;

static void init_table(void) {

	int i;

	for(i=0;i<512;i++) {
		square1_lo[i]=((i*i)/4)&0xff;
		square1_hi[i]=(((i*i)/4)>>8)&0xff;
		square2_lo[i]=( ((i-255)*(i-255))/4)&0xff;
		square2_hi[i]=(( ((i-255)*(i-255))/4)>>8)&0xff;
//		printf("%d %x:%x %x:%x\n",i,square1_hi[i],square1_lo[i],
//			square2_hi[i],square2_lo[i]);
	}
	table_ready=1;

	// 3 * 2
	// 3+2 = 5
	// 3-2 = 1
	// (25 - 1) = 24/4 = 6

//	int num1l,num2l,a1,a2;

//	num1l=7;
//	num2l=9;

//	printf("Trying %d*%d\n",num1l,num2l);
//	a1=square1_lo[num1l+num2l];
//	printf("((%d+%d)^2)/4: %d\n",num1l,num2l,a1);
//	a2=square2_lo[((~num1l)&0xff)+num2l];
//	printf("((%d-%d)^2)/4: %d\n",num1l,num2l,a2);

//	printf("%d*%d=%d\n",num1l,num2l,a1-a2);

}

static unsigned int product[4];

int fixed_mul_unsigned(int x_i,int x_f,
		int y_i, int y_f,
			int debug) {

//	<T1 * <T2 = AAaa
//	<T1 * >T2 = BBbb
//	>T1 * <T2 = CCcc
//	>T1 * >T2 = DDdd
//
//	       AAaa
//	     BBbb
//	     CCcc
//	 + DDdd
//	 ----------
//	   PRODUCT!

//                ; Setup T1 if changed
	int c=0;
	int a,x;
	int sm1a,sm3a,sm5a,sm7a;
	int sm2a,sm4a,sm6a,sm8a;
	int sm1b,sm3b,sm5b;//,sm7b;
	int sm2b,sm4b,sm6b;//,sm8b;

	int _AA,_BB,_CC;//,_DD;
	int _aa,_bb,_cc,_dd;

	if (!table_ready) init_table();

	//	printf("\t\t\tMultiplying %2x:%2x * %2x:%2x\n",x_i,x_f,y_i,y_f);

	/* Set up self-modifying code */
	if (c==0) {
		a=(x_f)&0xff;		// lda T1+0		; 3
		sm1a=a;			// sta sm1a+1		; 3
		sm3a=a;			// sta sm3a+1		; 3
		sm5a=a;			// sta sm5a+1		; 3
		sm7a=a;			// sta sm7a+1		; 3
		a=(~a)&0xff;		// eor #$ff		; 2
		sm2a=a;			// sta sm2a+1		; 3
		sm4a=a;			// sta sm4a+1		; 3
		sm6a=a;			// sta sm6a+1		; 3
		sm8a=a;			// sta sm8a+1		; 3
		a=(x_i)&0xff;		// lda T1+1		; 3
		sm1b=a;			// sta sm1b+1		; 3
		sm3b=a;			// sta sm3b+1		; 3
		sm5b=a;			// sta sm5b+1		; 3
//		sm7b=a;			// sta sm7b+1		; 3
		a=(~a)&0xff;		// eor #$ff		; 2
		sm2b=a;			// sta sm2b+1		; 3
		sm4b=a;			// sta sm4b+1		; 3
		sm6b=a;			// sta sm6b+1		; 3
//		sm8b=a;			// sta sm8b+1		; 3
	}

	/* Perform <T1 * <T2 = AAaa */
	x=(y_f)&0xff;			// ldx T2+0 (low le)		; 3
	c=1;					// sec			; 2
	//sm1a:
	a=square1_lo[sm1a+x];			// lda square1_lo,x	; 4
	//sm2a:
	a+=~(square2_lo[sm2a+x])+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;

	//	printf("\t\t\t\ta=(%d+%d)^2/4=%d "
	//		"b=(%d+%d)^2/4=%d\n",
	//		sm1a,x,square1_lo[sm1a+x],
	//		sm2a,x,square2_lo[sm2a+x]);
//	product[0]=a;				// sta PRODUCT+0	; 3
//	_aa=a;
	//	printf("\t\t\t\ta-b aa=%2x\n",a);
	//sm3a:
	a=square1_hi[sm3a+x];			// lda square1_hi,x	; 4
	//sm4a:
	a+=(~(square2_hi[sm4a+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;

	//	printf("\t\t\t\ta=%d b=%d\n",square1_hi[sm3a+x],square2_hi[sm4a+x]);

	_AA=a;					// sta _AA+1		; 3
	//	printf("\t\t\t\tAA=%2x\n",a);

	/* Perform >T1_hi * <T2 = CCcc */
	c=1;					// sec			; 2
	//sm1b:
	a=square1_lo[sm1b+x];			// lda square1_lo,x	; 4
	//sm2b:
	a+=(~(square2_lo[sm2b+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;

	_cc=a;					// sta _cc+1		; 3
	//sm3b:
	a=square1_hi[sm3b+x];			// lda square1_hi,x	; 4
	//sm4b:
	a+=(~(square2_hi[sm4b+x]))+c;		// sbc square2_hi,x	; 4
	c=!!(a&0x100);
	a&=0xff;
	_CC=a;					// sta _CC+1		; 3

	/* Perform <T1 * >T2 = BBbb */
	x=(y_i)&0xff;				// ldx T2+1		; 3
	c=1;					// sec			; 2
	//sm5a:
	a=square1_lo[sm5a+x];			// lda square1_lo,x	; 4
	//sm6a:
	a+=(~(square2_lo[sm6a+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_bb=a;					// sta _bb+1		; 3
	//	printf("\t\t\t\tbb=%x c=%d\n",_bb,c);
	//sm7a:
	a=square1_hi[sm7a+x];			// lda square1_hi,x	; 4
	//sm8a:
	a+=(~(square2_hi[sm8a+x]))+c;		// sbc square2_hi,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_BB=a;					// sta _BB+1

	/* Perform >T1 * >T2 = DDdd */
	c=1;					// sec			; 2
	//sm5b:
	a=square1_lo[sm5b+x];			// lda square1_lo,x	; 4
	//sm6b:
	a+=(~(square2_lo[sm6b+x]))+c;		// sbc square2_lo,x	; 4
	c=!(a&0x100);
	a&=0xff;
	_dd=a;					// sta _dd+1		; 3
	//sm7b:
//	a=square1_hi[sm7b+x];			// lda square1_hi,x	; 4
	//sm8b:
//	a+=(~(square2_hi[sm8b+x]))+c;		// sbc square2_hi,x	; 4
//	c=!(a&0x100);
//	a&=0xff;

//	product[3]=a;				// sta PRODUCT+3	; 3
//	_DD=a;

	/*********************************************/
	/* Add the separate multiplications together */
	/*********************************************/

	// product[0]=_aa;
	//	if (debug) printf("product[0]=0.%02x\n",_aa);

	// product[1]=_AA+_bb+(_cc)
	if (debug) printf("product[1]=%02x+%02x+0=",_AA,_bb);

	c=0;					// clc			; 2
	//_AA:
	a=_AA;					// lda #0		; 2
	//_bb:
	a+=(c+_bb);				// adc #0		; 2
	c=!!(a&0x100);
	a&=0xff;
	product[1]=a;				// sta PRODUCT+1	; 3
	if (debug) printf("%x.%02x\n",c,a);

	// product[2]=_BB+_CC+c
	if (debug) printf("product[2]=%02x+%02x+%d=",_BB,_CC,c);
	//_BB:
	a=_BB;					// lda #0		; 2
	//_CC:
	a+=(c+_CC);				// adc #0		; 2
	c=!!(a&0x100);
	a&=0xff;
	product[2]=a;				// sta PRODUCT+2	; 3
	if (debug) printf("%x.%02x\n",c,a);

	// product[3]=_DD+c
//	if (debug) printf("product[3]=%02x+%d=",_DD,c);
//	if (c==0) goto urgh2;			// bcc :+		; 2nt/3
//	product[3]++;				// inc PRODUCT+3	; 5
//	product[3]&=0xff;
	c=0;					// clc			; 2
//urgh2:
//	if (debug) printf("%x.%02x\n",c,product[3]);
	// product[1]=_AA+_bb+_cc
//	if (debug) printf("product[1]=%02x+%02x+%d=",product[1],_cc,c);
	//_cc:
	a=_cc;					// lda #0		; 2
	a+=c+product[1];			// adc PRODUCT+1	; 3
	c=!!(a&0x100);
	a&=0xff;
	product[1]=a;				// sta PRODUCT+1	; 3
	if (debug) printf("%x.%02x\n",c,product[1]);

	// product[2]=_BB+_CC+_dd+c
	if (debug) printf("product[2]=%02x+%02x+%d=",product[2],_dd,c);
	//_dd:
	a=_dd;					// lda #0		; 2
	a+=c+product[2];			// adc PRODUCT+2	; 3
	c=!!(a&0x100);
	a&=0xff;
	product[2]=a;				// sta PRODUCT+2	; 3
	if (debug) printf("%x.%02x\n",c,product[2]);

	// product[3]=_DD+c
//	if (debug) printf("product[3]=%02x+%d=",product[3],c);
//	if (c==0) goto urgh;			// bcc :+		; 2nt/3
//	product[3]++;				// inc PRODUCT+3	; 5
//	product[3]&=0xff;
//urgh:
//	if (debug) printf("%x.%02x\n",c,product[3]);

	//	printf("Result=%02x:%02x\n",*z_i,*z_f);

//	if (debug) {
//		printf("    AAaa        %02x:%02x\n",_AA,_aa);
//		printf("  BBbb       %02x:%02x\n",_BB,_bb);
//		printf("  CCcc       %02x:%02x\n",_CC,_cc);
//		printf("DDdd      %02x:%02x\n",_DD,_dd);
//	}

	return 0;
//(product[3]<<24)|(product[2]<<16)|(product[1]<<8)|product[0];
						// rts			; 6
}

/* signed */
int fixed_mul(int x_i,int x_f,
		int y_i, int y_f,
		int *z_i, int *z_f,
			int debug) {

	int a,c;

	fixed_mul_unsigned(x_i,x_f,y_i,y_f,debug);
					// jsr multiply_16bit_unsigned	; 6

	a=(x_i&0xff);			// lda T1+1			; 3
	if ((a&0x80)==0) goto x_positive;	// bpl :+		; 3/2nt
	if (debug) printf("Before:   %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

	c=1;				// sec				; 2
	a=product[2];			// lda PRODUCT+2		; 3
	a+=(~y_f)+c;			// sbc T2+0			; 3
	c=!(a&0x100);
	a&=0xff;
	product[2]=a;			// sta PRODUCT+2		; 3
//	a=product[3];			// lda PRODUCT+3		; 3
//	a+=(~y_i)+c;			// sbc T2+1			; 3
//	c=!(a&0x100);
//	a&=0xff;
//	product[3]=a;			// sta PRODUCT+3		; 3
	if (debug) printf("After:    %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

x_positive:

	a=(y_i&0xff);				// lda T2+1			; 3
	if ((a&0x80)==0) goto y_positive;	// bpl :+		; 3/2nt

	if (debug) printf("Before:   %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

	c=1;				// sec				; 2
	a=product[2];			// lda PRODUCT+2		; 3
	a+=(~x_f)+c;			// sbc T1+0			; 3
	c=!(a&0x100);
	a&=0xff;
	product[2]=a;			// sta PRODUCT+2		; 3
//	a=product[3];			// lda PRODUCT+3		; 3
//	a+=(~x_i)+c;			// sbc T1+1			; 3
//	c=!(a&0x100);
//	a&=0xff;
//	product[3]=a;			// sta PRODUCT+3		; 3

	if (debug) printf("After:    %02x:%02x:%02x:%02x\n",product[3],product[2],product[1],product[0]);

y_positive:
	*z_i=product[2];
	*z_f=product[1];

//	return (product[3]<<24)|(product[2]<<16)|(product[1]<<8)|product[0];
	return 0;
						// rts			; 6
}

#endif

int main(int argc, char **argv) {

	int a_i,b_i,c_i;
	int a_f,b_f,c_f;
	short x,y;
	int l,k,i,j;

	printf("Some tests\n");
#if 0
	x=-32768;
	y=3;

	a_i=x>>8;
	a_f=x&0xff;
	b_i=y>>8;
	b_f=y&0xff;

	printf("\tTrying %d*%d=%d (0x%x)\n",x,y,x*y,x*y);
	k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
	if (k!=x*y) {
		printf("\t\tError! got %d (0x%x)\n",k,k);
		exit(1);
	}
	else {
		printf("\t\tProperly calculated %d\n",k);
	}

	a_i=0x0;
	a_f=0x7;

	b_i=0x0;
	b_f=0x9;

	x=7;
	y=9;

	printf("\tTrying %d*%d=%d (0x%x)\n",x,y,x*y,x*y);
	k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
	if (k!=x*y) {
		printf("\t\tError! got %d (0x%x)\n",k,k);
		exit(1);
	}
	else {
		printf("\t\tProperly calculated %d (0x%x)\n",k,k);
	}

	a_i=0x0;
	a_f=0x2;

	b_i=0x0;
	b_f=0x3;

	x=2;
	y=3;

	printf("\tTrying %d*%d=%d (0x%x)\n",x,y,x*y,x*y);
	k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
	if (k!=x*y) {
		printf("\t\tError! got %d (0x%x)\n",k,k);
		exit(1);
	}
	else {
		printf("\t\tProperly calculated %d (0x%x)\n",k,k);
	}

	a_i=0xff;
	a_f=0xff;

	b_i=0xff;
	b_f=0xff;

	x=0xffff;
	y=0xffff;

	printf("\tTrying %d*%d=%d (0x%x)\n",x,y,x*y,x*y);
	k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
	if (k!=x*y) {
		printf("\t\tError! got %d (0x%x)\n",k,k);
		exit(1);
	}
	else {
		printf("\t\tProperly calculated %d (0x%x)\n",k,k);
	}

	a_i=0xff;
	a_f=0xff;

	b_i=0x00;
	b_f=0x01;

	x=0xffff;
	y=0x1;

	printf("\tTrying %d*%d=%d (0x%x)\n",x,y,x*y,x*y);
	k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
	if (k!=x*y) {
		printf("\t\tError! got %d (0x%x)\n",k,k);
		exit(1);
	}
	else {
		printf("\t\tProperly calculated %d (0x%x)\n",k,k);
	}

	a_i=0x00;
	a_f=0xff;

	b_i=0x00;
	b_f=0x01;

	x=0xff;
	y=0x1;

	printf("\tTrying %d*%d=%d (0x%x)\n",x,y,x*y,x*y);
	k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
	if (k!=x*y) {
		printf("\t\tError! got %d (0x%x)\n",k,k);
		exit(1);
	}
	else {
		printf("\t\tProperly calculated %d (0x%x)\n",k,k);
	}

	for(i=-32768;i<32768;i++) {
		for(j=-32768;j<32768;j++) {
			a_i=i>>8;
			a_f=i&0xff;
			b_i=j>>8;
			b_f=j&0xff;

			k=fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);

			if (k!=i*j) {
				printf("WRONG! %x*%x = %x not %x\n",
					i,j,i*j,k);
				printf("       %d * %d = %d not %d\n",i,j,i*j,k);
				exit(1);
			}
		}
		if (i%256==0) printf("%x\n",i);
	}
#endif

	for(i=-32768;i<32768;i++) {
		for(j=-32768;j<32768;j++) {
			a_i=i>>8;
			a_f=i&0xff;
			b_i=j>>8;
			b_f=j&0xff;

			fixed_mul(a_i,a_f,b_i,b_f,&c_i,&c_f,0);
			k=((i*j)>>8)&0xffff;
			l=(c_i<<8)|(c_f);

			if (k!=l) {
				printf("WRONG! %x*%x = %x, %x not %02x:%02x\n",
					i,j,i*j,k,c_i,c_f);
				printf("       %d * %d = %d not %d\n",i,j,l,k);
				exit(1);
			}
		}
		if (i%256==0) printf("%x\n",i);
	}


	return 0;
}


