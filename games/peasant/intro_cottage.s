; THATCHED ROOF COTTAGES

cottage:

	;************************
	; Cottage
	;************************

	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 70,117

	lda	#10
	sta	PEASANT_X
	lda	#117
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	;==================
	; draw background

	lda	#<(cottage_lzsa)
	sta	getsrc_smc+1
	lda	#>(cottage_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	;===================
	; print title

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	jsr	hgr_save

	;====================
	; save background

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	;=======================
	; walking

	jsr	save_bg_7x30

cottage_walk_loop:
	jsr	restore_bg_7x30

	lda	FRAME
check_cottage_action1:
	cmp	#0
	bne	check_cottage_action2
	jsr	display_cottage_text1
	jmp	done_cottage_action

check_cottage_action2:
	cmp	#1
	bne	check_cottage_action3
	jsr	hgr_restore
	jsr	display_cottage_text2
	jmp	done_cottage_action

check_cottage_action3:
	cmp	#13
	bne	done_cottage_action
	jsr	hgr_restore
	jsr	display_cottage_text3

done_cottage_action:

	lda	FRAME
	asl
	tax

	lda	cottage_path,X
	bmi	done_cottage
	sta	PEASANT_X
	sta	CURSOR_X

	inx
	lda	cottage_path,X
	sta	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_7x30

	jsr	draw_peasant

;	jsr	wait_until_keypress

	lda	FRAME
	bne	special2
	lda	#25
	jmp	now_wait
special2:
	cmp	#1
	bne	regular_wait
	lda	#12
	jmp	now_wait

regular_wait:
	lda	#3
now_wait:
	jsr	wait_a_bit

	inc	FRAME

	jmp	cottage_walk_loop


	;===================
	; done

done_cottage:

	rts


	;============================
	; display cottage text 1
	;============================
display_cottage_text1:

	;====================
	; draw text box

	lda	#0
	sta	BOX_X1H
	lda	#53
	sta	BOX_X1L
	lda	#24
	sta	BOX_Y1

	lda	#0
	sta	BOX_X2H
	lda	#253
	sta	BOX_X2L
	lda	#82
	sta	BOX_Y2

	jsr	draw_box

	lda	#<cottage_text1
	sta	OUTL
	lda	#>cottage_text1
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	rts


	;============================
	; display cottage text 2
	;============================
display_cottage_text2:

	;====================
	; draw text box

	lda	#0
	sta	BOX_X1H
	lda	#40
	sta	BOX_X1L
	lda	#15
	sta	BOX_Y1

	lda	#0
	sta	BOX_X2H
	lda	#255
	sta	BOX_X2L
	lda	#96
	sta	BOX_Y2

	jsr	draw_box

	lda	#<cottage_text2
	sta	OUTL
	lda	#>cottage_text2
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	rts

	;============================
	; display cottage text 3
	;============================
display_cottage_text3:

	;====================
	; draw text box

	lda	#0
	sta	BOX_X1H
	lda	#30
	sta	BOX_X1L
	lda	#20
	sta	BOX_Y1

	lda	#0
	sta	BOX_X2H
	lda	#253
	sta	BOX_X2L
	lda	#86
	sta	BOX_Y2

	jsr	draw_box



	lda	#<cottage_text3
	sta	OUTL
	lda	#>cottage_text3
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	rts

peasant_text:
	.byte 25,2,"Peasant's Quest",0


cottage_text1:
	.byte 9,35,"YOU are Rather Dashing, a",0
	.byte 9,44,"humble peasant living in",0
	.byte 9,53,"the peasant kingdom of",0
	.byte 9,62,"Peasantry.",0

; wait a few seconds

cottage_text2:
	.byte 8,25,"You return home from a",0
	.byte 8,33,"vacation on Scalding Lake",0
	.byte 8,41,"only to find that TROGDOR",0
	.byte 8,49,"THE BURNINATOR has",0
	.byte 8,57,"burninated your thatched",0
	.byte 8,65,"roof cottage along with all",0
	.byte 8,73,"your goods and services.",0

; wait a few seconds, then start walking toward cottage

cottage_text3:
	.byte 7,33,"With nothing left to lose,",0
	.byte 7,41,"you swear to get revenge on",0
	.byte 7,49,"the Wingaling Dragon in the",0
	.byte 7,57,"name of burninated peasants",0
	.byte 7,65,"everywhere.",0

; Walk to edge of screen



cottage_path:
	.byte 10,117		; 0 ; 5s, text 1
	.byte 10,117		; 1 ; 3s, text 2
	.byte 11,122
	.byte 12,127
	.byte 13,132
	.byte 14,137
	.byte 15,142
	.byte 16,147
	.byte 17,147
	.byte 18,147
	.byte 19,147
	.byte 20,147
	.byte 21,147
	.byte 22,147
	.byte 23,147		; text 3
	.byte 24,147
	.byte 25,147
	.byte 26,147
	.byte 27,147
	.byte 28,147
	.byte 29,147
	.byte 30,147
	.byte 31,147
	.byte 32,147
	.byte 33,147
	.byte 34,147
	.byte 35,147
	.byte 36,147
	.byte 37,147
	.byte 38,147
	.byte $FF,$FF


