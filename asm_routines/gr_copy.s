	;=========================================================
	; gr_copy_to_current
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	; 2 + 8*38 + 4*80*23 + 4*120*26 + 13 = 20,159 = 20ms = 50Hz
	;
gr_copy_to_current:
	ldx	#0		; set y to zero				; 2

gr_copy_loop:
	stx	TEMP		; save y				; 3
	txa			; move to A				; 2
	asl			; mult by 2				; 2
	tay			; put into Y				; 2
	lda	gr_offsets,Y	; lookup low byte for line addr		; 5
	sta	OUTL		; out and in are the same		; 3
	sta	INL							; 3
	lda	gr_offsets+1,Y	; lookup high byte for line addr	; 5
	adc	DRAW_PAGE
	sta	OUTH							; 3
	lda	gr_offsets+1,Y	; lookup high byte for line addr	; 5
	adc	#$8		; for now, fixed 0xc			; 2
	sta	INH							; 3
	ldx	TEMP		; restore y				; 3

	ldy	#0		; set X counter to 0			; 2
gr_copy_line:
	lda     (INL),Y		; load a byte				; 5
	sta     (OUTL),Y	; store a byte				; 6
	iny			; increment pointer			; 2

	cpx	#$4		; don't want to copy bottom 4*40	; 2
	bcs	gr_copy_above4						; 3

gr_copy_below4:
	cpy	#120		; for early ones, copy 120 bytes	; 2
	bne	gr_copy_line						; 3
	beq	gr_copy_line_done					; 3

gr_copy_above4:			; for last four, just copy 80 bytes
	cpy	#80							; 2
	bne	gr_copy_line						; 3

gr_copy_line_done:
	inx			; increment y value			; 2
	cpx	#8		; there are 8 of them			; 2
	bne	gr_copy_loop	; if not, loop				; 3
	rts								; 6


