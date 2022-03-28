.include "hgr.inc"


	;=====================
	; make /7 %7 tables
	;=====================

hgr_make_tables:

	ldy	#0
	lda	#0
	ldx	#0
div7_loop:
	sta	div7_table,Y

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0
div7_not7:
	iny
	bne	div7_loop


	ldy	#0
	lda	#0
mod7_loop:
	sta	mod7_table,Y
	clc
	adc	#1
	cmp	#7
	bne	mod7_not7
	lda	#0
mod7_not7:
	iny
	bne	mod7_loop


	; Hposn table

	lda	#0
hposn_loop:
	ldy	#0
	ldx	#0
	pha
	jsr	hposn	; (Y,X),(A)
	pla
	tax

	lda	GBASL
	sta	hposn_low,X

	lda	GBASH
	sta	hposn_high,X

	inx
	txa

	cmp	#192
	bne	hposn_loop

	rts

	; left masks
	;	in memory	on screen
	;	x111 1111	1111111		start at 0
	;	x111 1110	0111111		start at 1
	;	x111 1100	0011111		start at 2
	; ...
	;	x100 0000	0000001		start at 6

right_masks:
	.byte $80,$81,$83,$87, $8F,$9F,$BF

left_masks:
	.byte $FF,$FE,$FC,$F8, $F0,$E0,$C0

	; right masks
	;	in memory	on screen
	;	x000 0001	1000000		end at 0
	;	x000 0011	1100000		end at 1
	;	x000 0111	1110000		end at 2
	; ...
	;	x011 1111	1111110		end at 5
	;	x111 1111	1111111		end at 6


	; from the Apple II firmware
hposn:
;	sta	HGR_Y			; save Y and X positions
;	stx	HGR_X
;	sty	HGR_X+1

	pha				; Y pos on stack

	and	#$C0			; calc base addr for Y-pos

	sta	GBASL
	lsr
	lsr
	ora	GBASL
	sta	GBASL
	pla

	sta	GBASH
	asl
	asl
	asl
	rol	GBASH
	asl
	rol	GBASH
	asl
	ror	GBASL
	lda	GBASH

	and	#$1F

	ora	HGR_PAGE	; default is $40 in this game
	sta	GBASH

;	txa
;	cpy	#0
;	beq	xpos_lessthan_256
;	ldy	#35
;	adc	#4
;label_1:
;	iny
;xpos_lessthan_256:
;	sbc	#7
;	bcs	label_1

	rts

