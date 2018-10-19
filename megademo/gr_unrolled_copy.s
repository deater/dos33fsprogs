	;=========================================================
	; fast copy rows 22-36 from $C00 to $400
	;=========================================================
	;
	; 7+ 8*[9*7 + 7] + 5 = 572

gr_copy_row22:
	ldy	#8							; 2
	ldx	XPOS							; 3
	dex								; 2
grcr_loop:
	lda	$da8,x							; 4
	sta	$5a8,x		; 22					; 5
	lda	$e28,x							; 4
	sta	$628,x		; 24					; 5
	lda	$ea8,x							; 4
	sta	$6a8,x		; 26					; 5
	lda	$f28,x							; 4
	sta	$728,x		; 28					; 5
	lda	$fa8,x							; 4
	sta	$7a8,x		; 30					; 5
	lda	$c50,x							; 4
	sta	$450,x		; 32					; 5
	lda	$cd0,x							; 4
	sta	$4d0,x		; 34					; 5

	inx								; 2
	dey								; 2
	bne	grcr_loop						; 3
									; -1
	rts								; 6




