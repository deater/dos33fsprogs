#include <stdio.h>
#include <unistd.h>

#include "8086_emulator.h"

unsigned short stack[4096];
unsigned short ax,bx,cx,dx,si,di,bp,cs,ds,es,fs;
int cf=0,of=0,zf=0,sf=0;
//int sp=0;

/* unsigned multiply */
void mul_16(unsigned short value) {
	unsigned int result;

	result=ax*value;

//	printf("%x*%x=%x ",value,ax,result);

	ax=result&0xffff;
	dx=result>>16;

//	printf("%x:%x x=%d y=%d\n",dx,ax,
//		dx&0xff,(dx>>8)&0xff);




	if (dx==0) {
		of=0;
		cf=0;
	}
	else {
		of=1;
		cf=1;
	}

}

/* 
static void imul(short value) {
	int result;

	result=ax*value;

	ax=result&0xffff;
	dx=result>>16;

}
*/



/* signed multiply */
void imul_8(char value) {

	short result;
	char src;

	src=ax;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	ax=result;

	if (ax==(ax&0xff)) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}

/* signed multiply */
/* DX:AX = AX * value */
void imul_16(short value) {

	int result;
	short src;

	src=ax;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	ax=(result&0xffff);
	dx=((result>>16)&0xffff);

	if (dx==0) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}

/* signed multiply */
void imul_16_bx(short value) {

	int result;
	short src;

	src=bx;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	bx=(result&0xffff);

	if (bx==result) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}

/* signed multiply */
void imul_16_dx(short value) {

	int result;
	short src;

	src=dx;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	dx=(result&0xffff);

	if (dx==result) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}





/* unsigned divide */
void div_8(unsigned char value) {

	unsigned char r,q;
	unsigned int result,remainder;

//	printf("Dividing %d (%x) by %d (%x): ",ax,ax,value,value);

	if (value==0) {
		printf("Divide by zero!\n");
		return;
	}

	result=ax/value;
	remainder=ax%value;

	q=result;
	r=remainder;

//	printf("Result: q=%d r=%d\n",q,r);

	ax=(r<<8)|(q&0xff);

}


/* signed divide */
/* DX:AX / word.  AX=quotient, DX=remainder */
void idiv_16(unsigned short value) {

	short r,q,divisor;
	int temp32,result,remainder;

	divisor=value;

	temp32=ax;
	temp32&=0xffff;
	temp32|=(dx<<16);

//	printf("Dividing %d (%x = %04x:%04x) by %d (%x): ",
//		temp32,temp32,dx,ax,value,value);

	if (divisor==0) {
		printf("Divide by zero!\n");
		return;
	}

	result=temp32/divisor;
	remainder=temp32%divisor;

	q=result;
	r=remainder;

//	printf("q=%d r=%d\n",q,r);

	ax=q;
	dx=r;
}

unsigned short sar(unsigned short value,int shift) {

	short temp;

	temp=value;
	temp>>=shift;

	return temp;

}

void push(int value) {
	//printf("Pushing %x\n",value);
	stack[sp]=value;
	sp++;
}

short pop(void) {
	if (sp==0) {
		printf("Stack underflow!\n");
		return 0;
	}

	sp--;

	//printf("Popping %x\n",stack[sp]);

	return stack[sp];

}
