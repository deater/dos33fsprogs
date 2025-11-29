	;=====================================
	; make green
	;=====================================
make_green:

	lda	#$20
	sta	mgl_smc1+2
	sta	mgl_smc2+2


	ldy	#0

make_green_loop:

mgl_smc1:
	lda	$2000,Y
	and	#$7f
mgl_smc2:
	sta	$2000,Y
	iny
	bne	make_green_loop

	inc	mgl_smc1+2
	inc	mgl_smc2+2
	lda	mgl_smc2+2
	cmp	#$60
	bne	make_green_loop

	rts


	;=====================================
	; make orange
	;=====================================
make_orange:


	lda	#$20
	sta	mol_smc1+2
	sta	mol_smc2+2

	ldy	#0

make_orange_loop:

mol_smc1:
	lda	$2000,Y
	ora	#$80
mol_smc2:
	sta	$2000,Y
	iny
	bne	make_orange_loop

	inc	mol_smc1+2
	inc	mol_smc2+2
	lda	mol_smc2+2
	cmp	#$60
	bne	make_orange_loop

	rts


