	;=======================
	; HGR Clearscreen
	;=======================
	; note, using BKGND0 for this takes 0x44198 = 278,936 cycles
	;	unrolled here takes         0x0A501 =  42,241 cycles


	; Assume clear to black

	; TODO: also have a page1-clearscreen

hgr1_clearscreen:

	ldy	#0
	tya
hgr1_cls_loop:
	sta	$2000,Y
	sta	$2100,Y
	sta	$2200,Y
	sta	$2300,Y
	sta	$2400,Y
	sta	$2500,Y
	sta	$2600,Y
	sta	$2700,Y
	sta	$2800,Y
	sta	$2900,Y
	sta	$2A00,Y
	sta	$2B00,Y
	sta	$2C00,Y
	sta	$2D00,Y
	sta	$2E00,Y
	sta	$2F00,Y
	sta	$3000,Y
	sta	$3100,Y
	sta	$3200,Y
	sta	$3300,Y
	sta	$3400,Y
	sta	$3500,Y
	sta	$3600,Y
	sta	$3700,Y
	sta	$3800,Y
	sta	$3900,Y
	sta	$3A00,Y
	sta	$3B00,Y
	sta	$3C00,Y
	sta	$3D00,Y
	sta	$3E00,Y
	sta	$3F00,Y
	iny
	bne	hgr1_cls_loop

	rts
