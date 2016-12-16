.define EQU =

PTR	EQU	$06

	lda	#0
	sta	PTR
	lda	#$40
	sta	PTR+1

	ldx	#8
	ldy	#0
copy_loop:
	lda	(PTR),y
	sta	$5000
	iny
	bne	copy_loop
	dex
	bne	copy_loop

	rts
