
; Intro Knight

; o/~ One knight in Bangkok makes a hard man humble o/~


FRAME_KNIGHT_TEXT1 = $0		; FRAME 0..7 -- print river message
FRAME_KNIGHT_TEXT2 = $8		; FRAME 8..16 -- print nothing
FRAME_KNIGHT_TEXT3 = $18	; FRAME 17..?? -- print knight1 message
KNIGHT_WALKING_END = $19

	;========================
	; Knight
	;========================

intro_knight:
	lda	#0
	sta	FRAME
	sta	WALK_OVER

	;=========================
	; init peasant position
	; draw at 0,107

	lda	#0
	sta	PEASANT_X
	lda	#107
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR


	;=========================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<knight_priority_zx02
	sta	zx_src_l+1
	lda	#>knight_priority_zx02
	sta	zx_src_h+1

	lda	#>priority_temp			; temporarily load to $7000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy


	;=====================
	; load bg

	lda	#<(intro_knight_zx02)
	sta	zx_src_l+1
	lda	#>(intro_knight_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp

	;==================
	; print title line

	jsr	intro_print_title


	;==========================
	; knight walk loop setup
	;==========================

	lda	#0
	sta	WALK_COUNT

	lda	#18
	sta	WALK_DEST_X

	lda	#107
	sta	WALK_DEST_Y


	;=======================
	;=======================
	; knight walk loop
	;=======================
	;=======================

knight_walk_loop:

	;===========================
	; copy bg to current screen

	; also checks keyboard

	jsr	hgr_copy_faster


	;======================
	; draw peasant

	jsr	draw_peasant

	;======================
	; move peasant

	jsr	move_peasant_knight

	jsr	display_text_knight

;	jsr	wait_until_keypress

	;==========================
	; flip  page

	jsr	hgr_page_flip

	;========================
	; check if escape pressed

	lda	ESC_PRESSED
	bne	done_knight

	inc	FRAME


	lda	WALK_OVER
	beq	knight_walk_loop


	;===================
	; done

done_knight:

	rts


; continues displaying previous message

; stops as approach knight

;knight_message1:
;	.byte 0,35,34, 0,253,72
;	.byte 7,49,"OK go for it.",0


.if 0
knight_path:
	.byte 0,107
	.byte 1,107
	.byte 2,107
	.byte 3,107
	.byte 4,107
	.byte 5,107
	.byte 6,107
	.byte 7,107
	.byte 8,107
	.byte 9,107
	.byte 10,107
	.byte 11,107
	.byte 12,107
	.byte 13,107
	.byte 14,107
	.byte 15,107
	.byte 16,107
	.byte 17,107
	.byte 18,107
	.byte 18,107	; extra one so we end on PAGE1?
	.byte $FF,$FF

.endif

;score_text:
 ;       .byte 0,2,"Score: 0 of 150",0


	;=============================
	; move peasant_knight

move_peasant_knight:

	lda	FRAME

	cmp	#KNIGHT_WALKING_END
	bne	move_knight_done

	inc	WALK_OVER

move_knight_done:
	jsr	walk_to

	jsr	update_peasant_steps

	rts


	;=====================
	; handle text display
	;=====================
	; FRAME_KNIGHT_TEXT1 -- print river message
	; FRAME_KNIGHT_TEXT2 -- print nothing
	; FRAME_KNIGHT_TEXT3 -- print knight1 message

display_text_knight:
	lda	FRAME
check_knight_action1:
	cmp	#FRAME_KNIGHT_TEXT2
	bcs	check_knight_action2

	lda	#<river_message1
	sta	OUTL
	lda	#>river_message1
	sta	OUTH

	jsr	hgr_text_box

	jmp	done_knight_action

check_knight_action2:
	cmp	#FRAME_KNIGHT_TEXT3
	bcc	done_knight_action

check_knight_action3:

	lda	#<knight_message1
	sta	OUTL
	lda	#>knight_message1
	sta	OUTH

	jsr	hgr_text_box


done_knight_action:
	rts
