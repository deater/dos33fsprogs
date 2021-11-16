; Lake West

	;************************
	; Lake West
	;************************
lake_west:
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

	;==================
	; draw background

	lda	#<(lake_w_lzsa)
	sta	getsrc_smc+1
	lda	#>(lake_w_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	;================
	; print title

	jsr	intro_print_title


	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<lake_w_priority_lzsa
	sta	getsrc_smc+1
	lda	#>lake_w_priority_lzsa
	sta	getsrc_smc+2

	lda	#$20			; temporarily load to $2000

	jsr     decompress_lzsa2_fast

	; copy to $400

	jsr	gr_copy_to_page1


	;====================
	; save background

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	;=======================
	; walking

	jsr	save_bg_1x28

lake_w_walk_loop:

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_1x28

	; draw peasant

	lda	FRAME
	asl
	tax

	lda	lake_w_path,X
	bmi	done_lake_w
	sta	PEASANT_X
	sta	CURSOR_X

	inx
	lda	lake_w_path,X
	sta	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_1x28

	jsr	draw_peasant




	lda	FRAME
check_lake_w_action1:
	cmp	#0
	bne	check_lake_w_action2

	; re-display cottage text 3
	lda	#<cottage_text3
	sta	OUTL
	lda	#>cottage_text3
        sta	OUTH
        jsr	hgr_text_box
	jmp	done_lake_w_action

check_lake_w_action2:
	cmp	#20
	bne	done_lake_w_action
	jsr	hgr_partial_restore
	jsr	display_lake_w_text1

done_lake_w_action:


	jsr	update_bubbles




;	jsr	wait_until_keypress

	lda	#3
	jsr	wait_a_bit

	lda	ESC_PRESSED
	bne	done_lake_w

	inc	FRAME

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


	;============================
	; display cottage text 1
	;============================
display_lake_w_text1:

	lda	#<lake_w_message1
	sta	OUTL
	lda	#>lake_w_message1
	sta	OUTH

	jsr	hgr_text_box

	rts


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


	;================
	; update bubbles
update_bubbles:

	; 33,91
	; 27,125
	; 33,141
	; 35,115

	; bubble 1

	lda	FRAME
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#33
	sta	CURSOR_X
	lda	#91
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5


	; bubble 2

	lda	FRAME
	adc	#3
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#27
	sta	CURSOR_X
	lda	#125
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5

	; bubble 3

	lda	FRAME
	adc	#5
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#33
	sta	CURSOR_X
	lda	#141
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5

	; bubble 4

	lda	FRAME
	adc	#2
	and	#7
	asl
	tax

	lda	bubble_progress,X
	sta	INL
	inx
	lda	bubble_progress,X
	sta	INH

	lda	#35
	sta	CURSOR_X
	lda	#115
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_1x5






	rts


bubble_progress:
	.word bubble_sprite0
	.word bubble_sprite0
	.word bubble_sprite1
	.word bubble_sprite0
	.word bubble_sprite2
	.word bubble_sprite3
	.word bubble_sprite4
	.word bubble_sprite5


bubble_sprite0:
	.byte $2A
	.byte $AA
	.byte $2A
	.byte $80	; 1 000 0000
	.byte $2A

bubble_sprite1:
	.byte $2A
	.byte $AA
	.byte $2A
	.byte $88	; 1 XXX 10XX
	.byte $22	; 0 010 XX10

bubble_sprite2:
	.byte $2A
	.byte $AA
	.byte $22	; 0 010 XX10
	.byte $88	; 1 XXX 10XX
	.byte $2A

bubble_sprite3:
	.byte $2A
	.byte $A2	; 101X XX10
	.byte $08	; 00XX 1XX0
	.byte $88	; 1XX0 10XX
	.byte $2A

bubble_sprite4:
	.byte $08	; 0xx0 10xx
	.byte $A2	; 101x xx10
	.byte $08	; 00xx 1xx0
	.byte $88	; 1xx0 10XX
	.byte $2A	; 0010 1010

bubble_sprite5:
	.byte $2A	; 0010 1010
	.byte $88	; 1XX0 10XX
	.byte $22	; 001X XX10
	.byte $88	; 1XX0 10XX
	.byte $2A	; 0010 1010

