#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "6502_emulate.h"

/* 128kB of RAM */
#define RAMSIZE 128*1024
unsigned char ram[RAMSIZE];

/* Registers */
unsigned char a,y,x;

unsigned short y_indirect(unsigned char base, unsigned char y) {

	unsigned short addr;

	addr=(((short)(ram[base+1]))<<8) | (short)ram[base];

	//if (debug) printf("Address=%x\n",addr+y);

	return addr+y;

}

