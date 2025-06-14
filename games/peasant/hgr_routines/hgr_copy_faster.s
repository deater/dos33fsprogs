	;=========================================================
	; hgr copy from $6000 to current DRAW_PAGE
	;=========================================================

;	; theoretical unrolled, 30*6 bytes bigger (180 bytes?)
;	; 2 + ((9*32)+5)*256 + 5 = 75015 = 13.3 fps
	; it's not quite this good, need to recalculate

	; original:
	;	(20+((14*256)-1)*32 + 25 + 6 = 115327 = 8.9 fps (112ms)
	;

hgr_copy_faster:
	ldx	#0
	lda	DRAW_PAGE
	bne	hgr_copy_faster_page2
	jmp	hgr_copy_faster_page1

hgr_copy_faster_page2:
	lda	$6000,X							; 4
	sta	$4000,X							; 5

	lda	$6100,X							; 4
	sta	$4100,X							; 5

	lda	$6200,X							; 4
	sta	$4200,X							; 5

	lda	$6300,X							; 4
	sta	$4300,X							; 5

	lda	$6400,X							; 4
	sta	$4400,X							; 5

	lda	$6500,X							; 4
	sta	$4500,X							; 5

	lda	$6600,X							; 4
	sta	$4600,X							; 5

	lda	$6700,X							; 4
	sta	$4700,X							; 5

	lda	$6800,X							; 4
	sta	$4800,X							; 5

	lda	$6900,X							; 4
	sta	$4900,X							; 5

	lda	$6A00,X							; 4
	sta	$4A00,X							; 5

	lda	$6B00,X							; 4
	sta	$4B00,X							; 5

	lda	$6C00,X							; 4
	sta	$4C00,X							; 5

	lda	$6D00,X							; 4
	sta	$4D00,X							; 5

	lda	$6E00,X							; 4
	sta	$4E00,X							; 5

	lda	$6F00,X							; 4
	sta	$4F00,X							; 5

	lda	$7000,X							; 4
	sta	$5000,X							; 5

	lda	$7100,X							; 4
	sta	$5100,X							; 5

	lda	$7200,X							; 4
	sta	$5200,X							; 5

	lda	$7300,X							; 4
	sta	$5300,X							; 5

	lda	$7400,X							; 4
	sta	$5400,X							; 5

	lda	$7500,X							; 4
	sta	$5500,X							; 5

	lda	$7600,X							; 4
	sta	$5600,X							; 5

	lda	$7700,X							; 4
	sta	$5700,X							; 5

	lda	$7800,X							; 4
	sta	$5800,X							; 5

	lda	$7900,X							; 4
	sta	$5900,X							; 5

	lda	$7A00,X							; 4
	sta	$5A00,X							; 5

	lda	$7B00,X							; 4
	sta	$5B00,X							; 5

	lda	$7C00,X							; 4
	sta	$5C00,X							; 5

	lda	$7D00,X							; 4
	sta	$5D00,X							; 5

	lda	$7E00,X							; 4
	sta	$5E00,X							; 5

	lda	$7F00,X							; 4
	sta	$5F00,X							; 5

	dex								; 2
	beq	hgr_copy_faster_page2_done				; 2nt/3t
	jmp	hgr_copy_faster_page2					; 3

hgr_copy_faster_page2_done:
	rts								; 6


hgr_copy_faster_page1:
	lda	$6000,X							; 4
	sta	$2000,X							; 5

	lda	$6100,X							; 4
	sta	$2100,X							; 5

	lda	$6200,X							; 4
	sta	$2200,X							; 5

	lda	$6300,X							; 4
	sta	$2300,X							; 5

	lda	$6400,X							; 4
	sta	$2400,X							; 5

	lda	$6500,X							; 4
	sta	$2500,X							; 5

	lda	$6600,X							; 4
	sta	$2600,X							; 5

	lda	$6700,X							; 4
	sta	$2700,X							; 5

	lda	$6800,X							; 4
	sta	$2800,X							; 5

	lda	$6900,X							; 4
	sta	$2900,X							; 5

	lda	$6A00,X							; 4
	sta	$2A00,X							; 5

	lda	$6B00,X							; 4
	sta	$2B00,X							; 5

	lda	$6C00,X							; 4
	sta	$2C00,X							; 5

	lda	$6D00,X							; 4
	sta	$2D00,X							; 5

	lda	$6E00,X							; 4
	sta	$2E00,X							; 5

	lda	$6F00,X							; 4
	sta	$2F00,X							; 5

	lda	$7000,X							; 4
	sta	$3000,X							; 5

	lda	$7100,X							; 4
	sta	$3100,X							; 5

	lda	$7200,X							; 4
	sta	$3200,X							; 5

	lda	$7300,X							; 4
	sta	$3300,X							; 5

	lda	$7400,X							; 4
	sta	$3400,X							; 5

	lda	$7500,X							; 4
	sta	$3500,X							; 5

	lda	$7600,X							; 4
	sta	$3600,X							; 5

	lda	$7700,X							; 4
	sta	$3700,X							; 5

	lda	$7800,X							; 4
	sta	$3800,X							; 5

	lda	$7900,X							; 4
	sta	$3900,X							; 5

	lda	$7A00,X							; 4
	sta	$3A00,X							; 5

	lda	$7B00,X							; 4
	sta	$3B00,X							; 5

	lda	$7C00,X							; 4
	sta	$3C00,X							; 5

	lda	$7D00,X							; 4
	sta	$3D00,X							; 5

	lda	$7E00,X							; 4
	sta	$3E00,X							; 5

	lda	$7F00,X							; 4
	sta	$3F00,X							; 5

	dex								; 2
	beq	hgr_copy_faster_page1_done				; 2nt/3t
	jmp	hgr_copy_faster_page1					; 3

hgr_copy_faster_page1_done:
	rts								; 6


