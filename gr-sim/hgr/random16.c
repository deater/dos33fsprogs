#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "6502_emulate.h"
#include "gr-sim.h"


#define SEEDL 0x4e
#define SEEDH 0x4f

#define MAGIC "vW"	// $7657

static int cycles=0;
static int path=0;

#define PATH_R16	1
#define PATH_LNZ	2
#define PATH_LOZ	4
#define PATH_NEO	8
#define PATH_DEO	16
#define PATH_CEO	32
#define PATH_CEP	64

/* based on Linear feedback shift register type of PRNG by White Flame	*/
/*	http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng	*/
unsigned short random16(void) {

	path=0;

	path|=PATH_R16;

	lda(SEEDL);	cycles+=3;
	if (a==0) {
		cycles+=3;
		goto low_zero;
	}
	cycles+=2;

//lownz:
	path|=PATH_LNZ;
	asl_mem(SEEDL);	cycles+=5;
	lda(SEEDH);	cycles+=3;
	rol();		cycles+=2;
	if (c==1) {
		cycles+=3;
		goto five_cycle_do_eor;
	}
	cycles+=2;
	if (c==0) {
		cycles+=3;
		goto two_cycle_no_eor;
	}
	fprintf(stderr,"CAN'T HAPPEN\n");

eleven_cycle_do_eor:
	cycles+=6;
five_cycle_do_eor:
	cycles+=2;
three_cycle_do_eor:
	sta(SEEDH);	cycles+=3;

//do_eor:
	path|=PATH_DEO;
	a=a^0x76;	cycles+=2;
	sta(SEEDH);	cycles+=3;
	lda(SEEDL);	cycles+=3;
	a=a^0x57;	cycles+=2;
	sta(SEEDL);	cycles+=3;
eor_rts:
	cycles+=6;
	return ((ram[SEEDH]<<8)|ram[SEEDL]);

six_cycles_no_eor:
	cycles+=2;
four_cycle_no_eor:
	cycles+=2;
two_cycle_no_eor:
	cycles+=2;
//no_eor:
	cycles+=2;
	path|=PATH_NEO;
	cycles+=6;
	sta(SEEDH);	cycles+=3;
	cycles+=3;
	goto	eor_rts;



low_zero:
	path|=PATH_LOZ;
	lda(SEEDH);	cycles+=3;
	if (a==0) {
		cycles+=3;
		goto eleven_cycle_do_eor;
	}
	cycles+=2;

//ceo:
	path|=PATH_CEO;
	asl();	cycles+=2;
	if (a==0) {
		cycles+=3;
		goto six_cycles_no_eor;
	}
	cycles+=2;

//cep:
	path|=PATH_CEP;
	if (c==0) {
		cycles+=3;
		goto four_cycle_no_eor;
	}
	cycles+=2;
	if (c==1) {
		cycles+=3;
		goto three_cycle_do_eor;
	}
	cycles+=2;

	return 0;
}

static int results[65536];


int main(int argc, char **argv) {
	int i,x;
	int errors=0;

	memset(results,0,65536*sizeof(int));

	for(i=0;i<65536*2;i++) {
		cycles=0;
		x=random16();
		results[x]++;
		if (cycles!=42) {
			fprintf(stderr,"Error!  Cycles=%d Path=%x\n",
				cycles,path);
			errors++;
		}
	}

	for(i=0;i<65536;i++) {
		if (results[i]!=2) printf("%d: %d\n",i,results[i]);
	}

	printf("Errors: %d\n",errors);

	return 0;
}
