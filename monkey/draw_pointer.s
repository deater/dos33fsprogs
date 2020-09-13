	;====================================
	; draw pointer
	;====================================
	; actual game it sorta pulses colors

draw_pointer:

	; point sprite to right location (X,Y)

	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	lda     #<pointer_sprite
	sta	INL
	lda     #>pointer_sprite
	sta	INH
	jsr	put_sprite_crop

no_draw_pointer:
	rts

