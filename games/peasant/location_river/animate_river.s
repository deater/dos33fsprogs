
	;================
	; update bubbles river

animate_river:

	; 5,166
	; 9,154
	; 7,160

	; bubble 1

	lda	FRAME
	and	#3
	asl
	tax

	lda	bubble_progress_r,X
	sta	INL
	inx
	lda	bubble_progress_r,X
	sta	INH

	lda	#5
	sta	CURSOR_X
	lda	#166
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5


	; bubble 2

	lda	FRAME
	adc	#3
	and	#3
	asl
	tax

	lda	bubble_progress_r,X
	sta	INL
	inx
	lda	bubble_progress_r,X
	sta	INH

	lda	#9
	sta	CURSOR_X
	lda	#154
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5

	; bubble 3

	lda	FRAME
	adc	#5
	and	#3
	asl
	tax

	lda	bubble_progress_r,X
	sta	INL
	inx
	lda	bubble_progress_r,X
	sta	INH

	lda	#7
	sta	CURSOR_X
	lda	#160
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;_1x5

	rts


bubble_progress_r:
	.word bubble_r_sprite0
	.word bubble_r_sprite0
	.word bubble_r_sprite1
	.word bubble_r_sprite1


	.include "sprites/river_bubble_sprites.inc"

.if 0
bubble_r_sprite0:
	.byte 1,5
	.byte $AA	; 1010 1010	0 10 10 10	BBBBBBB
	.byte $FF	; 1111 1111	1 11 11 11	WWWWWWW
	.byte $AA	; 1010 1010	0 10 10 10	BBBBBBB
	.byte $FF	; 1111 1111	1 11 11 11	WWWWWWW
	.byte $AA	; 1010 1010	0 10 10 10	BBBBBBB

bubble_r_sprite1:
	.byte 1,5
	.byte $FF	; 1111 1111	1 11 11 11	WWWWWWW
	.byte $AA	; 1010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1010 1010	0 10 10 10	BBBBBBB
	.byte $FF	; 1111 1111	1 11 11 11	WWWWWWW

.endif
