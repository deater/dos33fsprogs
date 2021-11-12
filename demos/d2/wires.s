; wires -- Apple II Hires

; go for 100 frames?

wires:

;	jsr	HGR2

	ldx	#$0
	stx	FRAME

reset_x:
	ldx	#$0
	stx	COUNT
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

	inc	COUNT
	inc	FRAME
	lda	FRAME
	cmp	#53

	bne	outer_loop

	rts

even_lookup:
.byte	$D7,$DD,$F5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA, $AB,$AE,$BA,$EA




