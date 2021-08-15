; Lake East

	;************************
	; Lake East
	;************************
lake_east:
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


	lda	#<(lake_e_lzsa)
	sta	getsrc_smc+1
	lda	#>(lake_e_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

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

lake_e_walk_loop:
	jsr	restore_bg_7x30

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
	jsr	hgr_restore
	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

done_lake_e_action:

	jsr	update_bubbles_e


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

	jsr	save_bg_7x30

	jsr	draw_peasant

;	jsr	wait_until_keypress

	lda	#3
	jsr	wait_a_bit

	inc	FRAME

	jmp	lake_e_walk_loop


	;===================
	; done

done_lake_e:

	rts


; walk sideways, near corner

lake_e_message1:
	.byte 0,35,34, 0,253,72
	.byte 7,49,"That's a nice looking lake.",0

; nearly hit head on sign, it goes away, walk off screen




lake_e_path:
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


	;================
	; update bubbles E
update_bubbles_e:

	; 5,94
	; 15,103
	; 13,130

	; bubble 1

	lda	FRAME
	and	#7
	asl
	tax

	lda	bubble_progress_e,X
	sta	INL
	inx
	lda	bubble_progress_e,X
	sta	INH

	lda	#5
	sta	CURSOR_X
	lda	#94
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5


	; bubble 2

	lda	FRAME
	adc	#3
	and	#7
	asl
	tax

	lda	bubble_progress_e,X
	sta	INL
	inx
	lda	bubble_progress_e,X
	sta	INH

	lda	#15
	sta	CURSOR_X
	lda	#103
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5

	; bubble 3

	lda	FRAME
	adc	#5
	and	#7
	asl
	tax

	lda	bubble_progress_e,X
	sta	INL
	inx
	lda	bubble_progress_e,X
	sta	INH

	lda	#13
	sta	CURSOR_X
	lda	#130
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5

	rts


bubble_progress_e:
	.word bubble_e_sprite0
	.word bubble_e_sprite0
	.word bubble_e_sprite1
	.word bubble_e_sprite0
	.word bubble_e_sprite2
	.word bubble_e_sprite3
	.word bubble_e_sprite4
	.word bubble_e_sprite5


bubble_e_sprite0:
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $80	; 1 000 0000
	.byte $AA

bubble_e_sprite1:
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $88	; 1 XXX 10XX
	.byte $A2	; 0 010 XX10

bubble_e_sprite2:
	.byte $AA
	.byte $AA
	.byte $A2	; 0 010 XX10
	.byte $88	; 1 XXX 10XX
	.byte $AA

bubble_e_sprite3:
	.byte $AA
	.byte $A2	; 101X XX10
	.byte $88	; 00XX 1XX0
	.byte $88	; 1XX0 10XX
	.byte $AA

bubble_e_sprite4:
	.byte $88	; 0xx0 10xx
	.byte $A2	; 101x xx10
	.byte $88	; 00xx 1xx0
	.byte $88	; 1xx0 10XX
	.byte $AA	; 0010 1010

bubble_e_sprite5:
	.byte $AA	; 0010 1010
	.byte $88	; 1XX0 10XX
	.byte $A2	; 001X XX10
	.byte $88	; 1XX0 10XX
	.byte $AA	; 0010 1010







