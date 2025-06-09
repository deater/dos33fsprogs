
	;================
	; animate bubbles E
animate_bubbles_e:

	; 5,94
	; 15,103
	; 13,130

	; bubble 1

	lda	FRAME
	and	#7
	asl
	tax

	lda	bubble_progress_e,X
	sta	INL
	inx
	lda	bubble_progress_e,X
	sta	INH

	lda	#5
	sta	CURSOR_X
	lda	#94
	sta	CURSOR_Y

	jsr	hgr_draw_sprite			;_1x5


	; bubble 2

	lda	FRAME
	adc	#3
	and	#7
	asl
	tax

	lda	bubble_progress_e,X
	sta	INL
	inx
	lda	bubble_progress_e,X
	sta	INH

	lda	#15
	sta	CURSOR_X
	lda	#103
	sta	CURSOR_Y

	jsr	hgr_draw_sprite			;_1x5

	; bubble 3

	lda	FRAME
	adc	#5
	and	#7
	asl
	tax

	lda	bubble_progress_e,X
	sta	INL
	inx
	lda	bubble_progress_e,X
	sta	INH

	lda	#13
	sta	CURSOR_X
	lda	#130
	sta	CURSOR_Y

	jmp	hgr_draw_sprite			;_1x5


bubble_progress_e:
	.word bubble_e_sprite0
	.word bubble_e_sprite0
	.word bubble_e_sprite1
	.word bubble_e_sprite0
	.word bubble_e_sprite2
	.word bubble_e_sprite3
	.word bubble_e_sprite4
	.word bubble_e_sprite5

;.include "sprites/bubble_sprites_e.inc"


