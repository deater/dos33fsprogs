
hgr_clear_screen_black:
	ldy	#0

hgr_clear_screen:

	lda	DRAW_PAGE
	beq	hgr_page1_clearscreen

	lda	#0
	beq	hgr_page2_clearscreen

hgr_page1_clearscreen:

	tya
	ldy	#0
hgr_page1_cls_loop:
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
	bne	hgr_page1_cls_loop

	rts


hgr_page2_clearscreen:
	tya
	ldy	#0
hgr_page2_cls_loop:
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
	bne	hgr_page2_cls_loop

	rts

.if 0

	;====================================
	; clear $6000 off-screen buffer
	;====================================

hgr_page3_clearscreen:

	tya
	ldy	#0
hgr_page3_cls_loop:
	sta	$6000,Y
	sta	$6100,Y
	sta	$6200,Y
	sta	$6300,Y
	sta	$6400,Y
	sta	$6500,Y
	sta	$6600,Y
	sta	$6700,Y
	sta	$6800,Y
	sta	$6900,Y
	sta	$6A00,Y
	sta	$6B00,Y
	sta	$6C00,Y
	sta	$6D00,Y
	sta	$6E00,Y
	sta	$6F00,Y
	sta	$7000,Y
	sta	$7100,Y
	sta	$7200,Y
	sta	$7300,Y
	sta	$7400,Y
	sta	$7500,Y
	sta	$7600,Y
	sta	$7700,Y
	sta	$7800,Y
	sta	$7900,Y
	sta	$7A00,Y
	sta	$7B00,Y
	sta	$7C00,Y
	sta	$7D00,Y
	sta	$7E00,Y
	sta	$7F00,Y
	iny
	bne	hgr_page3_cls_loop

	rts
.endif
