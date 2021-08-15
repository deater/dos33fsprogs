; o/~ One knight in Bangkok makes a hard man humble o/~

	;************************
	; Knight
	;************************
knight:
	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 0,107

	lda	#0
	sta	PEASANT_X
	lda	#107
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR


	;=====================
	; load bg

	lda	#<(knight_lzsa)
	sta	getsrc_smc+1
	lda	#>(knight_lzsa)
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

knight_walk_loop:
	jsr	restore_bg_7x30

	lda	FRAME
check_knight_action1:
	cmp	#0
	bne	check_knight_action2

	lda	#<river_message1
	sta	OUTL
	lda	#>river_message1
	sta	OUTH

	jsr	hgr_text_box

	jmp	done_knight_action

check_knight_action2:
	cmp	#8
	bne	check_knight_action3
	jsr	hgr_restore
	jmp	done_knight_action

check_knight_action3:
	cmp	#17
	bne	done_knight_action

	lda	#<knight_message1
	sta	OUTL
	lda	#>knight_message1
	sta	OUTH

	jsr	hgr_text_box


done_knight_action:


	lda	FRAME
	asl
	tax

	lda	knight_path,X
	bmi	done_knight
	sta	PEASANT_X
	sta	CURSOR_X

	inx
	lda	knight_path,X
	sta	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_7x30

	jsr	draw_peasant

;	jsr	wait_until_keypress

	lda	#3
	jsr	wait_a_bit

	inc	FRAME

	jmp	knight_walk_loop


	;===================
	; done

done_knight:

	; after OK stuff goes on here

	sei	; turn off music
	jsr	clear_ay_both

	jsr	draw_peasant

	; wait a bit

	lda	#10
	jsr	wait_a_bit

	; restore bg

	jsr	hgr_restore

	; put score

	lda	#<score_text
	sta	OUTL
	lda	#>score_text
	sta	OUTH

	jsr	hgr_put_string

	; draw peasant

	jsr	draw_peasant

	; draw rectangle on bottom

; draw rectangle

	lda     #$00            ; color is black1
	sta     VGI_RCOLOR

	lda     #0
	sta     VGI_RX1
	lda     #183
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#9
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle

	lda     #140
	sta     VGI_RX1
	lda     #183
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#9
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle




	; fake get text

	jsr	hgr_input

	rts


; continues displaying previous message

; stops as approach knight

knight_message1:
	.byte 0,35,34, 0,253,72
	.byte 7,49,"OK go for it.",0



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
	.byte $FF,$FF

score_text:
        .byte 0,2,"Score: 0 of 150",0
