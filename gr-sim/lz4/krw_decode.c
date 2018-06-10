#include <stdio.h>
#include <string.h>

#include "6502_emulate.h"

#define MAX_INPUT	65536
static unsigned char input[MAX_INPUT];

#define LZ4_BUFFER	0x2000
#define ORGOFFSET	0x6000
#define end	0x4

#define LZ4_SRC 0x00
#define LZ4_DST 0x02
#define LZ4_END 0x04
#define COUNT   0x06
#define DELTA   0x08


#define CH	0x24
#define CV	0x25

#define	OUTL	0xFE
#define OUTH	0xFF

static int cycles;

static void getsrc(void) {
//getsrc:
	a=ram[y_indirect(LZ4_SRC,y)];	cycles+=5;	// lda 	(LZ4_SRC), y
	ram[LZ4_SRC]++;			cycles+=5;	//inc	LZ4_SRC
					cycles+=2;
	if (ram[LZ4_SRC]!=0) {
					cycles+=1;
		goto done_getsrc;			//bne	+
	}
	ram[LZ4_SRC+1]++;		cycles+=5;	//inc	LZ4_SRC+1
done_getsrc:
	cycles+=6;
	//+	rts
}

void buildcount(void) {
//buildcount:
	x=1;		cycles+=2;		// ??		// ldx	#1
	ram[COUNT+1]=x; cycles+=3;		// ??		// stx	COUNT+1
	cmp(0xf);	cycles+=2;		// if 15, more complicated // cmp	#$0f
	cycles+=2;
	if (z==0) {
		cycles+=1;
		goto done_buildcount;		// otherwise A is count // bne	++
	}
buildcount_loop:
	ram[COUNT]=a;	cycles+=3;		//-	sta	count
	getsrc();	cycles+=6;		//jsr	getsrc
	x=a;		cycles+=2;		//tax
	c=0;		cycles+=2;		//clc
	adc(ram[COUNT]);cycles+=3;		//adc	COUNT
	cycles+=2;
	if (c==0) {
		cycles+=1;
		goto skip_buildcount;		// bcc	+
	}
	ram[COUNT+1]++;	cycles+=5;		//inc	COUNT+1
skip_buildcount:
	x++;		cycles+=2;		// check if x is 255	//+	inx
	if (x==0) {
		cycles+=1;
		goto buildcount_loop;		// if so, add in next byte //beq	-
	}
done_buildcount:
	cycles+=6;				//++	rts

}


static void putdst(void) {
							// putdst:
	ram[y_indirect(LZ4_DST,y)]=a; cycles+=6;	//	sta 	(LZ4_DST), y
	ram[LZ4_DST]++;		cycles+=5;		//	inc	LZ4_DST
	cycles+=2;
	if (ram[LZ4_DST]!=0) {
		cycles+=1;
		goto putdst_end;			//	bne	+
	}
	ram[LZ4_DST+1]++;	cycles+=5;		//	inc	LZ4_DST+1
putdst_end:;
	cycles+=6;					//+	rts

}

static void getput(void) {
						// getput:

	getsrc();				// jsr	getsrc
	cycles+=6;
	putdst();				// ; fallthrough
}


static void docopy(void) {
						// docopy:
docopy_label:
	getput();	cycles+=6;		// jsr	getput
	x--;		cycles+=2;		// dex
	cycles+=2;
	if (x!=0) {
		cycles+=1;
		goto docopy_label;		// bne	docopy
	}
	ram[COUNT+1]--;		cycles+=5;	// dec	COUNT+1
	cycles+=2;
	if (ram[COUNT+1]!=0) {
		cycles++;
		goto docopy_label;	//bne	docopy
	}
	cycles+=6;
						//rts
}


#define orgoff	0x6000


int lz4_decode(void) {

	FILE *fff;

	cycles=0;

	//LZ4 data decompressor for Apple II
	//Peter Ferrie (peter.ferrie@gmail.com)
// lz4_decode:

	a=ram[LZ4_SRC];		cycles+=3;	// lda     LZ4_SRC
	c=0;			cycles+=2;	// clc
	adc(ram[LZ4_END]);	cycles+=3;	// adc     LZ4_END
	ram[LZ4_END]=a;		cycles+=3;	// sta     LZ4_END
        a=ram[LZ4_SRC+1];	cycles+=3;	// lda     LZ4_SRC+1
	adc(ram[LZ4_END+1]);	cycles+=3;	// adc     LZ4_END+1
	ram[LZ4_END+1]=a;	cycles+=3;	// sta     LZ4_END+1

	a=high(orgoff);		cycles+=2;	// lda     #>orgoff                ; original unpacked data offset
        ram[LZ4_DST+1]=a;	cycles+=3;	// sta     LZ4_DST+1
	a=low(orgoff);		cycles+=2;	// lda     #<orgoff
	ram[LZ4_DST]=a;		cycles+=3;	// sta     LZ4_DST

//	printf("packed size: raw=%x, adj=%x\n",size,paksize);
	printf("packed addr: %02X%02X\n",ram[LZ4_SRC+1],ram[LZ4_SRC]);
	printf("packed end : %02X%02X\n",ram[end+1],ram[end]);
	printf("dest addr  : %02X%02X\n",ram[LZ4_DST+1],ram[LZ4_DST]);

//unpmain:
	y=0;		cycles+=2;	// used for offset	//ldy	#0

parsetoken:
	getsrc();	cycles+=6;	// jsr	getsrc
					// get token
	pha();		cycles+=3;	// save for later	// pha
	lsr();		cycles+=2;	// num literals in top 4// lsr
	lsr();		cycles+=2;				// lsr
	lsr();		cycles+=2;				// lsr
	lsr();		cycles+=2;				// lsr
	cycles+=2;
	if (a==0) {
		cycles+=1;
		goto copymatches; 	// if zero, no literals // beq	copymatches
	}

	buildcount();	cycles+=6;	// otherwise, build the count // jsr	buildcount

	x=a;			cycles+=2;	// tax
	docopy();		cycles+=6;	// jsr	docopy
	a=ram[LZ4_SRC];		cycles+=3;	// lda	LZ4_SRC
	cmp(ram[end]);		cycles+=3;	// cmp	end
	a=ram[LZ4_SRC+1];	cycles+=3;	// lda	LZ4_SRC+1

	sbc(ram[end+1]);	cycles+=3;	// sbc	end+1
	cycles+=2;
	if (c) {
		printf("Done!\n");
		printf("src        : %02X%02X\n",ram[LZ4_SRC+1],ram[LZ4_SRC]);
		printf("packed end : %02X%02X\n",ram[end+1],ram[end]);
		cycles+=1;
		goto done;		// bcs	done
	}

copymatches:
	getsrc();		cycles+=6;	// jsr	getsrc
	ram[DELTA]=a;		cycles+=3;	// sta	DELTA
	getsrc();		cycles+=6;	// jsr	getsrc
	ram[DELTA+1]=a;		cycles+=3;	// sta	DELTA+1
	pla();			cycles+=3;	// restore token	// pla
	a=a&0xf;		cycles+=2;	// get bottom 4 bits	// and	#$0f
	buildcount();		cycles+=6;	// jsr	buildcount

	c=0;			cycles+=2;	// clc
	adc(4);			cycles+=2;	// adc	#4
	x=a;			cycles+=2;	// tax
	cycles+=2;
	if (x==0) {
		cycles+=1;
		goto copy_skip;	//BUGFIX // beq  +
	}
	cycles+=2;
	if (c==0) {
		cycles+=1;
		goto copy_skip;	// bcc	+
	}
	ram[COUNT+1]++;		cycles+=5;	// inc	count+1
copy_skip:
	a=ram[LZ4_SRC+1];	cycles+=3;	//+	lda	src+1
	pha();			cycles+=3;	// pha
	a=ram[LZ4_SRC];		cycles+=3;	// lda	src
	pha();			cycles+=3;	// pha
	c=1;			cycles+=2;	// sec
	a=ram[LZ4_DST];		cycles+=3;	// lda	LZ4_DST
	sbc(ram[DELTA]);	cycles+=3;	// sbc	DELTA
	ram[LZ4_SRC]=a;		cycles+=3;	// sta	LZ4_SRC
	a=ram[LZ4_DST+1];	cycles+=3;	// lda	LZ4_DST+1
	sbc(ram[DELTA+1]);	cycles+=3;	// sbc	DELTA+1
	ram[LZ4_SRC+1]=a;	cycles+=3;	// sta	LZ4_SRC+1

	docopy();		cycles+=6;	// jsr	docopy
	pla();			cycles+=3;	// pla
	ram[LZ4_SRC]=a;		cycles+=3;	// sta	LZ4_SRC
	pla();			cycles+=3;	// pla
	ram[LZ4_SRC+1]=a;	cycles+=3;	// sta	LZ4_SRC+1
	cycles+=3;
	goto parsetoken;		// jmp	parsetoken

done:
	cycles+=3;
	pla();				// pla
	cycles+=6;			// rts

	int out_size=(ram[LZ4_DST+1]<<8)+ram[LZ4_DST];
	out_size-=ORGOFFSET;

	printf("dest addr  : %02X%02X\n",ram[LZ4_DST+1],ram[LZ4_DST]);

	fff=fopen("out.out","w");
	if (fff==NULL) {
		fprintf(stderr,"Error opening!\n");
		return -1;
	}

	printf("Out size=%d\n",out_size);

	fwrite(&ram[ORGOFFSET],1,out_size,fff);

	fclose(fff);

	printf("Cycles: %d\t %lfs\n",cycles,(double)cycles/1023000.0);
	printf("\t50Hz\t %lfs\n",(double)1/50.0);

	return 0;
}

static void print_both_pages(void) {
	int i;

	for(i=0;i<ram[CH];i++) printf(" ");

	y=0;

	while(1) {
		a=ram[y_indirect(OUTL,y)];
		if (a==0) break;
		printf("%c",a);
		y++;
	}
	printf("\n");
}


static void print_header_info(void) {

	ram[CV]=a;

	y++;
	a=y;
	y=0;
	c=0;
	adc(ram[OUTL]);
	ram[OUTL]=a;
	a=ram[OUTH];
	adc(0);
	ram[OUTH]=a;

	a=ram[y_indirect(OUTL,y)];
	ram[CH]=a;

	ram[OUTL]++;
	if (ram[OUTL]==0) ram[OUTH]++;

	print_both_pages();
}

int main(int argc, char **argv) {

	FILE *fff;
	int size;

	init_6502();

	if (argc<2) {
		fprintf(stderr,"\nUsage: %s filename\n\n",argv[0]);
	}

	fff=fopen(argv[1],"r");
	if (fff==NULL) {
		fprintf(stderr,"Error opening %s!\n",argv[1]);
		return -1;
	}

	size=fread(input,sizeof(unsigned char),MAX_INPUT,fff);
	printf("Read %d bytes\n",size);

	fclose(fff);

	memcpy(&ram[LZ4_BUFFER],input,size);

	a=high(LZ4_BUFFER);
	ram[OUTH]=a;
	a=low(LZ4_BUFFER);
	ram[OUTL]=a;

	y=3;

	a=20;
	print_header_info();

	a=21;
	print_header_info();
	printf("\n");

	a=23;
	print_header_info();

	y=0;
	a=high(LZ4_BUFFER+3);
	ram[LZ4_SRC+1]=a;
	a=low(LZ4_BUFFER+3);
	ram[LZ4_SRC]=a;

	a=ram[y_indirect(LZ4_SRC,y)];
	c=0;
	adc(ram[LZ4_SRC]);
	ram[LZ4_SRC]=a;
	a=ram[LZ4_SRC+1];
	adc(0);
	ram[LZ4_SRC+1]=a;

// next_subsong:

	y=0;

	a=ram[y_indirect(LZ4_SRC,y)];
	ram[LZ4_END]=a;
	y++;
	a=ram[y_indirect(LZ4_SRC,y)];
	ram[LZ4_END+1]=a;
	y++;

	a=2;
	c=0;
	adc(ram[LZ4_SRC]);
	ram[LZ4_SRC]=a;
	a=(ram[LZ4_SRC+1]);
	adc(0);
	ram[LZ4_SRC+1]=a;

	lz4_decode();

	return 0;
}

