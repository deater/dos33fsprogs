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

	; note Y has feed on base of root

	;					X
	; frame1:	arrowed0 (from left)	same
	; frame2:	arrowed1 (in tree)	112 or so
	; frame3:	arrowed2		105 or so
	; frame4:	arrowed3		105 or so
	; frame5:	arrowed4
	; frame6:   	arrowed3
	; frame7:	arrowed5
	; frame8:	arrowed4
	; frame9:	arrowed3
	; frame10:	arrowed5
	; frame11:	arrowed3 for like 20 frames

range_intrusion_action:


archer_ohno_loop:
	jsr	update_screen

	jsr	hgr_page_flip

	lda	ARCHER_COUNT
	cmp	#29		; 15 is when a shot is started
	bcc	archer_ohno_loop


	;==================
	; this kills you


	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts
