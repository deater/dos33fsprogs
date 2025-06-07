	;=========================================================
	; gr_copy_to_page1, 40x48 version
	;=========================================================
	; copy $6000 to $400, careful to avoid screen holes
	; we use this to copy down priority data

priority_copy:

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line:
	lda	$6000,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$6080,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$6100,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$6180,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$6200,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$6280,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$6300,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$6380,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line	;					; 2nt/3

	rts								; 6

