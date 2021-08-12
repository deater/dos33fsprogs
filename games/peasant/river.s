; o/~ At the beautiful, the beautiful, River o/~

	;************************
	; River
	;************************
river:
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

	;====================
	; load bg


	lda	#<(river_lzsa)
	sta	getsrc_smc+1
	lda	#>(river_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

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

river_walk_loop:
	jsr	restore_bg_7x30

	lda	FRAME
check_river_action1:
	cmp	#10
	bne	check_river_action2
	jsr	display_river_text1
	jmp	done_river_action

check_river_action2:
	cmp	#15
	bne	done_river_action
;	jsr	hgr_restore
	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

done_river_action:

	jsr	update_bubbles_r


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

	jsr	save_bg_7x30

	jsr	draw_peasant

	jsr	wait_until_keypress

	inc	FRAME

	jmp	river_walk_loop


	;===================
	; done

done_river:

	rts



; walk up a bit

river_message1:
	.byte 7,49,"You can start playing in a",0
	.byte 7,57,"second here.",0

; walks behind tree


	;============================
	; display river text 1
	;============================
display_river_text1:

	;====================
	; draw text box

	lda	#0
	sta	BOX_X1H
	lda	#35
	sta	BOX_X1L
	lda	#34
	sta	BOX_Y1

	lda	#0
	sta	BOX_X2H
	lda	#253
	sta	BOX_X2L
	lda	#82
	sta	BOX_Y2

	jsr	draw_box

	lda	#<river_message1
	sta	OUTL
	lda	#>river_message1
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string

	rts

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
	.byte $FF,$FF


	;================
	; update bubbles river
update_bubbles_r:

	; 5,166
	; 9,154
	; 7,160

	; bubble 1

	lda	FRAME
	and	#3
	asl
	tax

	lda	bubble_progress_r,X
	sta	INL
	inx
	lda	bubble_progress_r,X
	sta	INH

	lda	#5
	sta	CURSOR_X
	lda	#166
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5


	; bubble 2

	lda	FRAME
	adc	#3
	and	#3
	asl
	tax

	lda	bubble_progress_r,X
	sta	INL
	inx
	lda	bubble_progress_r,X
	sta	INH

	lda	#9
	sta	CURSOR_X
	lda	#154
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5

	; bubble 3

	lda	FRAME
	adc	#5
	and	#3
	asl
	tax

	lda	bubble_progress_r,X
	sta	INL
	inx
	lda	bubble_progress_r,X
	sta	INH

	lda	#7
	sta	CURSOR_X
	lda	#160
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5

	rts


bubble_progress_r:
	.word bubble_r_sprite0
	.word bubble_r_sprite0
	.word bubble_r_sprite1
	.word bubble_r_sprite1


bubble_r_sprite0:
	.byte $AA
	.byte $FF
	.byte $AA
	.byte $FF
	.byte $AA

bubble_r_sprite1:
	.byte $FF
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $FF








