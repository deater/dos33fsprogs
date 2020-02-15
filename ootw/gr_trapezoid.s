	; Draws a filled trapezoid in the screen
	; note it is blocky (even/odd Y always set) for simplicity

	; TODO: use 5.3 fixed point rather than 8.8?

	; called pointing INL/INH to data structure:
	;	.byte LEFT_SLOPE_H,LEFT_SLOPE_L
	;	.byte RIGHT_SLOPE_H,RIGHT_SLOPE_L
	;	.byte START_X_H,START_X_L
	;	.byte END_X_H,END_X_L
	;	.byte END_Y,START_Y

	; if START_Y=$ff then draw bullet-hole on background at left_slopeh/l

	; color is trapezoid_color_smc+1, usually it's going to be #$11 (red)

	; 10 bytes/trapezoid?  Much smaller than a say 10x5 sprite

draw_trapezoid:
	; FIXME: make this a loop

	ldy	#0
trapezoid_load_loop:
	lda	(INL),Y
	sta	trapezoid_left_slope,Y
	iny
	cpy	#8
	bne	trapezoid_load_loop

	lda	(INL),Y
	sta	trapezoid_endy_smc+1
	iny
	lda	(INL),Y
	tay
	bmi	draw_bullethole

draw_trapezoid_loop:

	lda	gr_offsets,Y
	sta	trapezoid_draw_loop_smc+1

	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	trapezoid_draw_loop_smc+2

trapezoid_color_smc:
	lda	#$11

	ldx	trapezoid_x_start

	bmi	trap_clamp0
	cpx	#40
	bcc	trapezoid_draw_loop		; blt

	ldx	#39
	jmp	trapezoid_draw_loop

trap_clamp0:
	ldx	#0
	jmp	trapezoid_draw_loop

trapezoid_draw_loop:
trapezoid_draw_loop_smc:
	sta	$c00,X
	inx
	cpx	trapezoid_x_end
	bne	trapezoid_draw_loop

	; add in 8.8 fixed point (should we make this 6.2 or 5.3 instead?)
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

draw_bullethole:
	ldy	trapezoid_left_slope+1		; get Y value
	lda	gr_offsets,Y
	clc
	adc	trapezoid_left_slope
	sta	bullethole_draw_loop_smc+1

	lda	gr_offsets+1,Y
	clc
	adc	#$8				; to background page $c00?
	sta	bullethole_draw_loop_smc+2

bullethole_draw:
	ldy	#3
bullethole_draw_loop:
	lda	#$66
bullethole_draw_loop_smc:
	sta	$c00,Y
	dey
	bne	bullethole_draw_loop

	rts


trapezoid_left_slope:
	.byte 0,0
trapezoid_right_slope:
	.byte 0,0
trapezoid_x_start:
	.byte 0,0
trapezoid_x_end:
	.byte 0,0


