; o/~ At the beautiful, the beautiful, River o/~

	;************************
	; River
	;************************
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

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	gr_copy_to_page1


	;====================
	; load bg


	lda	#<(river_zx02)
	sta	zx_src_l+1
	lda	#>(river_zx02)
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	hgr_copy

	;================
	; print title

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

river_walk_loop:

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_1x28

	; draw peasant

	lda	FRAME
	asl
	tax

	lda	river_path,X
	bmi	done_river
	sta	PEASANT_X
	sta	CURSOR_X

	inx
	lda	river_path,X
	sta	PEASANT_Y
	sta	CURSOR_Y

;	jsr	save_bg_1x28

	jsr	draw_peasant


	lda	FRAME
check_river_action1:
	cmp	#10
	bne	check_river_action2

	lda	#<river_message1
	sta	OUTL
	lda	#>river_message1
	sta	OUTH

	jsr	hgr_text_box

	jmp	done_river_action

check_river_action2:
	cmp	#15
	bne	done_river_action
;	jsr	hgr_restore
	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

done_river_action:

	jsr	animate_river


;	jsr	wait_until_keypress

	lda	#3
	jsr	wait_a_bit

	lda	ESC_PRESSED
	bne	done_river

	inc	FRAME

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


.include "animate_river.s"
