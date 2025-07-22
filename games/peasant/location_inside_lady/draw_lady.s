
	;========================
	; draw lady / chair
	;========================

draw_lady:

	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	draw_chair

	lda	FRAME
	and	#$f
	lsr
	tax
	lda	lady_frame_which,X

	tax
	lda	lady_sprites_l,X
	sta	INL
	lda	lady_sprites_h,X
	sta	INH

	lda	#18		; 126/7
	sta     CURSOR_X
	lda	#127
	sta	CURSOR_Y

        jsr     hgr_draw_sprite

	rts


draw_chair:

	lda	FRAME
	and	#$f
	lsr
	tax
	lda	lady_frame_which,X

	tax
	lda	chair_sprites_l,X
	sta	INL
	lda	chair_sprites_h,X
	sta	INH

	lda	#18			; 126/7 = 18
	sta     CURSOR_X
	lda	#131
	sta	CURSOR_Y

        jsr     hgr_draw_sprite		; tail call?

	rts

	;==================================
	; update priority map if lady gone
update_priority_chair:
	lda	GAME_STATE_0
	and	#LADY_GONE
	beq	lady_still_there

	; 463 CC->c1
	; 464 CC->c1
	lda	#$C1
	sta	$463
	sta	$464

	; 4E2 c1->11
	; 7bb c1->11
	; 7bc c1->11

	lda	#$11
	sta	$4e2
	sta	$7bb
	sta	$7bc

lady_still_there:

	rts



lady_frame_which:
	.byte 0,1,1,2,2,1,1,0	; FIXME

lady_sprites_l:
	.byte <lady_rock0,<lady_rock1,<lady_rock2

lady_sprites_h:
	.byte >lady_rock0,>lady_rock1,>lady_rock2

chair_sprites_l:
	.byte <chair0,<chair1,<chair2

chair_sprites_h:
	.byte >chair0,>chair1,>chair2

