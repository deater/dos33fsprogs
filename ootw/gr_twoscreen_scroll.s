	;=========================================================
	; gr_twoscreen_scroll, 40x48 version
	;=========================================================
	; offset is in BG_SCROLL, must be multiple of 2
	;
	; two screens, top is at $1000, bottom at $BC00
	; 	copy lines Y-48 from $1000 to $c00
	;	copy lines 0 - (48-y) from $BC00 to $c00

gr_twoscreen_scroll:

	lda	#0
	sta	TEMPY		; dest

	ldy	BG_SCROLL
	cpy	#48
	beq	gr_twoscreen_bottom		; no top to draw

gr_twoscreen_top:

	; calculate source

	lda	gr_offsets+1,Y
	clc
	adc	#($10-4)
	sta	gr_twoscreen_smc_src+2
	lda	gr_offsets,Y
	sta	gr_twoscreen_smc_src+1
	tya
	pha

	; calculate destination

	lda	TEMPY
	tay
	lda	gr_offsets+1,Y
	clc
	adc	#($c-4)
	sta	gr_twoscreen_smc_dst+2
	lda	gr_offsets,Y
	sta	gr_twoscreen_smc_dst+1

	ldx	#0
gr_twoscreen_line_loop:

gr_twoscreen_smc_src:
	lda	$1000,X
gr_twoscreen_smc_dst:
	sta	$c00,X

	inx
	cpx	#40
	bne	gr_twoscreen_line_loop


	inc	TEMPY
	inc	TEMPY

	pla
	tay

	iny
	iny

	cpy	#48

	bne	gr_twoscreen_top


	;===============================
	; now copy the bottom from $BC00

	lda	BG_SCROLL
	beq	done_twoscreen_bottom		; if 0, no bottom

gr_twoscreen_bottom:

	ldy	#0

gr_twoscreen_bottom_loop:

	; calculate source

	lda	gr_offsets+1,Y
	clc
	adc	#($bc-4)
	sta	gr_twoscreen_bottom_smc_src+2
	lda	gr_offsets,Y
	sta	gr_twoscreen_bottom_smc_src+1
	tya
	pha

	; calculate destination

	lda	TEMPY
	tay
	lda	gr_offsets+1,Y
	clc
	adc	#($c-4)
	sta	gr_twoscreen_bottom_smc_dst+2
	lda	gr_offsets,Y
	sta	gr_twoscreen_bottom_smc_dst+1

	ldx	#0
gr_twoscreen_bottom_line_loop:

gr_twoscreen_bottom_smc_src:
	lda	$BC00,X
gr_twoscreen_bottom_smc_dst:
	sta	$c00,X

	inx
	cpx	#40
	bne	gr_twoscreen_bottom_line_loop


	inc	TEMPY
	inc	TEMPY

	pla
	tay

	iny
	iny

	cpy	BG_SCROLL

	bne	gr_twoscreen_bottom_loop
done_twoscreen_bottom:
	rts								; 6
