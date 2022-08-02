; Lake East

	;========================
	; Lake East
	;========================
intro_lake_east:
	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 7,152

	lda	#7
	sta	PEASANT_X
	lda	#152
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<lake_e_priority_zx02
	sta	zx_src_l+1
	lda	#>lake_e_priority_zx02
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	gr_copy_to_page1


	;=====================
	; load bg

	lda	#<(lake_e_zx02)
	sta	zx_src_l+1
	lda	#>(lake_e_zx02)
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	hgr_copy


	;================
	; print title line

	jsr	intro_print_title

	;====================
	; save background

;	lda	PEASANT_X
;	sta	CURSOR_X
;	lda	PEASANT_Y
;	sta	CURSOR_Y

	;=======================
	; walking

;	jsr	save_bg_1x28

lake_e_walk_loop:

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_1x28

	; draw peasant

	lda	FRAME
	asl
	tax

	lda	lake_e_path,X
	bmi	done_lake_e
	sta	PEASANT_X
	sta	CURSOR_X

	inx
	lda	lake_e_path,X
	sta	PEASANT_Y
	sta	CURSOR_Y

;	jsr	save_bg_1x28

	jsr	draw_peasant


	lda	FRAME
check_lake_e_action1:
	cmp	#10
	bne	check_lake_e_action2

	lda	#<lake_e_message1
	sta	OUTL
	lda	#>lake_e_message1
	sta	OUTH
	jsr	hgr_text_box

	jmp	done_lake_e_action

check_lake_e_action2:
	cmp	#28
	bne	done_lake_e_action
	lda	#0
	ldx	#39
	jsr	hgr_partial_restore
	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

done_lake_e_action:

	jsr	animate_bubbles_e

;	jsr	wait_until_keypress

	lda	#3
	jsr	wait_a_bit

	lda	ESC_PRESSED
	bne	done_lake_e

	inc	FRAME

	jmp	lake_e_walk_loop


	;===================
	; done

done_lake_e:

	rts


; walk sideways, near corner

;lake_e_message1:
;	.byte 0,35,34, 0,253,72
;	.byte 7,49,"That's a nice looking lake.",0

; nearly hit head on sign, it goes away, walk off screen

lake_e_path:
	.byte 4,151
	.byte 5,151
	.byte 6,151
	.byte 7,151
	.byte 8,151
	.byte 9,151
	.byte 10,151
	.byte 11,151
	.byte 12,151
	.byte 13,151
	.byte 14,151
	.byte 15,151
	.byte 16,151
	.byte 17,151
	.byte 18,151
	.byte 19,151
	.byte 20,151
	.byte 21,151
	.byte 22,151
	.byte 23,151
	.byte 24,151
	.byte 25,151
	.byte 26,151
	.byte 27,151
	.byte 28,151
	.byte 29,141
	.byte 30,131
	.byte 31,121
	.byte 32,111
	.byte 33,101
	.byte 34,91
	.byte 35,81
	.byte 35,71
	.byte 35,61
	.byte 35,51
	.byte 35,41
	.byte $FF,$FF


