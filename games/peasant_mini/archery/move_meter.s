
	;===========================
	; draw meter bottom
	;===========================
	; it gets erased by the bow
draw_meter_bottom:

	lda	#36			; 252/7 = 36
	sta	CURSOR_X

	lda	#149
	sta	CURSOR_Y

	lda	#<meter_bottom
	sta	INL
	lda	#>meter_bottom

	sta	INH

	jmp	hgr_draw_sprite		; tail call


	;===========================
	; draw meter pointers
	;===========================

	; original:
	; draw at 116+(14-METER_LEFT)*4
	;	so if 0, should be 172

	; modified:
	;	draw at 108+(64-METER_LEFT)


	; new: METER_LEFT and METER_RIGHT are their actual coords

draw_meter_pointers:

	lda	#35			; 245/7 = 35
	sta	CURSOR_X

;	lda	#64
;	sec
;	sbc	METER_LEFT
;	clc
;	adc	#108

;	lda	#14
;	sec
;	sbc	METER_LEFT
;	asl
;	asl
;	clc
;	adc	#116

	lda	METER_LEFT
	sta	CURSOR_Y

	lda	#<l_pointer
	sta	INL
	lda	#>l_pointer

	sta	INH

	jsr	hgr_draw_sprite

	lda	#38			; 266/7 = 38
	sta	CURSOR_X

;	lda	#64
;	sec
;	sbc	METER_RIGHT
;	clc
;	adc	#108

;	lda	#14
;	sec
;	sbc	METER_RIGHT
;	asl
;	asl
;	clc
;	adc	#116

	lda	METER_RIGHT
	sta	CURSOR_Y

	lda	#<r_pointer
	sta	INL
	lda	#>r_pointer

	sta	INH

	jsr	hgr_draw_sprite

	rts


	;===========================
	; erase meter pointers
	;===========================
	;

erase_meter_pointers:

	lda	#35			; 245/7 = 35
	sta	CURSOR_X

	lda	#105
	sta	CURSOR_Y

	lda	#<l_pointer_erase
	sta	INL
	lda	#>l_pointer_erase
	sta	INH

	jsr	hgr_draw_sprite

	lda	#38			; 266/7 = 38
	sta	CURSOR_X

	lda	#105
	sta	CURSOR_Y

	lda	#<r_pointer_erase
	sta	INL
	lda	#>r_pointer_erase
	sta	INH

	jsr	hgr_draw_sprite

	rts

	;=======================
	; move power meter
	;=======================
	; if keypress 1st add/subtract 5 from left/right
	; if keypress 2nd add/subtract 6 from right
move_power_meter:
	lda	METER_PRESSES
	cmp	#1
	bcs	move_right_meter

	; otherwise move both

move_left_meter:
	clc
	lda	METER_LEFT
	adc	METER_ADD
	sta	METER_LEFT

move_right_meter:
	clc
	lda	METER_RIGHT
	adc	METER_ADD
	sta	METER_RIGHT

	; bounds check

meter_bounds_left:
	lda	METER_LEFT
	cmp	#106
	bcs	meter_bounds_right

	; off scale, so peg
	lda	#106
	sta	METER_LEFT

meter_bounds_right:
	lda	METER_RIGHT
	cmp	#106
	bcs	meter_bounds_lr_done

	lda	#106
	sta	METER_RIGHT
	lda	#6		; change to add plus 6
	sta	METER_ADD

meter_bounds_lr_done:

	; check if right goes off the end, if so
	; force a shot, also set R/L to 0?

	lda	METER_RIGHT
	cmp	#172
	bcc	meter_bounds_done

	; off end on right

	lda	#172
	sta	METER_RIGHT
	sta	METER_LEFT

	inc	METER_PRESSES

meter_bounds_done:

	rts
