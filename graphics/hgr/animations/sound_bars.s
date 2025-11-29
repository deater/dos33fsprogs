	;===================================
	; draw sound bars
	;===================================
draw_sound_bars:

	clc
	lda	DRAW_PAGE
	adc	#$23
	sta	dsb_smc1+2
	lda	#$E2
	sta	dsb_smc1+1

	ldy	#0
dsb_loop:
	ldx	#0
draw_bar_xloop:
	lda	A_VOLUME,X
	and	#$f
	lsr
	sta	TEMP_VOL
	cpy	TEMP_VOL
	bcs	bar_yes		; bge

bar_none:
	lda	#0
	beq	draw_bar	; bra
bar_yes:
	lda	bar_colors,X

draw_bar:
dsb_smc1:
	; 21A8 = left centered veritcally
	; 23E4 = bottom centered horizontally

	sta	$23E3,X

	inx
	cpx	#3
	bne	draw_bar_xloop

	lda	dsb_smc1+2
	clc
	adc	#$4
	sta	dsb_smc1+2

	iny
	cpy	#8
	bne	dsb_loop


	rts

bar_colors:
	.byte $85,$8f,$8a

