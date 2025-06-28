
	;=====================
	; update river current

animate_river:

	lda	FRAME
	and	#4
	beq	draw_current1
draw_curent2:

	lda	#<current_sprite0
	sta	INL
	lda	#>current_sprite0
	jmp	draw_current_common

draw_current1:

	lda	#<current_sprite1
	sta	INL
	lda	#>current_sprite1

draw_current_common:

	sta	INH

	lda	#4			; 28/7
	sta	CURSOR_X
	lda	#143
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	rts


