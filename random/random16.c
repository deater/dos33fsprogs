#include <stdio.h>

// 16-bit 6502 Random Number Generator

// Linear feedback shift register PRNG by White Flame
// http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

// The Apple II KEYIN routine increments this field
//while waiting for keypress

//SEEDL = $4E
//SEEDH = $4F

//XOR_MAGIC = $7657	; "vW"

static unsigned short xor_magic=0x7657;
//static unsigned short xor_magic=0x002d;
static unsigned short seed=0x0000;

//	;=============================
//	; random16
//	;=============================

unsigned short random16(void) {

	if ((seed&0xff)!=0) {
		if ((seed&0x8000)==0) {
			// noEor
			seed<<=1;
			return seed;
		}
		else {
			// doEor
			seed<<=1;
			seed=seed^xor_magic;
			return seed;
		}
	}
	else {
		// if bottom 0
		if (((seed>>8)&0xff)==0) {
			seed<<=1;
			seed=seed^xor_magic;
			return seed;
		}

		else {
			if ((seed & 0x8000)==0) {
				seed<<=1;
				return seed;
			}
			else {
				seed<<=1;
				seed=seed^xor_magic;
				return seed;
			}
		}

	}
}

int main(int argc, char **argv) {

	int i,r;

	for(i=0;i<65537;i++) {
		r=random16();
		printf("%04hx %04hx\n",r,r&0x1f);
	}

	return 0;
}
//	lda	SEEDL							; 3
//	beq	lowZero		; $0000 and $8000 are special values	; 2

//	asl	SEEDL		; Do a normal shift			; 5
//	lda	SEEDH							; 3
//	rol								; 2
//	bcc	noEor							; 2

//doEor:
//				; high byte is in A


//	eor	#>XOR_MAGIC						; 2
//	sta	SEEDH							; 3
//	lda	SEEDL							; 3
//	eor	#<XOR_MAGIC						; 2
//	sta	SEEDL							; 3
//	rts								; 6

//lowZero:
//									; 1
//	lda	SEEDH							; 3
//	beq	doEor		; High byte is also zero		; 3
//				; so apply the EOR
//									; -1
//				; wasn't zero, check for $8000
//	asl								; 2
//	beq	noEor		; if $00 is left after the shift	; 2
//				; then it was $80
//	bcs	doEor		; else, do the EOR based on the carry	; 3

//noEor:
//									; 1
//	sta	SEEDH							; 3

//	lda	SEEDL	; always return SEEDL
//	rts								; 6
