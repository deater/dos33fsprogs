; A Peasant's Quest????

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"



peasant_quest:

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called



	lda	#0
	sta	FRAME

	;=========================
	; init peasant position
	; draw at 18,107

	lda	#18
	sta	PEASANT_X
	lda	#107
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

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

	; put score

	lda	#<score_text
	sta	OUTL
	lda	#>score_text
	sta	OUTH

	jsr	hgr_put_string


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

	jsr	hgr_save

	;====================
	; save background

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	;=======================
	; draw initial peasant

	jsr	save_bg_7x30
	jsr	draw_peasant

game_loop:

	; redraw peasant if moved

	lda	PEASANT_XADD
	ora	PEASANT_YADD
	beq	peasant_the_same

	; restore bg behind peasant

	jsr	restore_bg_7x30

	; move peasant

	clc
	lda	PEASANT_X
	adc	PEASANT_XADD
	bmi	peasant_x_negative
	cmp	#40
	bcs	peasant_x_toobig		; bge
	bcc	done_movex

peasant_x_toobig:
	lda	#0
	sta	PEASANT_XADD
	lda	#39
	jmp	done_movex

peasant_x_negative:
	lda	#0
	sta	PEASANT_XADD
	jmp	done_movex

	; check edge of screen
done_movex:
	sta	PEASANT_X

	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD
	sta	PEASANT_Y

	; save behind new position

	jsr	save_bg_7x30

	; draw peasant

	jsr	draw_peasant

peasant_the_same:

;	lda	#3
;	jsr	wait_a_bit

	inc	FRAME

	jsr	check_keyboard

	jmp	game_loop




check_keyboard:

	lda	KEYPRESS
	bmi	key_was_pressed
	rts

key_was_pressed:

	and	#$7f		 ; strip off high bit

check_left:
	cmp	#'A'
	bne	check_right

	lda	#$FF		; move left
	sta	PEASANT_XADD
	jmp	done_check_keyboard

check_right:
	cmp	#'D'
	bne	check_up

	lda	#$1
	sta	PEASANT_XADD
	jmp	done_check_keyboard

check_up:
	cmp	#'W'
	bne	check_down

	lda	#$1
	sta	PEASANT_YADD
	jmp	done_check_keyboard

check_down:
	cmp	#'S'
	bne	check_enter

	lda	#$FF
	sta	PEASANT_YADD
	jmp	done_check_keyboard

check_enter:
	cmp	#13
	beq	enter_pressed
	cmp	#' '
	bne	done_check_keyboard
enter_pressed:


done_check_keyboard:

	bit	KEYRESET

	rts



	; read input

	jsr	hgr_input

	rts



peasant_text:
	.byte 25,2,"Peasant's Quest",0

score_text:
	.byte 0,2,"Score: 0 of 150",0


	;************************
	; copy protection check
	;************************
exit_copy_check:
	lda	#LOAD_COPY_CHECK
	sta	WHICH_LOAD

	rts


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "draw_peasant.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_7x30_sprite.s"
.include "hgr_1x5_sprite.s"
.include "hgr_save_restore.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"

.include "wait_a_bit.s"

.include "graphics/graphics.inc"


help_message:
.byte   0,43,24, 0,253,82
.byte   8,41,"I don't understand. Type",13
.byte	     "HELP for assistances.",0
