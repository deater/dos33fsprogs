; o/~ At the beautiful, the beautiful, River o/~

	;========================
	; River
	;========================

intro_river:
	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 33,157

	lda	#33
	sta	PEASANT_X
	lda	#157
	sta	PEASANT_Y

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

	;========================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<river_priority_zx02
	sta	zx_src_l+1
	lda	#>river_priority_zx02
	sta	zx_src_h+1

	lda	#$60			; temporarily load to $6000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy


	;====================
	; load bg to $6000


	lda	#<(river_zx02)
	sta	zx_src_l+1
	lda	#>(river_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp


	;================
	; print title

	jsr	intro_print_title


	;=======================
	;=======================
	; river walk loop
	;=======================
	;=======================

river_walk_loop:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;====================
	; draw peasant

	lda	FRAME
	asl
	tax

	lda	river_path,X
	bmi	done_river
	sta	PEASANT_X

	inx
	lda	river_path,X
	sta	PEASANT_Y

	jsr	draw_peasant

	;=========================
	; handle special action
	;========================
	; 0..9 - nothing
	; 10..? - print message
	; 15    - change direction walking

	lda	FRAME
check_river_action1:
	cmp	#10
	bcc	done_river_action

	; over 10, print message

	lda	#<river_message1
	sta	OUTL
	lda	#>river_message1
	sta	OUTH

	jsr	hgr_text_box

	; if 15 switch direction

	lda	FRAME
	cmp	#15
	bne	done_river_action

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

done_river_action:

	jsr	animate_river


;	jsr	wait_until_keypress

	jsr	hgr_page_flip

	;========================
	; drain keyboard buffer

	jsr	intro_drain_keyboard_buffer

	lda	ESC_PRESSED
	bne	done_river


	lda	#DEFAULT_WAIT
	jsr	wait_a_bit

	lda	ESC_PRESSED
	bne	done_river

	inc	FRAME

	jsr	really_move_peasant

	jmp	river_walk_loop


	;===================
	; done

done_river:

	rts



; walk up a bit

;river_message1:
;	.byte 0,35,34, 0,253,82
;	.byte 7,49,"You can start playing in a",13
;	.byte	   "second here.",0

; walks behind tree



river_path:
	.byte 32,157
	.byte 32,153
	.byte 32,149
	.byte 32,145
	.byte 32,141
	.byte 32,137
	.byte 32,133
	.byte 32,129
	.byte 32,125
	.byte 32,121	; message
	.byte 32,117
	.byte 32,113
	.byte 32,109
	.byte 32,105
	.byte 32,105	; turn right
	.byte 33,105
	.byte 34,105
	.byte 35,105
	.byte 36,105
	.byte 37,105
	.byte 38,105
	.byte $FF,$FF

