	;=======================
	; HGR2 Clearscreen
	;=======================
	; note, using BKGND0 for this takes 0x44198 = 278,936 cycles
	;	unrolled here takes         0x0A501 =  42,241 cycles

hgr2:
	bit	PAGE2
	bit	FULLGR
	lda	#$40
	sta	HGR_PAGE

	lda	HIRES
	lda	SET_GR

	lda	#$00

hgr2_clearscreen:

before:
	ldy	#0
hgr_cls_loop:
	sta	$4000,Y
	sta	$4100,Y
	sta	$4200,Y
	sta	$4300,Y
	sta	$4400,Y
	sta	$4500,Y
	sta	$4600,Y
	sta	$4700,Y
	sta	$4800,Y
	sta	$4900,Y
	sta	$4A00,Y
	sta	$4B00,Y
	sta	$4C00,Y
	sta	$4D00,Y
	sta	$4E00,Y
	sta	$4F00,Y
	sta	$5000,Y
	sta	$5100,Y
	sta	$5200,Y
	sta	$5300,Y
	sta	$5400,Y
	sta	$5500,Y
	sta	$5600,Y
	sta	$5700,Y
	sta	$5800,Y
	sta	$5900,Y
	sta	$5A00,Y
	sta	$5B00,Y
	sta	$5C00,Y
	sta	$5D00,Y
	sta	$5E00,Y
	sta	$5F00,Y
	iny
	bne	hgr_cls_loop

after:
	rts
