; flames -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

HGR_X		= $E0

COUNT		= $FE
FRAME		= $FF

; soft-switches

PAGE1		= $C054

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

flamees:

	jsr	HGR2
	bit	PAGE1

	;==================
	; setup

	ldx	#39
	lda	#$9
white_line_loop:
	sta	$5FD0,X
	dex
	bpl	white_line_loop


fire_loop:

	;====================
	; move fire

	jsr	move_fire

	;====================
	; copy to visible

	jsr	copy_to_page1

	;====================
	; loop forever

	jmp	fire_loop



move_fire:


	ldx	#191
burn_loop:
	txa
	jsr	HPOSN		; puts addr of line in A into GBASL:GBASH

	lda	GBASL
	sta	burn_in_smc+1
	lda	GBASH
	sta	burn_in_smc+2

	ldx	HGR_X
	dex
	txa
	jsr	HPOSN

	lda	GBASL
	sta	burn_out_smc+1
	lda	GBASH
	sta	burn_out_smc+2


	ldy	#39
burn_inner:

burn_in_smc:
	ldx	$4000,Y
	beq	skip_zero
	dex
skip_zero:
	txa

ror_smc:
	ror			; ROR = $6A 0110 1010
				; NOP = $EA 1110 1010
burn_out_smc:
	sta	$4000,Y

;	lda	ror_smc
;	eor	$80
;	sta	ror_smc

	dey
	bpl	burn_inner

	ldx	HGR_X
	bne	burn_loop

	rts


	;=====================

copy_to_page1:

	ldx	#0
copy_loop:
	txa
	jsr	HPOSN		; puts addr of line in A into GBASL:GBASH
;	ldx	HGR_X

	lda	GBASL
	sta	copy_inner_smc+1
	lda	GBASH
	eor	#$60
	sta	copy_inner_smc+2

	ldy	#39
copy_inner:
	lda	(GBASL),Y
	tax
	lda	color_lookup,X
copy_inner_smc:
	sta	$2000,Y
	dey
	bpl	copy_inner

	ldx	HGR_X
	inx
	cpx	#192
	bne	copy_loop

	rts

color_lookup:
	.byte $00		; 1 0 00 00 00	BBBB 0
	.byte $90		; 1 0 01 00 00	BOBB 1
	.byte $81		; 1 0 00 00 01	BBBO 2
	.byte $91		; 1 0 01 00 01	BOBO 3
	.byte $C4		; 1 1 00 01 00	OBOB 4
	.byte $DD		; 1 1 01 11 01	WOWO 5
	.byte $FE		; 1 1 11 01 11	OWOW 6
	.byte $DF		; 1 1 01 11 11	OOWW 7
	.byte $F5		; 1 1 11 01 01	WWOO 8
	.byte $ff		; 1 1 11 11 11	WWWW 9

