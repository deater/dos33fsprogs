	;==============================================
	; wait for pause in shooting, then walk in way

range_intrusion_setup:
	;============================
	; wait for arrow to be done

archer_wait:
	jsr	update_screen

	jsr	hgr_page_flip

	lda	ARCHER_COUNT
	cmp	#15		; 15 is when a shot is started
	bcs	archer_wait


	lda	#0		; clear out to beginning?
	sta	ARCHER_COUNT

	;=========================
	; walk to right position

	ldx	#20			; 140
	ldy	#84
	jsr	peasant_walkto

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	rts


	;====================================
	; animate the shot
	;====================================
	; starts when arrow first beyond bow
	; oddly it draws that arrow and one in head at same time

	; note Y has feet on base of root

	;					X
	; frame1:	arrowed0 (from left)	140 or so (20)
	; frame2:	arrowed1 (in tree)	112 or so (16)
	; frame3:	arrowed2		105 or so (15)
	; frame4:	arrowed3		105 or so (15)
	; frame5:	arrowed4
	; frame6:   	arrowed3
	; frame7:	arrowed5
	; frame8:	arrowed4
	; frame9:	arrowed3
	; frame10:	arrowed5
	; frame11:	arrowed3 for like 20 frames

	; seems to arrive with ARCHER_COUNT as $05
	; 15 is when he starts drawing arrow
	; 30 is when shot happens

range_intrusion_action:


archer_ohno_loop:
	; load ARCHER COUNT
	; if >=30, SUPPRESS PEASANT AND ARROW

	jsr	update_screen

	;=====================
	; draw arrow aftermath

	lda	ARCHER_COUNT
	cmp	#30
	bcc	not_arrowed_yet

do_animation:
	lda	#(SUPPRESS_PEASANT|SUPPRESS_ARROW)
	sta	SUPPRESS_DRAWING

	ldy	ARROWED_COUNT
	ldx	arrowed_progress,Y

	lda	arrowed_l,X
	sta	INL
	lda	arrowed_h,X
	sta	INH

	lda	arrowed_x,X
	sta	CURSOR_X
	lda	#84
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	inc	ARROWED_COUNT

not_arrowed_yet:


	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	lda	ARROWED_COUNT
	cmp	#20		;
	bcc	archer_ohno_loop

	;====================
	; draw us in background so there for dialog

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	lda	#$40
	sta	DRAW_PAGE		; draw to $6000

	lda	#<arrowed3
	sta	INL
	lda	#>arrowed3
	sta	INH

	lda	#15
	sta	CURSOR_X
	lda	#84
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	;==================
	; this kills you


	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts

arrowed_progress:
	.byte	0,1,2,3, 4,3,5,4
	.byte	3,5,3,3, 3,3,3,3
	.byte	3,3,3,3

arrowed_x:
	.byte	20,16,15,15,15,15

arrowed_l:
	.byte	<arrowed0,<arrowed1,<arrowed2,<arrowed3,<arrowed4,<arrowed5

arrowed_h:
	.byte	>arrowed0,>arrowed1,>arrowed2,>arrowed3,>arrowed4,>arrowed5

