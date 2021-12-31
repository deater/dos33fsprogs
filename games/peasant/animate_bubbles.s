
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

	jsr	hgr_draw_sprite			;_1x5

	rts


bubble_progress_e:
	.word bubble_e_sprite0
	.word bubble_e_sprite0
	.word bubble_e_sprite1
	.word bubble_e_sprite0
	.word bubble_e_sprite2
	.word bubble_e_sprite3
	.word bubble_e_sprite4
	.word bubble_e_sprite5

.include "sprites/bubble_sprites_e.inc"

.if 0
bubble_e_sprite0:
	.byte 1,5
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $80	; 1 000 0000	0 00 00 00	KKKKKKK
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB

bubble_e_sprite1:
	.byte 1,5
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $A2	; 1 010 0010	0 10 00 10	BBBKKBB

bubble_e_sprite2:
	.byte 1,5
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $A2	; 1 010 0010	0 10 00 10	BBBKKBB
	.byte $88+++	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB

bubble_e_sprite3:
	.byte 1,5
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $A2	; 1 010 0010	0 10 00 10	BBBKKBB
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB

bubble_e_sprite4:
	.byte 1,5
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $A2	; 1 010 0010	0 10 00 10	BBBKKBB
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB

bubble_e_sprite5:
	.byte 1,5
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $A2	; 1 010 0010	0 10 00 10	BBBKKBB
	.byte $88	; 1 000 1000	0 00 10 00	KKKBBKK
	.byte $AA	; 1 010 1010	0 10 10 10	BBBBBBB
.endif

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


	.include "sprites/bubble_sprites_w.inc"

.if 0
bubble_sprite0:
	.byte 1,5
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP
	.byte $AA	; 1 010 1010	0 +10 10 10 BBBBBBB
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP
	.byte $80	; 1 000 0000	0 00 00 00 KKKKKKK
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP

bubble_sprite1:
	.byte 1,5
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP
	.byte $AA	; 1 010 1010	0 10 10 10 BBBBBBB
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP
	.byte $88	; 1 000 1000	0 00 10 00 KKKBBKK
	.byte $22	; 0 010 0010	0 10 00 10 PPPKKPP

bubble_sprite2:
	.byte 1,5
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP
	.byte $AA	; 1 010 1010	0 10 10 10 BBBBBBB
	.byte $22	; 0 010 0010	0 10 00 10 PPPKKPP
	.byte $88	; 1 000 1000	0 00 10 00 KKKBBKK
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP

bubble_sprite3:
	.byte 1,5
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP
	.byte $A2	; 1 010 0010	0 10 00 10 BBBKKBB
	.byte $08	; 0 000 1000	0 00 10 00 KKKPPKK
	.byte $88	; 1 000 1000	0 00 10 00 KKKBBKK
	.byte $2A	; 0 010 1010	0 10 10 10 PPPPPPP

bubble_sprite4:
	.byte 1,5
	.byte $08	; 0000 1000	0 00 10 00 KKKPPKK
	.byte $A2	; 1010 0010	0 10 00 10 BBBKKBB
	.byte $08	; 0000 1000	0 00 10 00 KKKPPKK
	.byte $88	; 1000 1000	0 00 10 00 KKKBBKK
	.byte $2A	; 0010 1010	0 10 10 10 PPPPPPP

bubble_sprite5:
	.byte 1,5
	.byte $2A	; 0010 1010	0 10 10 10 PPPPPPP
	.byte $88	; 1000 1000	0 00 10 00 KKKBBKK
	.byte $22	; 0010 0010	0 10 00 10 PPPKKPP
	.byte $88	; 1000 1000	0 00 10 00 KKKBBKK
	.byte $2A	; 0010 1010	0 10 10 10 PPPPPPP

.endif
