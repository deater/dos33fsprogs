	; draw inverse box on text screen

	; we could use HLIN/VLIN instead?

	; note Y should be in text coords (0..23) not GR (0..47)

drawbox:
	lda	drawbox_y1
	jsr	text_hlin
	lda	drawbox_y2
	jsr	text_hlin

	jsr	text_vlins

	rts

	;========================
	; text hlin
	;========================
	; draw from x1,A to x2,A

text_hlin:
	asl
	tay

	lda	gr_offsets,Y
	sta	OUTL

	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	#' '
	ldy	drawbox_x1
drawbox_hlin_loop:
	sta	(OUTL),Y
	iny
	cpy	drawbox_x2
	bne	drawbox_hlin_loop

	rts

	;========================
	; text vlin
	;========================
	; draw from A,y1 to A,y2

text_vlins:

	ldx	drawbox_y1

text_vlins_loop:
	txa
	asl
	tay
	lda	gr_offsets,Y
	sta	OUTL

	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	#' '

	ldy	drawbox_x1
	sta	(OUTL),Y
	ldy	drawbox_x2
	sta	(OUTL),Y

	inx
	cpx	drawbox_y2
	bcc	text_vlins_loop
	beq	text_vlins_loop		; ble

	rts


drawbox_x1:	.byte $00
drawbox_x2:	.byte $00
drawbox_y1:	.byte $00
drawbox_y2:	.byte $00

