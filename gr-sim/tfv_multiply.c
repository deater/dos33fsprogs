#include <stdio.h>
#include <stdlib.h>

#include "tfv_zp.h"

#if 0
int fixed_mul(struct fixed_type *x,
		struct fixed_type *y,
		struct fixed_type *z, int debug) {

        int a,b,c;

        a=((x->i)<<8)+(x->f);
        b=((y->i)<<8)+(y->f);

        c=a*b;

	if (debug) {
		printf("%x:%x (%d) * %x:%x (%d) = %x (%d)\n",
			x->i,x->f,a,
			y->i,y->f,b,
			c,c);
	}

        c>>=8;

        z->i=(c>>8);
        z->f=(c&0xff);


	return a*b;
}
#else


int fixed_mul(struct fixed_type *x,
			struct fixed_type *y,
			struct fixed_type *z,
			int debug) {

	int num1h,num1l;
	int num2h,num2l;
	int result3;
	int result2,result1,result0;
	int aa,xx,cc=0,cc2,yy;
	int negate=0;

	num1h=x->i;
	num1l=x->f;

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

	num2h=y->i;
	num2l=y->f;

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

        z->i=result2&0xff;
        z->f=result1&0xff;

	result3&=0xff;
	result2&=0xff;
	result1&=0xff;
	result0&=0xff;


	if (debug) {
		printf("%02x:%02x * %02x:%02x = %02x:%02x:%02x:%02x\n",
			num1h,num1l,y->i,y->f,
			result3&0xff,result2&0xff,result1&0xff,result0&0xff);

//		printf("%02x%02x * %02x%02x = %02x%02x%02x%02x\n",
//			num1h,num1l,y->i,y->f,
//			result3,result2,result1,result0);
	}

	int a2;
//	int s1,s2;
//	s1=(num1h<<8)|(num1l);
//	s2=(y->i<<8)|(y->f);
	a2=(result3<<24)|(result2<<16)|(result1<<8)|result0;
//	printf("%d * %d = %d (0x%x)\n",s1,s2,a2,a2);


	return a2;

}

#endif


#if 0
int main(int argc, char **argv) {

	struct fixed_type a,b,c;
	int i,j,k;

	i=-32768;
	j=3;

	a.i=i>>8;
	a.f=i&0xff;
	b.i=j>>8;
	b.f=j&0xff;

	k=fixed_mul(&a,&b,&c,1);
	if (k!=i*j) {
		printf("Error!  %d*%d=%d, %d\n",i,j,i*j,k);
	}

	a.i=0x0;
	a.f=0x2;

	b.i=0x0;
	b.f=0x3;

	fixed_mul(&a,&b,&c,0);

	a.i=0xff;
	a.f=0xff;

	b.i=0xff;
	b.f=0xff;

	fixed_mul(&a,&b,&c,0);

	a.i=0xff;
	a.f=0xff;

	b.i=0x00;
	b.f=0x01;

	fixed_mul(&a,&b,&c,0);


	for(i=-32768;i<32768;i++) {
		for(j=-32768;j<32768;j++) {
			a.i=i>>8;
			a.f=i&0xff;
			b.i=j>>8;
			b.f=j&0xff;

			k=fixed_mul(&a,&b,&c,0);

			if (k!=i*j) {
				printf("WRONG! %x*%x = %x not %x\n",
					i,j,i*j,k);
				printf("%d * %d = %d not %d\n",i,j,i*j,k);
				exit(1);
			}
		}
		if (i%256==0) printf("%x\n",i);
	}

	return 0;
}

#endif
