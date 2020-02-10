
	; color -> trapezoid_color_smc+1
	; width -> trapezoid_width_smc+1
	; starty = Y
	; endy  -> trapezoid_endy_smc+1
	; startx-> trapezoid_startx_smc+1
	; LEFTSLOPE, RIGHTSLOPE

draw_trapezoid:

draw_trapezoid_loop:

;	clc
;	lda	trapezoid_x_start
	lda	gr_offsets,Y
	sta	trapezoid_draw_loop_smc+1

	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	trapezoid_draw_loop_smc+2

trapezoid_color_smc:
	lda	#$11
	ldx	trapezoid_x_start

trapezoid_draw_loop:
trapezoid_draw_loop_smc:
	sta	$c00,X
	inx
	cpx	trapezoid_x_end
	bne	trapezoid_draw_loop

	; add in 8.8 fixed point (should we make this 6.2 instead?
	clc
	lda	trapezoid_x_start+1
	adc	trapezoid_left_slope+1
	sta	trapezoid_x_start+1

	lda	trapezoid_x_start
	adc	trapezoid_left_slope
	sta	trapezoid_x_start

	clc
	lda	trapezoid_x_end+1
	adc	trapezoid_right_slope+1
	sta	trapezoid_x_end+1

	lda	trapezoid_x_end
	adc	trapezoid_right_slope
	sta	trapezoid_x_end


	dey
	dey
trapezoid_endy_smc:
	cpy	#0
	bne	draw_trapezoid_loop

	rts


trapezoid_x_start:
	.byte 0,0
trapezoid_left_slope:
	.byte 0,0
trapezoid_x_end:
	.byte 0,0
trapezoid_right_slope:
	.byte 0,0

