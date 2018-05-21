	;=========================================================
	; gr_copy_to_current
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	; ORIGINAL: 2 + 8*38 + 4*80*23 + 4*120*26 + 13 = 20,159 = 20ms = 50Hz
	;
	; OPTIMIZED: 2+ 8*38 + 9*4 + 7*4 + 14*120*4 + 14*80*4 + 9*8 + 6 =
	;						11,648 = 11ms = 90Hz
gr_copy_to_current:

	ldx	 #0		; set ypos to zero			; 2

gr_copy_loop:
	lda	gr_offsets,X	; lookup low byte for line addr		; 4+

	sta	gr_copy_line+1	; out and in are the same		; 4
	sta	gr_copy_line+4						; 4

	lda	gr_offsets+1,X	; lookup high byte for line addr	; 4+
	clc								; 2
	adc	DRAW_PAGE						; 3
	sta	gr_copy_line+5						; 4

	lda	gr_offsets+1,X	; lookup high byte for line addr	; 4+
	adc	#$8		; for now, fixed 0xc			; 2
	sta	gr_copy_line+2						; 4

	ldy     #0		; set xpos counter to 0			; 2


	cpx	#$8		; don't want to copy bottom 4*40	; 2
	bcs	gr_copy_above4						; 2nt/3

gr_copy_below4:
	ldy	#119		; for early ones, copy 120 bytes	; 2
	bcc	gr_copy_line	;					; 3

gr_copy_above4:			; for last four, just copy 80 bytes
	ldy	#79							; 2

gr_copy_line:
	lda	$ffff,Y		; load a byte (self modified)		; 4+
	sta	$ffff,Y		; store a byte (self modified)		; 5
	dey			; decrement pointer			; 2
	bpl	gr_copy_line	;					; 2nt/3

gr_copy_line_done:
	inx			; increment ypos value			; 2
	inx			; twice, as address is 2 bytes		; 2
	cpx	#16		; there are 8*2 of them			; 2
	bne	gr_copy_loop	; if not, loop				; 3
	rts								; 6

