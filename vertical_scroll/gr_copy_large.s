	;=========================================================
	; gr_copy_to_current, large, 40x48 version
	;=========================================================
	; copy A000 to DRAW_PAGE
	;

gr_copy_to_current_large:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line_large+5					; 4
	sta	gr_copy_line_large+11					; 4
	sta	gr_copy_line_large2+5					; 4
	sta	gr_copy_line_large2+11					; 4
	sta	gr_copy_line_large3+5					; 4
	sta	gr_copy_line_large3+11					; 4
	adc	#$1						; 2
	sta	gr_copy_line_large+17					; 4
	sta	gr_copy_line_large+23					; 4
	sta	gr_copy_line_large2+17					; 4
	sta	gr_copy_line_large2+23					; 4
	sta	gr_copy_line_large3+17					; 4
	sta	gr_copy_line_large3+23					; 4
	adc	#$1						; 2
	sta	gr_copy_line_large+29					; 4
	sta	gr_copy_line_large+35					; 4
	sta	gr_copy_line_large2+29					; 4
	sta	gr_copy_line_large2+35					; 4
	sta	gr_copy_line_large3+29					; 4
	sta	gr_copy_line_large3+35					; 4
	adc	#$1						; 2
	sta	gr_copy_line_large+41					; 4
	sta	gr_copy_line_large+47					; 4
	sta	gr_copy_line_large2+41					; 4
	sta	gr_copy_line_large2+47					; 4
	sta	gr_copy_line_large3+41					; 4
	sta	gr_copy_line_large3+47					; 4
							;===========
							;	45

	ldy	#39		; for early ones, copy 120 bytes	; 2

gr_copy_line_large:
	lda	$A000,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$A028,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$A050,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$A078,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$A0A0,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$A0C8,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$A0F0,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$A118,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line_large	;				; 2nt/3



	ldy	#39		; for early ones, copy 120 bytes	; 2

gr_copy_line_large2:
	lda	$A140,Y		; load a byte (self modified)		; 4
	sta	$428,Y		; store a byte (self modified)		; 5

	lda	$A168,Y		; load a byte (self modified)		; 4
	sta	$4A8,Y		; store a byte (self modified)		; 5

	lda	$A190,Y		; load a byte (self modified)		; 4
	sta	$528,Y		; store a byte (self modified)		; 5

	lda	$A1B8,Y		; load a byte (self modified)		; 4
	sta	$5A8,Y		; store a byte (self modified)		; 5

	lda	$A1E0,Y		; load a byte (self modified)		; 4
	sta	$628,Y		; store a byte (self modified)		; 5

	lda	$A208,Y		; load a byte (self modified)		; 4
	sta	$6A8,Y		; store a byte (self modified)		; 5

	lda	$A230,Y		; load a byte (self modified)		; 4
	sta	$728,Y		; store a byte (self modified)		; 5

	lda	$A258,Y		; load a byte (self modified)		; 4
	sta	$7A8,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line_large2	;				; 2nt/3


	ldy	#39		; for early ones, copy 120 bytes	; 2

gr_copy_line_large3:
	lda	$A280,Y		; load a byte (self modified)		; 4
	sta	$450,Y		; store a byte (self modified)		; 5

	lda	$A2A8,Y		; load a byte (self modified)		; 4
	sta	$4D0,Y		; store a byte (self modified)		; 5

	lda	$A2D0,Y		; load a byte (self modified)		; 4
	sta	$550,Y		; store a byte (self modified)		; 5

	lda	$A2F8,Y		; load a byte (self modified)		; 4
	sta	$5D0,Y		; store a byte (self modified)		; 5

	lda	$A320,Y		; load a byte (self modified)		; 4
	sta	$650,Y		; store a byte (self modified)		; 5

	lda	$A348,Y		; load a byte (self modified)		; 4
	sta	$6D0,Y		; store a byte (self modified)		; 5

	lda	$A370,Y		; load a byte (self modified)		; 4
	sta	$750,Y		; store a byte (self modified)		; 5

	lda	$A398,Y		; load a byte (self modified)		; 4
	sta	$7D0,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line_large3	;				; 2nt/3

	rts								; 6

