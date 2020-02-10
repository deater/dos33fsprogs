
	; color -> trapezoid_color_smc+1
	; width -> trapezoid_width_smc+1
	; starty = Y
	; endy  -> trapezoid_endy_smc+1
	; startx-> trapezoid_startx_smc+1
	; LEFTSLOPE, RIGHTSLOPE

draw_trapezoid:


draw_trapezoid_loop:

	clc
trapezoid_startx_smc:
	lda	#5
	adc	gr_offsets,Y
	sta	trapezoid_draw_loop_smc+1

	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	trapezoid_draw_loop_smc+2

trapezoid_color_smc:
	lda	#$11
trapezoid_width_smc:
	ldx	#0

trapezoid_draw_loop:
trapezoid_draw_loop_smc:
	sta	$c00,X
	dex
	bne	trapezoid_draw_loop

	dey
	dey
trapezoid_endy_smc:
	cpy	#0
	bne	draw_trapezoid_loop

	rts
