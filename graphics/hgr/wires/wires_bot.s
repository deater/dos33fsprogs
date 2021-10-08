; wires -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

COUNT		= $FE
FRAME		= $FF

; soft-switches

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

wires:

	jsr	HGR2

reset_x:
	ldx	#$0

outer_loop:


	; pulse loop horizontal

	lda	#$00
	tay

	sta	GBASL

	lda	#$40
	sta	GBASH
horiz_loop:

	lda	even_lookup,X
	sta	(GBASL),Y
	iny

	lda	odd_lookup,X
	sta	(GBASL),Y
	iny

	bne	noflo2
	inc	GBASH
noflo2:

	lda	#$44
	cmp	GBASH
	bne	horiz_loop


	; A should already be $44 here
	; Y should be 0

vert_loop:
	txa
	clc
	adc	#2
	asl
	asl
	adc	#$40
	sbc	GBASH
	cmp	#8
	lda	#$81
	bcs	noeor
	ora	#$02
noeor:

	sta	(GBASL),Y

	inc	GBASL
	inc	GBASL
	bne	noflo
	inc	GBASH
noflo:
	lda	#$60
	cmp	GBASH
	bne	vert_loop

	inx			; wrap at 7
	cpx	#7
	beq	reset_x
	bne	outer_loop

even_lookup:
.byte	$D7,$DD,$F5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA, $AB,$AE,$BA,$EA


	; want this to be at 3f5
	; Length is 94 so start at
	;               $3F5 - 91 = $39A


	jmp	wires


