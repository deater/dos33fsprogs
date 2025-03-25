; copy 8k from $7000 to either $2000 or $4000 in AUX memory

copy_to_aux:
	sta	WRAUX
	lda	DRAW_PAGE
	beq	copy_to_aux_page1
	jmp	copy_to_aux_page2

copy_to_aux_page1:

	ldy	#0
copy_to_aux_page1_loop:
	lda	$7000,Y
	sta	$2000,Y
	lda	$7100,Y
	sta	$2100,Y
	lda	$7200,Y
	sta	$2200,Y
	lda	$7300,Y
	sta	$2300,Y
	lda	$7400,Y
	sta	$2400,Y
	lda	$7500,Y
	sta	$2500,Y
	lda	$7600,Y
	sta	$2600,Y
	lda	$7700,Y
	sta	$2700,Y
	lda	$7800,Y
	sta	$2800,Y
	lda	$7900,Y
	sta	$2900,Y
	lda	$7A00,Y
	sta	$2A00,Y
	lda	$7B00,Y
	sta	$2B00,Y
	lda	$7C00,Y
	sta	$2C00,Y
	lda	$7D00,Y
	sta	$2D00,Y
	lda	$7E00,Y
	sta	$2E00,Y
	lda	$7F00,Y
	sta	$2F00,Y
	lda	$8000,Y
	sta	$3000,Y
	lda	$8100,Y
	sta	$3100,Y
	lda	$8200,Y
	sta	$3200,Y
	lda	$8300,Y
	sta	$3300,Y
	lda	$8400,Y
	sta	$3400,Y
	lda	$8500,Y
	sta	$3500,Y
	lda	$8600,Y
	sta	$3600,Y
	lda	$8700,Y
	sta	$3700,Y
	lda	$8800,Y
	sta	$3800,Y
	lda	$8900,Y
	sta	$3900,Y
	lda	$8A00,Y
	sta	$3A00,Y
	lda	$8B00,Y
	sta	$3B00,Y
	lda	$8C00,Y
	sta	$3C00,Y
	lda	$8D00,Y
	sta	$3D00,Y
	lda	$8E00,Y
	sta	$3E00,Y
	lda	$8F00,Y
	sta	$3F00,Y
	iny
	beq	done_copy_to_aux_page1
	jmp	copy_to_aux_page1_loop
done_copy_to_aux_page1:
	sta	WRMAIN
	rts


copy_to_aux_page2:

	ldy	#0
copy_to_aux_page2_loop:
	lda	$7000,Y
	sta	$4000,Y
	lda	$7100,Y
	sta	$4100,Y
	lda	$7200,Y
	sta	$4200,Y
	lda	$7300,Y
	sta	$4300,Y
	lda	$7400,Y
	sta	$4400,Y
	lda	$7500,Y
	sta	$4500,Y
	lda	$7600,Y
	sta	$4600,Y
	lda	$7700,Y
	sta	$4700,Y
	lda	$7800,Y
	sta	$4800,Y
	lda	$7900,Y
	sta	$4900,Y
	lda	$7A00,Y
	sta	$4A00,Y
	lda	$7B00,Y
	sta	$4B00,Y
	lda	$7C00,Y
	sta	$4C00,Y
	lda	$7D00,Y
	sta	$4D00,Y
	lda	$7E00,Y
	sta	$4E00,Y
	lda	$7F00,Y
	sta	$4F00,Y
	lda	$8000,Y
	sta	$5000,Y
	lda	$8100,Y
	sta	$5100,Y
	lda	$8200,Y
	sta	$5200,Y
	lda	$8300,Y
	sta	$5300,Y
	lda	$8400,Y
	sta	$5400,Y
	lda	$8500,Y
	sta	$5500,Y
	lda	$8600,Y
	sta	$5600,Y
	lda	$8700,Y
	sta	$5700,Y
	lda	$8800,Y
	sta	$5800,Y
	lda	$8900,Y
	sta	$5900,Y
	lda	$8A00,Y
	sta	$5A00,Y
	lda	$8B00,Y
	sta	$5B00,Y
	lda	$8C00,Y
	sta	$5C00,Y
	lda	$8D00,Y
	sta	$5D00,Y
	lda	$8E00,Y
	sta	$5E00,Y
	lda	$8F00,Y
	sta	$5F00,Y
	iny
	beq	done_copy_to_aux_page2
	jmp	copy_to_aux_page2_loop
done_copy_to_aux_page2:
	sta	WRMAIN
	rts

