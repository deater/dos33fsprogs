	;===================================
	; draw sound bars
	;===================================
draw_sound_bars:
	clc
	lda	DRAW_PAGE
	eor	#$4
	adc	#$7
	sta	dsb_smc1+2
	sta	dsb_smc2+2
	sta	dsb_smc3+2
	sta	dsb_smc4+2

	sta	dsb_smc5+2
	sta	dsb_smc6+2
	sta	dsb_smc7+2
	sta	dsb_smc8+2

	sta	dsb_smc9+2
	sta	dsb_smc10+2
	sta	dsb_smc11+2
	sta	dsb_smc12+2


	lda	A_VOLUME
	and	#$f
	lsr
	lsr
	tax
	lda	a_bar_top,X
dsb_smc1:
	sta	$750
dsb_smc2:
	sta	$775
	lda	a_bar_bottom,X
dsb_smc3:
	sta	$7d0
dsb_smc4:
	sta	$7f5

	lda	B_VOLUME
	and	#$f
	lsr
	lsr
	tax
	lda	b_bar_top,X
dsb_smc5:
	sta	$751
dsb_smc6:
	sta	$776
	lda	b_bar_bottom,X
dsb_smc7:
	sta	$7d1
dsb_smc8:
	sta	$7f6

	lda	C_VOLUME
	and	#$f
	lsr
	lsr
	tax
	lda	c_bar_top,X
dsb_smc9:
	sta	$752
dsb_smc10:
	sta	$777
	lda	c_bar_bottom,X
dsb_smc11:
	sta	$7d2
dsb_smc12:
	sta	$7f7



	rts

a_bar_top:
	.byte $00,$00,$20,$22

a_bar_bottom:
	.byte $00,$20,$22,$22

b_bar_top:
	.byte $00,$00,$40,$44

b_bar_bottom:
	.byte $00,$40,$44,$44

c_bar_top:
	.byte $00,$00,$60,$66

c_bar_bottom:
	.byte $00,$60,$66,$66


