	;=======================
	; HGR Save
	;=======================
	; loads from $40
	; save to $20

hgr_save:

	ldy	#0
hgr_save_loop:
	lda	$4000,Y
	sta	$2000,Y

	lda	$4100,Y
	sta	$2100,Y

	lda	$4200,Y
	sta	$2200,Y

	lda	$4300,Y
	sta	$2300,Y

	lda	$4400,Y
	sta	$2400,Y

	lda	$4500,Y
	sta	$2500,Y

	lda	$4600,Y
	sta	$2600,Y

	lda	$4700,Y
	sta	$2700,Y

	lda	$4800,Y
	sta	$2800,Y

	lda	$4900,Y
	sta	$2900,Y

	lda	$4A00,Y
	sta	$2A00,Y

	lda	$4B00,Y
	sta	$2B00,Y

	lda	$4C00,Y
	sta	$2C00,Y

	lda	$4D00,Y
	sta	$2D00,Y

	lda	$4E00,Y
	sta	$2E00,Y

	lda	$4F00,Y
	sta	$2F00,Y

	;

	lda	$5000,Y
	sta	$3000,Y

	lda	$5100,Y
	sta	$3100,Y

	lda	$5200,Y
	sta	$3200,Y

	lda	$5300,Y
	sta	$3300,Y

	lda	$5400,Y
	sta	$3400,Y

	lda	$5500,Y
	sta	$3500,Y

	lda	$5600,Y
	sta	$3600,Y

	lda	$5700,Y
	sta	$3700,Y

	lda	$5800,Y
	sta	$3800,Y

	lda	$5900,Y
	sta	$3900,Y

	lda	$5A00,Y
	sta	$3A00,Y

	lda	$5B00,Y
	sta	$3B00,Y

	lda	$5C00,Y
	sta	$3C00,Y

	lda	$5D00,Y
	sta	$3D00,Y

	lda	$5E00,Y
	sta	$3E00,Y

	lda	$5F00,Y
	sta	$3F00,Y

	iny
	beq	hgr_save_done
	jmp	hgr_save_loop

hgr_save_done:
	rts




	;=======================
	; HGR Restore
	;=======================
	; loads from $20
	; save to $40

hgr_restore:

	ldy	#0
hgr_restore_loop:
	lda	$2000,Y
	sta	$4000,Y

	lda	$2100,Y
	sta	$4100,Y

	lda	$2200,Y
	sta	$4200,Y

	lda	$2300,Y
	sta	$4300,Y

	lda	$2400,Y
	sta	$4400,Y

	lda	$2500,Y
	sta	$4500,Y

	lda	$2600,Y
	sta	$4600,Y

	lda	$2700,Y
	sta	$4700,Y

	lda	$2800,Y
	sta	$4800,Y

	lda	$2900,Y
	sta	$4900,Y

	lda	$2A00,Y
	sta	$4A00,Y

	lda	$2B00,Y
	sta	$4B00,Y

	lda	$2C00,Y
	sta	$4C00,Y

	lda	$2D00,Y
	sta	$4D00,Y

	lda	$2E00,Y
	sta	$4E00,Y

	lda	$2F00,Y
	sta	$4F00,Y

	;

	lda	$3000,Y
	sta	$5000,Y

	lda	$3100,Y
	sta	$5100,Y

	lda	$3200,Y
	sta	$5200,Y

	lda	$3300,Y
	sta	$5300,Y

	lda	$3400,Y
	sta	$5400,Y

	lda	$3500,Y
	sta	$5500,Y

	lda	$3600,Y
	sta	$5600,Y

	lda	$3700,Y
	sta	$5700,Y

	lda	$3800,Y
	sta	$5800,Y

	lda	$3900,Y
	sta	$5900,Y

	lda	$3A00,Y
	sta	$5A00,Y

	lda	$3B00,Y
	sta	$5B00,Y

	lda	$3C00,Y
	sta	$5C00,Y

	lda	$3D00,Y
	sta	$5D00,Y

	lda	$3E00,Y
	sta	$5E00,Y

	lda	$3F00,Y
	sta	$5F00,Y

	iny
	beq	hgr_restore_done
	jmp	hgr_restore_loop

hgr_restore_done:
	rts

