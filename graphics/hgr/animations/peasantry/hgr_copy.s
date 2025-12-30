	;=========================================================
	; hgr copy from $A000 to current DRAW_PAGE
	;=========================================================

hgr_copy:
	ldx	#0
	lda	DRAW_PAGE
	bne	hgr_copy_page2
	jmp	hgr_copy_page1

hgr_copy_page2:
	lda	$A000,X							; 4
	sta	$4000,X							; 5

	lda	$A100,X							; 4
	sta	$4100,X							; 5

	lda	$A200,X							; 4
	sta	$4200,X							; 5

	lda	$A300,X							; 4
	sta	$4300,X							; 5

	lda	$A400,X							; 4
	sta	$4400,X							; 5

	lda	$A500,X							; 4
	sta	$4500,X							; 5

	lda	$A600,X							; 4
	sta	$4600,X							; 5

	lda	$A700,X							; 4
	sta	$4700,X							; 5

	lda	$A800,X							; 4
	sta	$4800,X							; 5

	lda	$A900,X							; 4
	sta	$4900,X							; 5

	lda	$AA00,X							; 4
	sta	$4A00,X							; 5

	lda	$AB00,X							; 4
	sta	$4B00,X							; 5

	lda	$AC00,X							; 4
	sta	$4C00,X							; 5

	lda	$AD00,X							; 4
	sta	$4D00,X							; 5

	lda	$AE00,X							; 4
	sta	$4E00,X							; 5

	lda	$AF00,X							; 4
	sta	$4F00,X							; 5

	lda	$B000,X							; 4
	sta	$5000,X							; 5

	lda	$B100,X							; 4
	sta	$5100,X							; 5

	lda	$B200,X							; 4
	sta	$5200,X							; 5

	lda	$B300,X							; 4
	sta	$5300,X							; 5

	lda	$B400,X							; 4
	sta	$5400,X							; 5

	lda	$B500,X							; 4
	sta	$5500,X							; 5

	lda	$B600,X							; 4
	sta	$5600,X							; 5

	lda	$B700,X							; 4
	sta	$5700,X							; 5

	lda	$B800,X							; 4
	sta	$5800,X							; 5

	lda	$B900,X							; 4
	sta	$5900,X							; 5

	lda	$BA00,X							; 4
	sta	$5A00,X							; 5

	lda	$BB00,X							; 4
	sta	$5B00,X							; 5

	lda	$BC00,X							; 4
	sta	$5C00,X							; 5

	lda	$BD00,X							; 4
	sta	$5D00,X							; 5

	lda	$BE00,X							; 4
	sta	$5E00,X							; 5

	lda	$BF00,X							; 4
	sta	$5F00,X							; 5

	dex								; 2
	beq	hgr_copy_page2_done				; 2nt/3t
	jmp	hgr_copy_page2					; 3

hgr_copy_page2_done:
	rts								; 6


hgr_copy_page1:
	lda	$A000,X							; 4
	sta	$2000,X							; 5

	lda	$A100,X							; 4
	sta	$2100,X							; 5

	lda	$A200,X							; 4
	sta	$2200,X							; 5

	lda	$A300,X							; 4
	sta	$2300,X							; 5

	lda	$A400,X							; 4
	sta	$2400,X							; 5

	lda	$A500,X							; 4
	sta	$2500,X							; 5

	lda	$A600,X							; 4
	sta	$2600,X							; 5

	lda	$A700,X							; 4
	sta	$2700,X							; 5

	lda	$A800,X							; 4
	sta	$2800,X							; 5

	lda	$A900,X							; 4
	sta	$2900,X							; 5

	lda	$AA00,X							; 4
	sta	$2A00,X							; 5

	lda	$AB00,X							; 4
	sta	$2B00,X							; 5

	lda	$AC00,X							; 4
	sta	$2C00,X							; 5

	lda	$AD00,X							; 4
	sta	$2D00,X							; 5

	lda	$AE00,X							; 4
	sta	$2E00,X							; 5

	lda	$AF00,X							; 4
	sta	$2F00,X							; 5

	lda	$B000,X							; 4
	sta	$3000,X							; 5

	lda	$B100,X							; 4
	sta	$3100,X							; 5

	lda	$B200,X							; 4
	sta	$3200,X							; 5

	lda	$B300,X							; 4
	sta	$3300,X							; 5

	lda	$B400,X							; 4
	sta	$3400,X							; 5

	lda	$B500,X							; 4
	sta	$3500,X							; 5

	lda	$B600,X							; 4
	sta	$3600,X							; 5

	lda	$B700,X							; 4
	sta	$3700,X							; 5

	lda	$B800,X							; 4
	sta	$3800,X							; 5

	lda	$B900,X							; 4
	sta	$3900,X							; 5

	lda	$BA00,X							; 4
	sta	$3A00,X							; 5

	lda	$BB00,X							; 4
	sta	$3B00,X							; 5

	lda	$BC00,X							; 4
	sta	$3C00,X							; 5

	lda	$BD00,X							; 4
	sta	$3D00,X							; 5

	lda	$BE00,X							; 4
	sta	$3E00,X							; 5

	lda	$BF00,X							; 4
	sta	$3F00,X							; 5

	dex								; 2
	beq	hgr_copy_page1_done				; 2nt/3t
	jmp	hgr_copy_page1					; 3

hgr_copy_page1_done:
	rts								; 6


