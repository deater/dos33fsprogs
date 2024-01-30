; flames -- Apple II Hires


flames:

	;==================================================
	; clear both graphics screens, set to display page1

;	lda	#$20
;	sta	HGR_PAGE

	;=============================================
	; setup (draw white line at bottom of screen)

	ldy	#39
	lda	#$f
white_line_loop:
	sta	$5DD0,Y
	dey
	bpl	white_line_loop

	;====================
	;====================
	; main loop
	;====================
	;====================



fire_loop:
	lda	#$20
	sta	DRAW_PAGE

	;====================
	; move fire
	;====================
move_fire:
	ldx	#159		; start at bottom of screen
burn_loop:

	;======================
	; input in BASL/BASH

	lda	hposn_low,X
	sta	BASL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	BASH

	;========================
	; output in GBASL:GBASH
	dex			; point to line above
	stx	XSAVE

	lda	hposn_low,X
	sta	GBASL		; put the line address into input
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#39		; 39 columns across screen
burn_inner:

random_smc:
	lda	$900		; our "RANDOM" numbers
;	lda	$E000		; our "RANDOM" numbers

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
	lda	random_smc+2
	cmp	#$0c
	bne	no_oflo
	lda	#$09				; wrap to "ROM"
	sta	random_smc+2
no_oflo:
	dey
	bpl	burn_inner

	ldx	XSAVE		; finish early as top of screen empty
	cpx	#120
	bne	burn_loop

	;====================
	; copy to visible

copy_to_page1:

	; X should already be 150 here
;	ldx	#150		; only on bottom of screen

copy_loop:
;	txa
;	jsr	HPOSN		; puts addr of line in A into GBASL:GBASH

	lda	hposn_low,X	; output on page1
	sta	BASL
	sta	GBASL
	lda	hposn_high,X
	sta	BASH
	clc
	adc	#$20
	sta	GBASH

	stx	XSAVE

;	lda	GBASL
;	sta	BASL
;	sta	copy_inner_smc+1
;	lda	GBASH
;	eor	#$60		; flip to page 1
;	sta	BASH
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

	ldx	XSAVE
	inx
	cpx	#160
	bne	copy_loop

	;====================
	; loop forever

check_flame_keypress:
	lda	KEYPRESS
	bmi	done_flames

	jmp	fire_loop		; bra


done_flames:
	bit	KEYRESET
	rts

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

