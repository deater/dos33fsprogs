	;=========================================================
	; gr_copy_to_current, 40x48 version
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	;
	; 45 + 2 + 120*(8*9 + 5) -1 + 6 = 9292

gr_copy_to_current:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line+5					; 4
	sta	gr_copy_line+11					; 4
	adc	#$1						; 2
	sta	gr_copy_line+17					; 4
	sta	gr_copy_line+23					; 4
	adc	#$1						; 2
	sta	gr_copy_line+29					; 4
	sta	gr_copy_line+35					; 4
	adc	#$1						; 2
	sta	gr_copy_line+41					; 4
	sta	gr_copy_line+47					; 4
							;===========
							;	45

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line:
	lda	$C00,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$C80,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$D00,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$D80,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$E00,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$E80,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$F00,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$F80,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line	;					; 2nt/3

	rts								; 6

