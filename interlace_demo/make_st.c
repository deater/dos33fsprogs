#include <stdio.h>


static int gr_offsets[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

#define X_OFFSET	0

int main(int argc, char **argv) {

	int i,j,lookup,address;

	for(i=0;i<96;i++) {
		lookup=i/4;

		printf("; %d\n",i*2);
		printf("\tbit\tPAGE0\t; 4\n");
		printf("smc%03d:\tldx\t#$00\t; 2\n",i*2);
		for(j=0;j<7;j++) {
			address=gr_offsets[lookup]+0x400+j+X_OFFSET;
			if (i<15) address=0xc00;
			if (i>77) address=0xc00;
			printf("\tlda\t#$00\t; 2\n");
			printf("\tsta\t$%3x,X\t; 5\n",address);
		}
		printf("\tldx\t#$00\t; 2\n");
		printf("\tlda\tZERO\t; 3\n");
		address=gr_offsets[lookup]+0x400+X_OFFSET;
		if (i<15) address=0xc00;
		if (i>77) address=0xc00;
		printf("\tsta\t$%3x,X\t; 5\n",address);
		printf("\n");

#if 0
							; 4
	lda     #$00    ; 2	ldx	#$5		; 2	; 6
        sta     $500    ; 4	lda	#0		; 2	; 10
        lda     #$00    ; 2	sta	$500,X		; 5	; 13
        sta     $501    ; 4	lda	#1		; 2	; 15
        lda     #$00    ; 2	sta	$501,X		; 5	; 20
        sta     $502    ; 4	lda	#2		; 2	; 22
        lda     #$00    ; 2	sta	$502,X		; 5	; 27
        sta     $503    ; 4	lda	#3		; 2	; 29
        lda     #$00    ; 2	sta	$503,X		; 5	; 34
        sta     $504    ; 4	lda	#4		; 2	; 36
        lda     #$00    ; 2	sta	$504,X		; 5	; 41
        sta     $505    ; 4	lda	#5		; 2	; 43
        lda     #$00    ; 2	sta	$505,X		; 5	; 48
        sta     $506    ; 4	lda	#6		; 2	; 50
        lda     #$00    ; 2	sta	$506,X		; 5	; 55
        sta     $507    ; 4	
        lda     #$00    ; 2	
        sta     $508    ; 4	ldx	#$10		; 2	; 57
        bit     krg     ; 4	lda	ZP		; 3	; 60
        lda     TEMP    ; 3	sta	$500,X		; 5	; 65
#endif




		lookup=i/4;
		if (i%4==3) lookup=(i+4)/4;
		if (i==95) lookup=0;


		printf("; %d\n",(i*2)+1);
		printf("\tbit\tPAGE1\t; 4\n");
		printf("smc%03d:\tldx\t#$00\t; 2\n",(i*2)+1);
		for(j=0;j<7;j++) {
			address=gr_offsets[lookup]+j+X_OFFSET;
			if (i<15) address=0xc00;
			if (i>77) address=0xc00;
			printf("\tlda\t#$00\t; 2\n");
			printf("\tsta\t$%3x,X\t; 5\n",address);
		}
		printf("\tldx\t#$00\t; 2\n");
		printf("\tlda\tZERO\t; 3\n");
		address=gr_offsets[lookup]+X_OFFSET;
		if (i<15) address=0xc00;
		if (i>77) address=0xc00;
		printf("\tsta\t$%3x,X\t; 5\n",address);
		printf("\n");
	}

#if 0
	printf("y_lookup_h:\n");
	for(i=32;i<32+128;i++) {
		if (i%8==0) printf(".byte\t");
		printf(">(smc%03d+1)",i);
		if (i%8!=7) printf(",");
		else printf("\n");
	}

	printf("y_lookup_l:\n");
	for(i=32;i<32+128;i++) {
		if (i%8==0) printf(".byte\t");
		printf("<(smc%03d+1)",i);
		if (i%8!=7) printf(",");
		else printf("\n");
	}
#endif
	return 0;
}
