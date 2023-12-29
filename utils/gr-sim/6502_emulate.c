#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "6502_emulate.h"

/* 128kB of RAM */
#define RAMSIZE 128*1024
unsigned char ram[RAMSIZE];

/* Registers */
unsigned char A,Y,X;
unsigned short SP;

/* Flags */
unsigned int N,Z,C,V;

int init_6502(void) {

	A=0;
	Y=0;
	X=0;

	SP=0x1ff;

	N=0; Z=0; C=0; V=0;

	return 0;

}

unsigned short y_indirect(unsigned char base, unsigned char y) {

	unsigned short addr;

	addr=(((short)(ram[base+1]))<<8) | (short)ram[base];

	//if (debug) printf("Address=%x\n",addr+y);

	return addr+y;

}

void clc(void) {
	C=0;
}

void adc(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=value&0xff;

	result=(temp_a+temp_value+C);

	C=(result&0x100)>>8;
	N=(result&0x80)>>7;

	V=!!((A^result)&(value^result)&0x80);

	A=result&0xff;
	Z=(A==0);

}

void adc_mem(int addr) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=ram[addr]&0xff;

	result=(temp_a+temp_value+C);

	C=(result&0x100)>>8;
	N=(result&0x80)>>7;

	V=!!((A^result)&(temp_value^result)&0x80);

	A=result&0xff;
	Z=(A==0);

}

void sbc(int value) {
	int temp_a;
	int result;
	int temp_value;

	temp_a=A&0xff;
	temp_value=(~value)&0xff;

	result=temp_a+temp_value+C;

//	printf("SBC: %x - %x (%x) = %x\n",A,value,C,result);

	C=(result&0x100)>>8;
	N=(result&0x80)>>7;

	V=!!((A^result)&((255-value)^result)&0x80);

	A=result&0xff;
	Z=(A==0);


}

void sbc_mem(int addr) {
	int temp_a;
	int result;
	int temp_value;

	temp_a=A&0xff;
	temp_value=(~ram[addr])&0xff;

	result=temp_a+temp_value+C;

//	printf("SBC: %x - %x (%x) = %x\n",A,value,C,result);

	C=(result&0x100)>>8;
	N=(result&0x80)>>7;

	V=!!((A^result)&((255-ram[addr])^result)&0x80);

	A=result&0xff;
	Z=(A==0);


}

void cmp(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=(~value)&0xff;

	result=temp_a+temp_value+1;

	C=(result&0x100)>>8;

	result&=0xff;

	N=(result&0x80)>>7;
	Z=(result==0);
}

void cpy(int value) {

	int temp_y;
	int temp_value;
	int result;

	temp_y=Y&0xff;
	temp_value=(~value)&0xff;

	result=temp_y+temp_value+1;

	C=(result&0x100)>>8;

	result&=0xff;

	N=(result&0x80)>>7;
	Z=(result==0);
}

void cpx(int value) {

	int temp_x;
	int temp_value;
	int result;

	temp_x=X&0xff;
	temp_value=(~value)&0xff;

	result=temp_x+temp_value+1;

	C=(result&0x100)>>8;

	result&=0xff;

	N=(result&0x80)>>7;
	Z=(result==0);
}


void pha(void) {

	SP--;
	ram[SP]=A;
}

void pla(void) {

	A=ram[SP];
	SP++;
}

void lsr(void) {
	int temp_a;

	temp_a=A;
	temp_a&=0xff;

	C=temp_a&0x1;
	temp_a=temp_a>>1;
	A=(temp_a&0x7f);	// always shift 0 into top
	Z=(A==0);
	N=!!(A&0x80);		// can this ever be 1?  no?
//	printf("LSR A=%x\n",A);
}

void asl(void) {
	int temp_a;

	temp_a=A;
	temp_a&=0xff;

	C=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	A=(temp_a&0xff);
	Z=(A==0);
	N=!!(A&0x80);
//	printf("ASL A=%x\n",A);
}

void asl_mem(int addr) {
	int temp_a;

	temp_a=ram[addr];
	temp_a&=0xff;

	C=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	ram[addr]=(temp_a&0xff);
	Z=(ram[addr]==0);
	N=!!(ram[addr]&0x80);
//	printf("ASL %x=%x\n",addr,ram[addr]);
}


void ror(void) {
	int temp_a;
	int old_c;

	old_c=C;
	temp_a=A;
	temp_a&=0xff;

	C=temp_a&0x1;
	temp_a=temp_a>>1;
	A=(temp_a&0xff);
	A|=old_c<<7;

	Z=(A==0);
	N=!!(A&0x80);
//	printf("ROR A=%x\n",A);
}

void rol(void) {
	int temp_a;
	int old_c;

	old_c=C;
	temp_a=A;
	temp_a&=0xff;

	C=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	A=(temp_a&0xff);
	A|=old_c;

	Z=(A==0);
	N=!!(A&0x80);
//	printf("ROL A=%x\n",A);
}



void ror_mem(int addr) {
	int temp_a;
	int old_c;

	old_c=C;
	temp_a=ram[addr];
	temp_a&=0xff;

	C=temp_a&0x1;
	temp_a=temp_a>>1;
	ram[addr]=(temp_a&0xff);
	ram[addr]|=old_c<<7;

	Z=(ram[addr]==0);
	N=!!(ram[addr]&0x80);
//	printf("ROR %x=%x\n",addr,ram[addr]);
}

void rol_mem(int addr) {
	int temp_a;
	int old_c;

	old_c=C;
	temp_a=ram[addr];
	temp_a&=0xff;

	C=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	ram[addr]=(temp_a&0xff);
	ram[addr]|=old_c;

	Z=(ram[addr]==0);
	N=!!(ram[addr]&0x80);
//	printf("ROL %x=%x\n",addr,ram[addr]);
}


void dex(void) {
	X--;

	Z=(X==0);
	N=!!(X&0x80);
}

void dey(void) {
	Y--;

	Z=(Y==0);
	N=!!(Y&0x80);
}

void inx(void) {
	X++;

	Z=(X==0);
	N=!!(X&0x80);
}

void iny(void) {
	Y++;

	Z=(Y==0);
	N=!!(Y&0x80);
}

void bit(int value) {
	int temp_a;

	temp_a=A&value;
	temp_a&=0xff;

	Z=(temp_a==0);

	N=(value&0x80);
	V=(value&0x40);

}

	/* a is not modified */
void bit_mem(int addr) {
	int temp_a;

	temp_a=A&ram[addr];
	temp_a&=0xff;

	Z=(temp_a==0);

	N=(ram[addr]&0x80);
	V=(ram[addr]&0x40);

}


void lda(int addr) {

	A=ram[addr];

	Z=(A==0);
	N=!!(A&0x80);
}

void lda_const(int value) {

	A=value;

	Z=(A==0);
	N=!!(A&0x80);
}

void ldx(int addr) {

	X=ram[addr];

	Z=(X==0);
	N=!!(X&0x80);
}

void ldx_const(int value) {

	X=value;

	Z=(X==0);
	N=!!(X&0x80);
}

void ldy(int addr) {

	Y=ram[addr];

	Z=(Y==0);
	N=!!(Y&0x80);
}

void ldy_const(int value) {

	Y=value;

	Z=(Y==0);
	N=!!(Y&0x80);
}

void sta(int addr) {

	ram[addr]=A;
}

void tax(void) {
	X=A;
}

void txa(void) {
	A=X;
}

void eor(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=value&0xff;

	result=(temp_a^temp_value);

	N=(result&0x80)>>7;

	A=result&0xff;
	Z=(A==0);

}

void ora(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=value&0xff;

	result=(temp_a|temp_value);

	N=(result&0x80)>>7;

	A=result&0xff;
	Z=(A==0);

}

void ora_mem(int addr) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=ram[addr]&0xff;

	result=(temp_a|temp_value);

	N=(result&0x80)>>7;

	A=result&0xff;
	Z=(A==0);

}

void and(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=A&0xff;
	temp_value=value&0xff;

	result=(temp_a&temp_value);

	N=(result&0x80)>>7;

	A=result&0xff;
	Z=(A==0);

}



unsigned char high(int value) {
	return (value>>8)&0xff;
}

unsigned char low(int value) {
	return (value&0xff);
}

