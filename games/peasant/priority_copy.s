	;=========================================================
	; gr_copy_to_page1, 40x48 version
	;=========================================================
	; copy $7000 to $400, careful to avoid screen holes
	; we use this to copy down priority data

	; priority_temp is where we copy from ($7000 currently)

priority_copy:

	ldy	#119		; preserve memory holes		; 2

gr_copy_line:
	lda	priority_temp,Y		; load a byte			; 4
	sta	$400,Y			; store a byte			; 5

	lda	priority_temp+$80,Y	; load a byte			; 4
	sta	$480,Y			; store a byte			; 5

	lda	priority_temp+$100,Y	; load a byte			; 4
	sta	$500,Y			; store a byte			; 5

	lda	priority_temp+$180,Y	; load a byte			; 4
	sta	$580,Y			; store a byte			; 5

	lda	priority_temp+$200,Y	; load a byte			; 4
	sta	$600,Y			; store a byte			; 5

	lda	priority_temp+$280,Y	; load a byte			; 4
	sta	$680,Y			; store a byte			; 5

	lda	priority_temp+$300,Y	; load a byte			; 4
	sta	$700,Y			; store a byte			; 5

	lda	priority_temp+$380,Y	; load a byte			; 4
	sta	$780,Y			; store a byte			; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line	;					; 2nt/3

	rts								; 6

