#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "6502_emulate.h"

/* 128kB of RAM */
#define RAMSIZE 128*1024
unsigned char ram[RAMSIZE];

/* Registers */
unsigned char a,y,x;
unsigned short sp;

/* Flags */
unsigned int n,z,c,v;

int init_6502(void) {

	a=0;
	y=0;
	x=0;

	sp=0x1ff;

	n=0; z=0; c=0; v=0;

	return 0;

}

unsigned short y_indirect(unsigned char base, unsigned char y) {

	unsigned short addr;

	addr=(((short)(ram[base+1]))<<8) | (short)ram[base];

	//if (debug) printf("Address=%x\n",addr+y);

	return addr+y;

}

void adc(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=a&0xff;
	temp_value=value&0xff;

	result=(temp_a+temp_value+c);

	c=(result&0x100)>>8;
	n=(result&0x80)>>7;

	v=!!((a^result)&(value^result)&0x80);

	a=result&0xff;
	z=(a==0);

}

void sbc(int value) {
	int temp_a;
	int result;
	int temp_value;

	temp_a=a&0xff;
	temp_value=(~value)&0xff;

	result=temp_a+temp_value+c;

//	printf("SBC: %x - %x (%x) = %x\n",a,value,c,result);

	c=(result&0x100)>>8;
	n=(result&0x80)>>7;

	v=!!((a^result)&((255-value)^result)&0x80);

	a=result&0xff;
	z=(a==0);


}

void cmp(int value) {

	int temp_a;
	int temp_value;
	int result;

	temp_a=a&0xff;
	temp_value=(~value)&0xff;

	result=temp_a+temp_value+1;

	c=(result&0x100)>>8;

	result&=0xff;

	n=(result&0x80)>>7;
	z=(result==0);
}

void cpy(int value) {

	int temp_y;
	int temp_value;
	int result;

	temp_y=y&0xff;
	temp_value=(~value)&0xff;

	result=temp_y+temp_value+1;

	c=(result&0x100)>>8;

	result&=0xff;

	n=(result&0x80)>>7;
	z=(result==0);
}

void cpx(int value) {

	int temp_x;
	int temp_value;
	int result;

	temp_x=x&0xff;
	temp_value=(~value)&0xff;

	result=temp_x+temp_value+1;

	c=(result&0x100)>>8;

	result&=0xff;

	n=(result&0x80)>>7;
	z=(result==0);
}


void pha(void) {

	sp--;
	ram[sp]=a;
}

void pla(void) {

	a=ram[sp];
	sp++;
}

void lsr(void) {
	int temp_a;

	temp_a=a;
	temp_a&=0xff;

	c=temp_a&0x1;
	temp_a=temp_a>>1;
	a=(temp_a&0xff);
	z=(a==0);
	n=!!(a&0x80);
//	printf("LSR A=%x\n",a);
}

void asl(void) {
	int temp_a;

	temp_a=a;
	temp_a&=0xff;

	c=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	a=(temp_a&0xff);
	z=(a==0);
	n=!!(a&0x80);
//	printf("ASL A=%x\n",a);
}

void asl_mem(int addr) {
	int temp_a;

	temp_a=ram[addr];
	temp_a&=0xff;

	c=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	ram[addr]=(temp_a&0xff);
	z=(ram[addr]==0);
	n=!!(ram[addr]&0x80);
//	printf("ASL %x=%x\n",addr,ram[addr]);
}


void ror(void) {
	int temp_a;
	int old_c;

	old_c=c;
	temp_a=a;
	temp_a&=0xff;

	c=temp_a&0x1;
	temp_a=temp_a>>1;
	a=(temp_a&0xff);
	a|=old_c<<7;

	z=(a==0);
	n=!!(a&0x80);
//	printf("ROR A=%x\n",a);
}

void rol(void) {
	int temp_a;
	int old_c;

	old_c=c;
	temp_a=a;
	temp_a&=0xff;

	c=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	a=(temp_a&0xff);
	a|=old_c;

	z=(a==0);
	n=!!(a&0x80);
//	printf("ROL A=%x\n",a);
}



void ror_mem(int addr) {
	int temp_a;
	int old_c;

	old_c=c;
	temp_a=ram[addr];
	temp_a&=0xff;

	c=temp_a&0x1;
	temp_a=temp_a>>1;
	ram[addr]=(temp_a&0xff);
	ram[addr]|=old_c<<7;

	z=(ram[addr]==0);
	n=!!(ram[addr]&0x80);
//	printf("ROR %x=%x\n",addr,ram[addr]);
}

void rol_mem(int addr) {
	int temp_a;
	int old_c;

	old_c=c;
	temp_a=ram[addr];
	temp_a&=0xff;

	c=!!(temp_a&0x80);

	temp_a=temp_a<<1;
	ram[addr]=(temp_a&0xff);
	ram[addr]|=old_c;

	z=(ram[addr]==0);
	n=!!(ram[addr]&0x80);
//	printf("ROL %x=%x\n",addr,ram[addr]);
}


void dex(void) {
	x--;

	z=(x==0);
	n=!!(x&0x80);
}

void dey(void) {
	y--;

	z=(y==0);
	n=!!(y&0x80);
}

void inx(void) {
	x++;

	z=(x==0);
	n=!!(x&0x80);
}

void iny(void) {
	y++;

	z=(y==0);
	n=!!(y&0x80);
}

void bit(int value) {
	int temp_a;

	temp_a=a&value;
	temp_a&=0xff;

	z=(temp_a==0);

	n=(value&0x80);
	v=(value&0x40);

}

void lda(int addr) {

	a=ram[addr];

	z=(a==0);
	n=!!(a&0x80);
}

void lda_const(int value) {

	a=value;

	z=(a==0);
	n=!!(a&0x80);
}

void ldx(int addr) {

	x=ram[addr];

	z=(x==0);
	n=!!(x&0x80);
}

void ldx_const(int value) {

	x=value;

	z=(x==0);
	n=!!(x&0x80);
}

void ldy(int addr) {

	y=ram[addr];

	z=(y==0);
	n=!!(y&0x80);
}

void ldy_const(int value) {

	y=value;

	z=(y==0);
	n=!!(y&0x80);
}

unsigned char high(int value) {
	return (value>>8)&0xff;
}

unsigned char low(int value) {
	return (value&0xff);
}

