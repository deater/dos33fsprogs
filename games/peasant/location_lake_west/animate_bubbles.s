
	;================
	; update bubbles
animate_bubbles_w:

	; 33,91
	; 27,125
	; 33,141
	; 35,115

	; bubble 1

	lda	FRAME
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#33
	sta	CURSOR_X
	lda	#91
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5


	; bubble 2

	lda	FRAME
	adc	#3
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#27
	sta	CURSOR_X
	lda	#125
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5

	; bubble 3

	lda	FRAME
	adc	#5
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#33
	sta	CURSOR_X
	lda	#141
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5

	; bubble 4

	lda	FRAME
	adc	#2
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#35
	sta	CURSOR_X
	lda	#115
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5

	rts


bubble_progress:
	.word bubble_sprite0
	.word bubble_sprite0
	.word bubble_sprite1
	.word bubble_sprite0
	.word bubble_sprite2
	.word bubble_sprite3
	.word bubble_sprite4
	.word bubble_sprite5




