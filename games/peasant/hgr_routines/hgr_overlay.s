	;=======================
	; HGR Overlay
	;=======================
	; loads from DRAW_PAGE
	;       OR with $9000
	; store back to DRAW_PAGE

hgr_overlay:
	lda	DRAW_PAGE
	cmp	#$20
	beq	hgr_overlay_page1
	jmp	hgr_overlay_page2

hgr_overlay_page1:

	ldy	#0
hgr_overlay_page1_loop:

	lda	$9000,Y
	ora	$2000,Y
	sta	$2000,Y

	lda	$9100,Y
	ora	$2100,Y
	sta	$2100,Y

	lda	$9200,Y
	ora	$2200,Y
	sta	$2200,Y

	lda	$9300,Y
	ora	$2300,Y
	sta	$2300,Y

	lda	$9400,Y
	ora	$2400,Y
	sta	$2400,Y

	lda	$9500,Y
	ora	$2500,Y
	sta	$2500,Y

	lda	$9600,Y
	ora	$2600,Y
	sta	$2600,Y

	lda	$9700,Y
	ora	$2700,Y
	sta	$2700,Y

	lda	$9800,Y
	ora	$2800,Y
	sta	$2800,Y

	lda	$9900,Y
	ora	$2900,Y
	sta	$2900,Y

	lda	$9A00,Y
	ora	$2A00,Y
	sta	$2A00,Y

	lda	$9B00,Y
	ora	$2B00,Y
	sta	$2B00,Y

	lda	$9C00,Y
	ora	$2C00,Y
	sta	$2C00,Y

	lda	$9D00,Y
	ora	$2D00,Y
	sta	$2D00,Y

	lda	$9E00,Y
	ora	$2E00,Y
	sta	$2E00,Y

	lda	$9F00,Y
	ora	$2F00,Y
	sta	$2F00,Y



	lda	$A000,Y
	ora	$3000,Y
	sta	$3000,Y

	lda	$A100,Y
	ora	$3100,Y
	sta	$3100,Y

	lda	$A200,Y
	ora	$3200,Y
	sta	$3200,Y

	lda	$A300,Y
	ora	$3300,Y
	sta	$3300,Y

	lda	$A400,Y
	ora	$3400,Y
	sta	$3400,Y

	lda	$A500,Y
	ora	$3500,Y
	sta	$3500,Y

	lda	$A600,Y
	ora	$3600,Y
	sta	$3600,Y

	lda	$A700,Y
	ora	$3700,Y
	sta	$3700,Y

	lda	$A800,Y
	ora	$3800,Y
	sta	$3800,Y

	lda	$A900,Y
	ora	$3900,Y
	sta	$3900,Y

	lda	$AA00,Y
	ora	$3A00,Y
	sta	$3A00,Y

	lda	$AB00,Y
	ora	$3B00,Y
	sta	$3B00,Y

	lda	$AC00,Y
	ora	$3C00,Y
	sta	$3C00,Y

	lda	$AD00,Y
	ora	$3D00,Y
	sta	$3D00,Y

	lda	$AE00,Y
	ora	$3E00,Y
	sta	$3E00,Y

	lda	$AF00,Y
	ora	$3F00,Y
	sta	$3F00,Y


	iny
	beq	hgr_page1_overlay_done
	jmp	hgr_overlay_page1_loop

hgr_page1_overlay_done:
	rts


hgr_overlay_page2:

	ldy	#0
hgr_overlay_page2_loop:

	lda	$9000,Y
	ora	$4000,Y
	sta	$4000,Y

	lda	$9100,Y
	ora	$4100,Y
	sta	$4100,Y

	lda	$9200,Y
	ora	$4200,Y
	sta	$4200,Y

	lda	$9300,Y
	ora	$4300,Y
	sta	$4300,Y

	lda	$9400,Y
	ora	$4400,Y
	sta	$4400,Y

	lda	$9500,Y
	ora	$4500,Y
	sta	$4500,Y

	lda	$9600,Y
	ora	$4600,Y
	sta	$4600,Y

	lda	$9700,Y
	ora	$4700,Y
	sta	$4700,Y

	lda	$9800,Y
	ora	$4800,Y
	sta	$4800,Y

	lda	$9900,Y
	ora	$4900,Y
	sta	$4900,Y

	lda	$9A00,Y
	ora	$4A00,Y
	sta	$4A00,Y

	lda	$9B00,Y
	ora	$4B00,Y
	sta	$4B00,Y

	lda	$9C00,Y
	ora	$4C00,Y
	sta	$4C00,Y

	lda	$9D00,Y
	ora	$4D00,Y
	sta	$4D00,Y

	lda	$9E00,Y
	ora	$4E00,Y
	sta	$4E00,Y

	lda	$9F00,Y
	ora	$4F00,Y
	sta	$4F00,Y



	lda	$A000,Y
	ora	$5000,Y
	sta	$5000,Y

	lda	$A100,Y
	ora	$5100,Y
	sta	$5100,Y

	lda	$A200,Y
	ora	$5200,Y
	sta	$5200,Y

	lda	$A300,Y
	ora	$5300,Y
	sta	$5300,Y

	lda	$A400,Y
	ora	$5400,Y
	sta	$5400,Y

	lda	$A500,Y
	ora	$5500,Y
	sta	$5500,Y

	lda	$A600,Y
	ora	$5600,Y
	sta	$5600,Y

	lda	$A700,Y
	ora	$5700,Y
	sta	$5700,Y

	lda	$A800,Y
	ora	$5800,Y
	sta	$5800,Y

	lda	$A900,Y
	ora	$5900,Y
	sta	$5900,Y

	lda	$AA00,Y
	ora	$5A00,Y
	sta	$5A00,Y

	lda	$AB00,Y
	ora	$5B00,Y
	sta	$5B00,Y

	lda	$AC00,Y
	ora	$5C00,Y
	sta	$5C00,Y

	lda	$AD00,Y
	ora	$5D00,Y
	sta	$5D00,Y

	lda	$AE00,Y
	ora	$5E00,Y
	sta	$5E00,Y

	lda	$AF00,Y
	ora	$5F00,Y
	sta	$5F00,Y


	iny
	beq	hgr_page2_overlay_done
	jmp	hgr_overlay_page2_loop

hgr_page2_overlay_done:
	rts

