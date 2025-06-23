; putting these here because can never remember where to stick
; global init that's guaranteed to get run

init_global_vars:
	lda	#0
	sta	DRAW_PAGE
	sta	INPUT_X		; text pointer
	sta	KEY_OFFSET	; keyboard buffer pointer

	rts
