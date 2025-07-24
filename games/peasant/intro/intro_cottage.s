; THATCHED ROOF COTTAGES

; More specifically, the Dashing Residence

intro_cottage:

	;========================
	; Cottage
	;========================

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

	;=============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<cottage_priority_zx02
	sta	zx_src_l+1
	lda	#>cottage_priority_zx02
	sta	zx_src_h+1

	lda	#>priority_temp		; temporarily load to $7000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy



	;==========================
	; load background to $6000

	lda	#<(cottage_zx02)
	sta	zx_src_l+1
	lda	#>(cottage_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp

	;===================
	; print title

	jsr	intro_print_title


	;====================
	;====================
	; walk loop
	;====================
	;====================

	lda	#0
	sta	WALK_COUNT

	lda	#1
	sta	PEASANT_XADD
	lda	#5
	sta	PEASANT_YADD

	jsr	update_walk

cottage_walk_loop:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;=======================
	; draw peasant

	jsr	draw_peasant


	;=====================
	; move peasant

	jsr	walk_to
	bcc	move_good

	jsr	update_walk
	bcs	done_cottage

move_good:


;	lda	FRAME
;	asl
;	tax

;	lda	cottage_path,X
;	bmi	done_cottage
;	sta	PEASANT_X

;	inx
;	lda	cottage_path,X
;	sta	PEASANT_Y




	;=======================
	; handle special actions
	;=======================
	; FRAMES  0 - ?      display cottage text 1, wait 25
	; FRAMES  1 - 12     display cottage text 2, wait 12 except wait 3 as 12
	; FRAMES 23 -        display cottage text 3
	;	we move this to 23 from 13?

	lda	FRAME
check_cottage_action1:
	cmp	#0
	bne	check_cottage_action2

	;========================
	; FRAME0: display cottage text 1

	lda	#<cottage_text1
	sta	OUTL
	lda	#>cottage_text1

	jmp	finish_cottage_action

check_cottage_action2:

	cmp	#23
	bcs	check_cottage_action3		; bgt


	;=============================
	; FRAME 1-22: display cottage text 2

	lda	#<cottage_text2
	sta	OUTL
	lda	#>cottage_text2
	jmp	finish_cottage_action

check_cottage_action3:

	;=========================
	; FRAME 23-?? display cottage text 3

	lda	#<cottage_text3
	sta	OUTL
	lda	#>cottage_text3

finish_cottage_action:
	sta	OUTH
	jsr	hgr_text_box

done_cottage_action:

	;======================
	; flip page

	jsr	hgr_page_flip


	;========================
	; drain keyboard buffer

	jsr	intro_drain_keyboard_buffer

	lda	ESC_PRESSED
	bne	done_cottage

	;======================
	; extra delays

	lda	FRAME
	bne	regular_wait

	; frame==0, wait 25
	lda	#25
	jsr	wait_a_bit
	jmp	now_wait

regular_wait:
;	lda	#DEFAULT_WAIT
now_wait:
;	jsr	wait_a_bit

	lda	ESC_PRESSED
	bne	done_cottage

	inc	FRAME

	jsr	really_move_peasant

	jmp	cottage_walk_loop


	;===================
	; done

done_cottage:

	rts




; even      odd
; 01234567 01234567


;cottage_text1:
;	.byte 0,52,24,  0,253,82
;	.byte 9,35,"YOU are Rather Dashing, a",13
;	.byte	   "humble peasant living in",13
;	.byte      "the peasant kingdom of",13
;	.byte      "Peasantry.",0

; wait a few seconds

;cottage_text2:
;	.byte 0,41,15, 0,255,96
;	.byte 8,25,"You return home from a",13
;	.byte	    "vacation on Scalding Lake",13
;	.byte	    "only to find that TROGDOR",13
;	.byte	    "THE BURNINATOR has",13
;	.byte	    "burninated your thatched",13
;	.byte	    "roof cottage along with all",13
;	.byte	    "your goods and services.",0

; wait a few seconds, then start walking toward cottage

;cottage_text3:
;	.byte	0,28,20, 0,252,86
;	.byte 7,33,"With nothing left to lose,",13
;	.byte	   "you swear to get revenge on",13
;	.byte	   "the Wingaling Dragon in the",13
;	.byte	   "name of burninated peasants",13
;	.byte	   "everywhere.",0

; Walk to edge of screen

	; note by default XADD=1,YADD=5
	;	though note originally only moved every other frame?

cottage_path:
	.byte 10,117		; 0 ; 5s, text 1
	.byte 10,117		; 1 ; 3s, text 2
	.byte 16,147
	.byte 38,147
	.byte $FF		; end

.if 0
cottage_path:
	.byte 10,117		; 0 ; 5s, text 1
	.byte 10,117		; 1 ; 3s, text 2
	; diagonal
	.byte 11,122
	.byte 12,127
	.byte 13,132
	.byte 14,137
	.byte 15,142
	.byte 16,147
	; horizontal
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

.endif

update_walk:
	ldy	WALK_COUNT

	lda	cottage_path,Y
	cmp	#$ff
	beq	update_walk_done
	sta	WALK_DEST_X

	iny

	lda	cottage_path,Y
	sta	WALK_DEST_Y

	inc	WALK_COUNT
	inc	WALK_COUNT


	clc
	rts
update_walk_done:
	sec
	rts

