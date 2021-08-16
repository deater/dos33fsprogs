; THATCHED ROOF COTTAGES
; More specifically, the Dashing Residence

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

;	jsr	hgr_save

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

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_7x30


	;=======================
	; draw peasant


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


	;========================
	; handle special


	lda	FRAME
check_cottage_action1:
	cmp	#0
	bne	check_cottage_action2

	; display cottage text 1

	lda	#<cottage_text1
	sta	OUTL
	lda	#>cottage_text1

	jmp	finish_cottage_action

check_cottage_action2:
	cmp	#1
	bne	check_cottage_action3
	jsr	hgr_partial_restore

	; display cottage text 2

	lda	#<cottage_text2
	sta	OUTL
	lda	#>cottage_text2

	jmp	finish_cottage_action

check_cottage_action3:
	cmp	#13
	bne	done_cottage_action
	jsr	hgr_partial_restore

	; display cottage text 3

	lda	#<cottage_text3
	sta	OUTL
	lda	#>cottage_text3

finish_cottage_action:
	sta	OUTH
	jsr	hgr_text_box

done_cottage_action:



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

	lda	ESC_PRESSED
	bne	done_cottage

	inc	FRAME

	jmp	cottage_walk_loop


	;===================
	; done

done_cottage:

	rts








peasant_text:
	.byte 25,2,"Peasant's Quest",0


cottage_text1:
	.byte 0,53,24,  0,253,82
	.byte 9,35,"YOU are Rather Dashing, a",13
	.byte	   "humble peasant living in",13
	.byte      "the peasant kingdom of",13
	.byte      "Peasantry.",0

; wait a few seconds

cottage_text2:
	.byte 0,40,15, 0,255,96
	.byte 8,25,"You return home from a",13
	.byte	    "vacation on Scalding Lake",13
	.byte	    "only to find that TROGDOR",13
	.byte	    "THE BURNINATOR has",13
	.byte	    "burninated your thatched",13
	.byte	    "roof cottage along with all",13
	.byte	    "your goods and services.",0

; wait a few seconds, then start walking toward cottage

cottage_text3:
	.byte	0,28,20, 0,252,86
	.byte 7,33,"With nothing left to lose,",13
	.byte	   "you swear to get revenge on",13
	.byte	   "the Wingaling Dragon in the",13
	.byte	   "name of burninated peasants",13
	.byte	   "everywhere.",0

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


