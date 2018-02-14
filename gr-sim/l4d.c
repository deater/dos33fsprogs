#include <stdio.h>
#include <string.h>

#include "gr-sim.h"

#define MAX_INPUT	65536
static unsigned char input[MAX_INPUT];

#define src	0x0
#define dst	0x2
#define end	0x4
#define count	0x6
#define delta	0x8
#define A1L	0x3c
#define A1H	0x3d
#define A2L	0x3e
#define A2H	0x3f
#define A4L	0x42
#define A4H	0x43

static short s;

void getsrc(void) {
//getsrc:
	a=ram[y_indirect(src,y)];		// lda 	(src), y
	ram[src]++;				//inc	src
	if (ram[src]!=0) goto done_getsrc;	//bne	+
	ram[src+1]++;				//inc	src+1
done_getsrc: ;
	//+	rts
}

static void pha(void) {

	s--;
	ram[s]=a;
}

static void pla(void) {

	a=ram[s];
	s++;
}

void buildcount(void) {

	int cnew,c;

//buildcount:
	x=1;					// ldx	#1
	ram[count+1]=x; 			//stx	count+1
	if (a!=0xf) goto done_buildcount;	//cmp	#$0f
						//bne	++
minus_buildcount:
	ram[count]=a;				//-	sta	count
	getsrc();				//jsr	getsrc
	x=a;					//tax
	c=0;					//clc
	cnew=(a+ram[count]+c)>0xff;
	a=a+ram[count]+c;			//adc	count
	if (cnew) goto skip_buildcount;		// bcc	+
	ram[count+1]++;				//inc	count+1
skip_buildcount:
	x++;					//+	inx
	x&=0xf;
	if (x==0) goto minus_buildcount;	//beq	-
done_buildcount: ;				//++	rts
}

int main(int argc, char **argv) {

	FILE *fff;
	int size;
	short orgoff,paksize,pakoff;

	fff=fopen("../mockingboard/outi.raw.lz4","r");
	if (fff==NULL) {
		fprintf(stderr,"Error opening!\n");
		return -1;
	}

	size=fread(input,sizeof(unsigned char),MAX_INPUT,fff);
	printf("Read %d bytes\n",size);

	fclose(fff);

	memcpy(&ram[0x2000],input,size);

	s=0x1ff;

	//LZ4 data decompressor for Apple II
	//Peter Ferrie (peter.ferrie@gmail.com)

	//init	=	0 ;set to 1 if you know the values
	//hiunp	=	0 ;unpacker entirely in high memory
	//hipak	=	0 ;packed data entirely in high memory (requires hiunp)

	//oep = 0; //first unpacked byte to run, you must set this by yourself
	orgoff = 0x8000; //offset of first unpacked byte, you must set this by yourself
	paksize	= size; //size of packed data, you must set this by yourself if hiunp=0
	pakoff = 0x2000;


//LCBANK2	=	$c083
//MOVE	=	$fe2c

	a=(pakoff&0xff);	//lda	#<pakoff ;packed data offset
	ram[src]=a;		//sta	src
	a=(pakoff+paksize)&0xff;//lda	#<(pakoff+paksize) ;packed data size
	ram[end]=a;		// sta	end
	a=(pakoff>>8);		//lda	#>pakoff
	ram[src+1]=a;		//sta	src+1
	a=(pakoff+paksize)>>8;	//lda	#>(pakoff+paksize)
	ram[end+1]=a;		//	sta	end+1
	a=(orgoff>>8);		//lda	#>orgoff ;original unpacked data offset
	ram[dst+1]=a;		//sta	dst+1
	a=(orgoff&0xff);	//lda	#<orgoff
	ram[dst]=a;		// sta	dst

unpack:				//;unpacker entrypoint
	goto unpmain;		//	jmp	unpmain

unpmain:
	y=0;			//ldy	#0

parsetoken:
	getsrc();		// jsr	getsrc
	pha();			// pha
	a<<=1;			// lsr
	a<<=1;			// lsr
	a<<=1;			// lsr
	a<<=1;			// lsr
	a&=0xff;
	if (a==0) goto copymatches; //beq	copymatches
#if 0
	jsr	buildcount
	tax
	jsr	docopy
	lda	src
	cmp	end
	lda	src+1
	sbc	end+1
	bcs	done
#endif
copymatches:
	getsrc();		//jsr	getsrc
#if 0
	sta	delta
	jsr	getsrc
	sta	delta+1
	pla
	and	#$0f
	jsr	buildcount
	clc
	adc	#4
	tax
	bcc	+
	inc	count+1
+	lda	src+1
	pha
	lda	src
	pha
	sec
	lda	dst
	sbc	delta
	sta	src
	lda	dst+1
	sbc	delta+1
	sta	src+1
	jsr	docopy
	pla
	sta	src
	pla
	sta	src+1
	jmp	parsetoken

done
	pla
	rts

docopy
	jsr	getput
	dex
	bne	docopy
	dec	count+1
	bne	docopy
	rts



getput
	jsr	getsrc

putdst
	sta 	(dst), y
	inc	dst
	bne	+
	inc	dst+1
+	rts

#endif

	return 0;
}
