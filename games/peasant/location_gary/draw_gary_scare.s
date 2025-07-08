	;============================
	; draw gary being scared

	;============================
	; first move peasant to 105,119 (15,119)
	;	draw mask on head (also 15,119)
	;
	; 16 frames -- nothing, flies still move
	;  5 frames -- rear1 @ 49,117
	;  5 frames -- rear2 @ 49,115
	;  5 frames -- rear3 @ 49,112
	;  5 frames -- rear2
	;  5 frames -- rear1
	;  5 frames -- rear2
	;  5 frames -- rear3
	;  5 frames -- rear2
	;  5 frames -- rear1
	;  8 frames -- rear0	@49,120
	;  5 frames -- runleft0
	;  5 frames -- runleft1
	;  2 frames -- runleft2  ( 2 frames in fence breaks)
	;  2 frames -- runleft3  ( 2 frames in fence breaks)
	;  5 frames -- runleft4
	;  5 frames -- runleft5
	;	mask stays on until you walk again


draw_gary_scare:

	;============================
	; first move peasant to 105,119 (15,119)

	ldx	#15
	ldy	#119
	jsr	peasant_walkto

	;=============================
	; enable mask

	lda	#1
	sta	WEARING_MASK

	lda	#0
	sta	GARY_COUNT

scare_gary_loop:

	; draw screen

	jsr	update_screen

	ldy	GARY_COUNT
	ldx	scare_gary_which,Y

	lda	scare_gary_x,X
	sta	CURSOR_X
	lda	scare_gary_y,Y
	sta	CURSOR_Y

	lda	scare_gary_sprite_l,X
	sta	INL
	lda	scare_gary_sprite_h,X
	sta	INH

	jsr	hgr_draw_sprite

	;========================
	; flip pages

	jsr	hgr_page_flip

	inc	GARY_COUNT
	lda	GARY_COUNT
	bpl	scare_gary_loop

	;==================================
	; actually break fence and
	;	make passage to hidden glen

	jsr	gary_update_bg

	rts

scare_gary_x:
	.byte	7,7,7,7
	.byte	6,3,1,0,0,0

scare_gary_y:
	.byte	120,117,115,112
	.byte	115,117,119,102,102,102

scare_gary_sprite_l:
	.byte <gary_rear0,<gary_rear1,<gary_rear2,<gary_rear3
	.byte <gary_run0,<gary_run1,<gary_run2,<gary_run3
	.byte <gary_run4,<gary_run5

scare_gary_sprite_h:
	.byte >gary_rear0,>gary_rear1,>gary_rear2,>gary_rear3
	.byte >gary_run0,>gary_run1,>gary_run2,>gary_run3
	.byte >gary_run4,>gary_run5


scare_gary_which:
	.byte	0,0,0,0, 0,0,0,0
	.byte	1,1,2,2, 3,3,2,2,1,1
	.byte	2,2,3,3, 2,2,1,1
	.byte	0,0,0,0
	.byte	4,4,5,5, 6,7,8,8,9,9
	.byte	$FF

	; 16 frames -- nothing, flies still move
	;  5 frames -- rear1 @ 49,117
	;  5 frames -- rear2 @ 49,115
	;  5 frames -- rear3 @ 49,112
	;  5 frames -- rear2
	;  5 frames -- rear1
	;  5 frames -- rear2
	;  5 frames -- rear3
	;  5 frames -- rear2
	;  5 frames -- rear1
	;  8 frames -- rear0
	;  5 frames -- runleft0
	;  5 frames -- runleft1
	;  2 frames -- runleft2  ( 2 frames in fence breaks)
	;  2 frames -- runleft3  ( 2 frames in fence breaks)
	;  5 frames -- runleft4
	;  5 frames -- runleft5
	;	mask stays on until you walk again
