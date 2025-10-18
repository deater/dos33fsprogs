	;=======================
	; HGR Clearscreen
	;=======================
	; note, using BKGND0 for this takes 0x44198 = 278,936 cycles
	;	unrolled here takes         0x0A501 =  42,241 cycles

	; Assume clear to black

	; draws to DRAW_PAGE

hgr_clearscreen:
	lda	DRAW_PAGE
	bne	hgr_clearscreen_page2

hgr_clearscreen_page1:

	ldy	#0
	tya
hgr_clearscreen_page1_loop:
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
	bne	hgr_clearscreen_page1_loop

	rts

hgr_clearscreen_page2:

	ldy	#0
	tya
hgr_clearscreen_page2_loop:
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
	bne	hgr_clearscreen_page2_loop

	rts
