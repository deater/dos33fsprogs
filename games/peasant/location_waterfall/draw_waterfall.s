do_waterfall:

	;===================================
	; animate waterfall (if applicable)

	; leave at BG 4 frames, draw 4 frames

	lda	FRAME
	and	#$7
	cmp	#4
	bcs	leave_waterfall_alone

draw_waterfall:

	lda	#36
	sta	CURSOR_X
	lda	#94
	sta	CURSOR_Y

	lda	#<waterfall_sprite
	sta	INL
	lda	#>waterfall_sprite
	sta	INH

	jsr	hgr_draw_sprite

leave_waterfall_alone:



