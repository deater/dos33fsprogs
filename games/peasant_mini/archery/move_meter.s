
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
	; new: METER_LEFT and METER_RIGHT are their actual coords
	;	minus 100 so fit in signed 8-bit
	;	so we need to add 100 before drawing

draw_meter_pointers:

	lda	#35			; 245/7 = 35
	sta	CURSOR_X

	clc
	lda	METER_LEFT
	adc	#METER_ADJUST
	sta	CURSOR_Y

	lda	#<l_pointer
	sta	INL
	lda	#>l_pointer

	sta	INH

	jsr	hgr_draw_sprite

	lda	#38			; 266/7 = 38
	sta	CURSOR_X

	clc
	lda	METER_RIGHT
	adc	#METER_ADJUST
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
	cmp	#METER_TOP
	bcs	meter_bounds_right

	; off scale, so peg
	lda	#METER_TOP
	sta	METER_LEFT

meter_bounds_right:
	lda	METER_RIGHT
	cmp	#METER_TOP
	bcs	meter_bounds_lr_done

	lda	#METER_TOP
	sta	METER_RIGHT
	lda	#6		; change to add plus 6
	sta	METER_ADD

meter_bounds_lr_done:

	; check if right goes off the end, if so
	; force a shot, also set R/L to 0?

	lda	METER_RIGHT
	cmp	#METER_START
	bcc	meter_bounds_done

	; off end on right

	lda	#METER_START
	sta	METER_RIGHT
	sta	METER_LEFT

	inc	METER_PRESSES

meter_bounds_done:

	rts
