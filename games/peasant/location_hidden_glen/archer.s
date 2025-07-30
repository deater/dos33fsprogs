	;===================
	; draw archer
	;===================
	; draw archer animation and arrow
	;	see lower down for the progression
	; TODO: handle when someone stands in way

draw_archer:
	; first check if he's there
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	skip_draw_archer

	lda	ARCHER_COUNT
	cmp	#35
	bne	no_reset_archer

	lda	#0
	sta	ARCHER_COUNT

no_reset_archer:

	ldy	ARCHER_COUNT
	ldx	archer_lookup,Y

	lda	archer_sprites_l,X
	sta	INL
	lda	archer_sprites_h,X
	sta     INH

	lda	#27			; 189/7
	sta	CURSOR_X
	lda	#81
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	;=========================
	; draw arrow if necessary

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_ARROW
	bne	done_draw_arrow

	lda	ARCHER_COUNT
	cmp	#30
	bcc	done_draw_arrow

	sec		; get arrow pointer, which is 30 less
	sbc	#30
	tay

	ldx	arrow_lookup,Y

	lda	arrow_sprites_l,X
	sta	INL
	lda	arrow_sprites_h,X
	sta     INH

	lda	arrow_x_lookup,Y
	sta	CURSOR_X
	lda	arrow_y_lookup,Y
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


done_draw_arrow:
	;=========================
	; move to next frame
	;	only if not being arrowed

	lda	ARROWED_COUNT
	bne	skip_inc_archer

	inc	ARCHER_COUNT

skip_inc_archer:

skip_draw_archer:

	rts



archer_sprites_l:
	.byte <archer0,<archer1,<archer2,<archer3
	.byte <archer4,<archer5,<archer6,<archer7
	.byte <archer8,<archer9

archer_sprites_h:
	.byte >archer0,>archer1,>archer2,>archer3
	.byte >archer4,>archer5,>archer6,>archer7
	.byte >archer8,>archer9

arrow_sprites_l:
	.byte <arrow0,<arrow1,<arrow2,<arrow3

arrow_sprites_h:
	.byte >arrow0,>arrow1,>arrow2,>arrow3


	; Archer   Frames	Arrow	Arrow X    Arrow Y
	; #8         15  0
	; #9          2 15
	; #0          1 17
	; #1          1 18
	; #2          3 19
	; #3          2 22
	; #4          2 24
	; #5          3 26
	; #6          1 29
	; #6          1 30        0     168 (24)     89
	; #6          1 31        1     147 (21)     88
	; #6          1 32        0     126 (18)     87
	; #7          1 33        2     105 (15)     86
	; #8          1 34        3      91 (13)     85
	;================================================
	;             35

archer_lookup:
	.byte	8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	.byte	9,9,0,1,2,2,2
	.byte	3,3,4,4,5,5,5
	.byte	6,6,6,6,7,8

arrow_lookup:
	.byte	0,1,0,2,3

arrow_x_lookup:
	.byte	24,21,18,15,13

arrow_y_lookup:
	.byte	89,88,87,86,85
