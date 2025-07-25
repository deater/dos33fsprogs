; Lake West

; Everyone knows west lake is the best lake


	;========================
	; Lake West
	;========================
intro_lake_west:
	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 7,155

	lda	#1
	sta	PEASANT_X
	lda	#155
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	;===============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<lake_w_priority_zx02
	sta	zx_src_l+1
	lda	#>lake_w_priority_zx02
	sta	zx_src_h+1

	lda	#>priority_temp		; temporarily load to $7000

	jsr     zx02_full_decomp

	; copy to $400

	jsr	priority_copy

	;=================================
	; load background to $6000 (PAGE1)

	lda	#<(lake_w_zx02)
	sta	zx_src_l+1
	lda	#>(lake_w_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp


	;================
	; print title

	jsr	intro_print_title


	;================
	;================
	; walk loop
	;================
	;================

lake_w_walk_loop:
	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;===============
	; draw peasant

	lda	FRAME
	asl
	tax

	lda	lake_w_path,X
	bmi	done_lake_w
	sta	PEASANT_X

	inx
	lda	lake_w_path,X
	sta	PEASANT_Y

	jsr	draw_peasant


	;============================
	; handle special action
	;============================
	; FRAME  0 -- 19         cottage_text_3
	; FRAME 20 -- ??         lake_w_text

	lda	FRAME
check_lake_w_action1:
	cmp	#20
	bcs	check_lake_w_action2	; bge

	;==========================
	; re-display cottage text 3
	lda	#<cottage_text3
	sta	OUTL
	lda	#>cottage_text3

	jmp	done_lake_w_action

check_lake_w_action2:
;	cmp	#20
;	bne	done_lake_w_action

	;===========================
	; display text

	;============================
	; display cottage text 1
	;============================
display_lake_w_text1:

	lda	#<lake_w_message1
	sta	OUTL
	lda	#>lake_w_message1

done_lake_w_action:
        sta	OUTH
        jsr	hgr_text_box

	;=========================
	; animate bubbles

	jsr	animate_bubbles_w

	jsr	hgr_page_flip

	;========================
	; drain keyboard buffer

	jsr	intro_drain_keyboard_buffer

	lda	ESC_PRESSED
	bne	done_lake_w


	lda	#DEFAULT_WAIT
	jsr	wait_a_bit

	lda	ESC_PRESSED
	bne	done_lake_w

	inc	FRAME

	jsr	really_move_peasant

	jmp	lake_w_walk_loop


	;===================
	; done

done_lake_w:

	rts


; same message as end of cottage

; walk halfway across the screen

;lake_w_message1:
;	.byte	0,42,24, 0,252,82
;	.byte	8,41,"You head east toward the",13
;	.byte	     "mountain atop which",13
;	.byte	     "TROGDOR lives.",0

; walk to edge



lake_w_path:
	.byte 1,155
	.byte 2,155
	.byte 3,155
	.byte 4,155
	.byte 5,155
	.byte 6,155
	.byte 7,155
	.byte 8,155
	.byte 9,155
	.byte 10,155
	.byte 11,155
	.byte 12,155
	.byte 13,155
	.byte 14,155
	.byte 15,155
	.byte 16,155
	.byte 17,155
	.byte 18,155
	.byte 19,155
	.byte 20,155
	.byte 21,155
	.byte 22,155
	.byte 23,155
	.byte 24,155
	.byte 25,155
	.byte 26,155
	.byte 27,155
	.byte 28,155
	.byte 29,155
	.byte 30,155
	.byte 31,155
	.byte 32,155
	.byte 33,155
	.byte 34,155
	.byte 35,155
	.byte 36,155
	.byte 37,155
	.byte 38,155
	.byte 39,155
	.byte $FF,$FF


