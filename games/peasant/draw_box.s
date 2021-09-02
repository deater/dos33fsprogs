	;========================
	; draw dialog box
	;========================
	; from X1H:X1L,Y1 to X2H:X2L, Y2
	;   FIXME: X1H/X2H mostly ignored
draw_box:

	; draw rectangle

	lda	#$33		; color is white1
	sta	VGI_RCOLOR

	lda	BOX_X1L
	sta	VGI_RX1
	lda	BOX_Y1
	sta	VGI_RY1

				; calculate X run
	sec			; 16-bit subtract?
	lda	BOX_X2H		; doesn't handle >255
	sbc	BOX_X1H

	lda	BOX_X2L
	sbc	BOX_X1L
	sta	VGI_RXRUN

	sec
	lda	BOX_Y2
	sbc	BOX_Y1
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	; draw lines

	lda	#$22			; color is purple
	sta	VGI_RCOLOR

	; draw outer rectangle, x+6, y+5      x-6, y-5

	; draw 4 boxes
	;	x1+6,y1+5 ... x2-6,y1+6
	;	x1+6,y2-6 ... x2-6,y2-5
	;	x1+6,y1+5 ... x1+7,y2-6
	;	x2-7,y1+5 ... x2-6,y2-6

	;===============================
	; top: x1+6,y1+5 ... x2-6,y1+6

	clc
	lda	VGI_RX1
	adc	#6
	sta	VGI_RX1

	sec
	lda	VGI_RXRUN
	sbc	#12
	sta	VGI_RXRUN


	clc
	lda	BOX_Y1
	adc	#5
	sta	VGI_RY1

	lda	#2
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle


	;===============================
	; bottom:	x1+6,y2-6 ... x2-6,y2-5

	sec
	lda	BOX_Y2
	sbc	#6
	sta	VGI_RY1

	lda	#2
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	;===============================
	; left: x1+6,y1+5 ... x1+7,y2-6

	clc
	lda	BOX_Y1
	adc	#5
	sta	VGI_RY1

	lda	#2
	sta	VGI_RXRUN

	sec
	lda	BOX_Y2
	sbc	BOX_Y1
	sbc	#10
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle


	;===============================
	; right: x2-7,y1+5 ... x2-6,y2-6

	sec
	lda	BOX_X2L
	sbc	#7
	sta	VGI_RX1

	clc
	lda	BOX_Y1
	adc	#5
	sta	VGI_RY1

	sec
	lda	BOX_Y2
	sbc	BOX_Y1
	sbc	#9
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	rts

