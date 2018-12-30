; Lo-res fire animation, size-optimized

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

; 611 bytes at first
; 601 bytes -- strip out some unused code
; 592 bytes -- don't init screen
; 443 bytes -- remove more dead code
; 206 bytes -- no need to clear screen
; 193 bytes -- un-cycle exact the random16 code
; 189 bytes -- more optimization of random16 code
; 161 bytes -- move to 8-bit RNG
; 152 bytes -- reduce lookup to top half colors (had to remove brown)
;		also changed maroon to pink
; 149 bytes -- use monitor GR

; Zero Page
SEEDL		= $4E
TEMP		= $00
TEMPY		= $01

; 100 = $64

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
LORES	= $C056	; Enable LORES graphics

; monitor routines
GR	=	$F390

fire_demo:

	; GR part
	jsr	GR							; 3
	bit	FULLGR							; 3
								;==========
								;         6


	; Setup white line on bottom

	lda	#$ff							; 2
	ldx	#39							; 2
white_loop:
	sta	$7d0,X			; hline 24 (46+47)		; 3
	dex								; 1
	bpl	white_loop						; 2
								;============
								;        10

fire_loop:

	ldy	#44			; 22 * 2

yloop:

	lda	gr_offsets,Y
	sta	smc2+1
	lda	gr_offsets+1,Y
	sta	smc2+2
	lda	gr_offsets+2,Y
	sta	smc1+1
	lda	gr_offsets+3,Y
	sta	smc1+2

	sty	TEMPY

	ldx	#39
xloop:
smc1:
	lda	$7d0,X
	sta	TEMP
	and	#$7		; mask off
	tay

	;=============================
	; random8
	;=============================
	; 8-bit 6502 Random Number Generator
	; Linear feedback shift register PRNG by White Flame
	; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
	lda	SEEDL
	beq	doEor
	asl
	beq	noEor	; if the input was $80, skip the EOR
	bcc	noEor
doEor:	eor	#$1d
noEor:	sta	SEEDL

	; end inlined RNG

	and	#$1
	beq	no_change

decrement:
	lda	color_progression,Y
	jmp	done_change
no_change:
	lda	TEMP
done_change:

smc2:
	sta	$750,X
	dex
	bpl	xloop

	ldy	TEMPY

	dey
	dey
	bpl	yloop

	bmi	fire_loop


color_progression:
	.byte	$00	; 8->0		; 1000 0101
	.byte	$bb	; 9->11		; 1001 0001
	.byte	0	; 10->0		; 1010 0000
	.byte	$aa	; 11->10	; 1011 0000
	.byte	0	; 12->0		; 1100 0000
	.byte	$99	; 13->9		; 1101 1001
	.byte	$00	; 14->0		; 1110 0000
	.byte	$dd	; 15->13	; 1111 1101

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

