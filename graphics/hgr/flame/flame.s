; flames -- Apple II Hires

; 158 bytes -- original
; 163 bytes -- limit to part of screen for frame rate
; 155 bytes -- inline functions
; 147 bytes -- rip out broken wind support
; 146 bytes -- move jmp to branch-always
; 135 bytes -- use (GBASL) instead of self-modifying
; 147 bytes -- use larger pool of random numbers
; 142 bytes -- use (BASL),Y addressing instead of self-modifying code
; 140 bytes -- use high bit for randomness

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

BASL		= $24
BASH		= $25

GBASL		= $26
GBASH		= $27

HGR_X		= $E0

; soft-switches

PAGE1		= $C054

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR             = $F3E2         ; set hires page1 and clear $2000-$3fff
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

flamees:

	;==================================================
	; clear both graphics screens, set to display page1

	jsr	HGR
	jsr	HGR2
	bit	PAGE1		; display page1 while leaving $E6 set to page2

	;=============================================
	; setup (draw white line at bottom of screen)

	ldx	#39
	lda	#$f
white_line_loop:
	sta	$5FD0,X
	dex
	bpl	white_line_loop


	;====================
	;====================
	; main loop
	;====================
	;====================



fire_loop:

	; first time through loop, X = FF
	; other times through loop, X = 192


	;====================
	; move fire
	;====================
move_fire:
	ldx	#191		; start at bottom of screen
burn_loop:
	txa
	jsr	HPOSN		; puts addr of line in A into GBASL:GBASH

	lda	GBASL		; put the line address into input
	sta	BASL
	lda	GBASH
	sta	BASH

	; input now in GBASL:GBASH

	ldx	HGR_X		; restore X
	dex			; point to line above
	txa			; put in A
	jsr	HPOSN		; put addr of line in A into GBASL:GBASH

	; output now in GBASL:GBASH

	ldy	#39		; 39 columns across screen
burn_inner:

random_smc:
	lda	$E000		; our "RANDOM" numbers

;	and	#$1
;	bne	dont_invert_dex

	bpl	dont_invert_dex	; is top bit random enough?

	lda	dex_smc
	eor	#$20
	sta	dex_smc

dont_invert_dex:

;burn_in_smc:
	lda	(BASL),Y
	tax
;	ldx	$4000,Y
	beq	skip_if_zero

dex_smc:			; DEX = $CA, NOP = $EA
	dex

skip_if_zero:
	txa
;burn_out_smc:
;	sta	$4000,Y
	sta	(GBASL),Y

	inc	random_smc+1	; update "RNG"
	bne	no_oflo
	inc	random_smc+2
	bne	no_oflo
	lda	#$d0
	sta	random_smc+2
no_oflo:




	dey
	bpl	burn_inner

	ldx	HGR_X		; finish early as top of screen empty
	cpx	#150
	bne	burn_loop

	;====================
	; copy to visible

copy_to_page1:

	; X should already be 150 here
;	ldx	#150		; only on bottom of screen

copy_loop:
	txa
	jsr	HPOSN		; puts addr of line in A into GBASL:GBASH

	lda	GBASL
	sta	BASL
;	sta	copy_inner_smc+1
	lda	GBASH
	eor	#$60		; flip to page 1
	sta	BASH
;	sta	copy_inner_smc+2

	ldy	#39
copy_inner:
	lda	(GBASL),Y
	tax
	lda	color_lookup,X

;	sec	; or ora $80?
ror_smc:
;	ror			; ROR = $6A 0110 1010
				; NOP = $EA 1110 1010

copy_inner_smc:
	sta	(BASL),Y

;	lda	ror_smc
;	eor	$80
;	sta	ror_smc

	dey
	bpl	copy_inner

	ldx	HGR_X
	inx
	cpx	#192
	bne	copy_loop

	;====================
	; loop forever

	beq	fire_loop		; bra



	;=====================



color_lookup:
	.byte $00		; 1 0 00 00 00	BBBB 0
	.byte $84		; 1 0 00 01 00	BB0B 1
	.byte $90		; 1 0 01 00 00	BOBB 2
	.byte $81		; 1 0 00 00 01	BBBO 3
	.byte $91		; 1 0 01 00 01	BOBO 4
	.byte $C4		; 1 1 00 01 00	OBOB 5
	.byte $D1		; 1 1 01 00 01	OOBO 6
	.byte $DA		; 1 1 01 01 01	OOOO 7
	.byte $F5		; 1 1 11 01 01	OWOO 8
	.byte $DD		; 1 1 01 11 01	WOWO 9
	.byte $FE		; 1 1 11 01 11	OWOW 10
	.byte $DF		; 1 1 01 11 11	OOWW 11
	.byte $F5		; 1 1 11 01 01	WWOO 12
	.byte $FD		; 1 1 11 11 01	WWWO 13
	.byte $DF		; 1 1 01 11 11	WOWW 14
	.byte $ff		; 1 1 11 11 11	WWWW 15

