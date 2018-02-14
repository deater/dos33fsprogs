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

	temp_a=a&0xff;
	temp_value=value&0xff;
	temp_a=temp_a-temp_value;
	c=(temp_a&0x100)>>8;
	n=(temp_a&0x80)>>7;
	z=(a==0);
}

void pha(void) {

	sp--;
	ram[sp]=a;
}

void pla(void) {

	a=ram[sp];
	sp++;
}
