	;===============================
	; hlin
	;===============================
	; Y = y position
	; A = start
	; X = length
hlin:
	clc
	adc	gr_offsets,Y
	sta	hlin_smc1+1
	sta	hlin_smc2+1

	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	hlin_smc1+2
	sta	hlin_smc2+2


hlin_loop:

hlin_smc1:
	lda	$c00,X
hlin_mask_smc:
	and	#$f0
hlin_color_smc:
	ora	#$01
hlin_smc2:
	sta	$c00,X

	dex
	bpl	hlin_loop

	rts
