; Dating Sim XR '93
;
; This one was by Strong Bad (?)
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

div7_table     = $1300
mod7_table     = $1400
hposn_high     = $1500
hposn_low      = $1600


dating_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	;====================
	; set up tables
	;====================

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables


	lda	#$0
	sta	TEXT_COL
	sta	TEXT_ROW


.if 0
	;==========================
	; Load Sound
	;===========================

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_load_sound

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	; fish = 4225 bytes  load at $D000 - $E0FF
	; boat = 4966 bytes  load at $E100 - $F4FF

	lda	#<sound_data_fish
	sta	ZX0_src
	lda	#>sound_data_fish
	sta	ZX0_src+1

	lda	#$D0

	jsr	full_decomp

	lda	#<sound_data_boat
	sta	ZX0_src
	lda	#>sound_data_boat
	sta	ZX0_src+1

	lda	#$E1

	jsr	full_decomp

	; read ROM/no-write
	bit	$C082

done_load_sound:
.endif
	;==========================
	; Load Title
	;===========================

load_title:
	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp



wait_at_tile:
	lda	KEYPRESS
	bpl	wait_at_tile

	bit	KEYRESET

	;===================
	; setup game
	;===================

;	lda	#0
;	sta	DRAW_PAGE



	;==========================
	; Load Background
	;===========================

load_background:

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp


	bit	PAGE1
	bit	HIRES
	bit	TEXTGR
	bit	SET_GR


	lda	#0
	sta	DRAW_PAGE

	lda	#<game_text
	sta	OUTL
	lda	#>game_text
	sta	OUTH

	jsr	set_normal		; normal text

	jsr	move_and_print_list

	jsr	set_inverse

	jsr	update_text


	;==========================
	; main loop
	;===========================
main_loop:



	inc	FRAME



	;===========================
	; check keypress
	;===========================

check_keypress:
	lda     KEYPRESS
	bpl	done_keyboard_check

	bit     KEYRESET		; clear the keyboard strobe

	; clear high bit
	and	#$7f

	cmp	#27		; escape
	bne	not_done_game

	jmp	done_game


not_done_game:

	cmp	#$96			; see if need to convert
	bcc	no_upper_convert

	and	#$5f			; convert lowercase to upper

no_upper_convert:

	;========================
	; check left
	;========================
check_left:
	cmp	#$8
	beq	left_pressed
	cmp	#'A'
	bne	check_right
left_pressed:
	jsr	erase_current
	lda	#0
	sta	TEXT_COL
	beq	done_movement	; bra

check_right:
	cmp	#$15
	beq	right_pressed
	cmp	#'D'
	bne	check_up
right_pressed:
	jsr	erase_current
	lda	#1
	sta	TEXT_COL
	bne	done_movement	; bra

check_up:
	cmp	#$0b
	beq	up_pressed
	cmp	#'W'
	bne	check_down
up_pressed:
	jsr	erase_current
	lda	TEXT_ROW
	beq	no_up_move
	dec	TEXT_ROW
no_up_move:
	jmp	done_movement

check_down:
	cmp	#$0a
	beq	down_pressed
	cmp	#'S'
	bne	check_enter
down_pressed:
	jsr	erase_current
	lda	TEXT_ROW
	cmp	#3
	bcs	no_down_move
	inc	TEXT_ROW
no_down_move:
	jmp	done_movement

check_enter:
	cmp	#' '
	beq	do_sound
	cmp	#13		; return/enter
	beq	do_sound

done_keyboard_check:
	jmp	main_loop

done_movement:
	jsr	set_inverse
	jsr	update_text
	jmp	main_loop

do_sound:
	lda	TEXT_COL
	bne	homestar_sound

marzipan_sound:
	lda	TEXT_ROW

	tax
	lda	m_sounds_len,X
	sta	SOUND_LEN

	lda	m_sounds_l,X
	sta	ZX0_src
	lda	m_sounds_h,X
	jmp	sound_common


homestar_sound:
	lda	TEXT_ROW
	cmp	#3
	beq	done_keyboard_check

	tax
	lda	h_sounds_len
	sta	SOUND_LEN

	lda	h_sounds_l,X
	sta	ZX0_src
	lda	h_sounds_h,X

sound_common:
	sta	ZX0_src+1

	lda	#$A0

	jsr	full_decomp

; audio file in BTC_L/BTC_H
; pages to play in X

	lda	#$0
	sta	BTC_L
	lda	#$A0
	sta	BTC_H
	ldx	SOUND_LEN

	jsr	play_audio
sound_done:
	jmp	done_keyboard_check


	;==========================
	; done game
	;==========================

done_game:
	lda	#0
really_done_game:
	sta	WHICH_LOAD
	rts


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts


	;=======================
	; erase current

erase_current:
	jsr	set_normal

update_text:
	lda	#0
	sta	DRAW_PAGE

	lda	TEXT_COL
	asl
	asl
	clc
	adc	TEXT_ROW
	tax

	lda	game_text_l,X
	sta	OUTL
	lda	game_text_h,X
	sta	OUTH
	jsr	move_and_print

	lda	#$20
	sta	DRAW_PAGE
	rts




game_text_l:
	.byte <text_m_duh,<text_m_buh,<text_m_fuh,<text_m_ques
	.byte <text_h_duh,<text_h_buh,<text_h_fuh,<text_h_ques
game_text_h:
	.byte >text_m_duh,>text_m_buh,>text_m_fuh,>text_m_ques
	.byte >text_h_duh,>text_h_buh,>text_h_fuh,>text_h_ques

game_text:
text_m_duh:	.byte 8,20,"DUH!",0
text_m_buh:	.byte 8,21,"BUH!",0
text_m_fuh:	.byte 8,22,"FUH!",0
text_m_ques:	.byte 8,23,"???",0
text_h_duh:	.byte 28,20,"DUH!",0
text_h_buh:	.byte 28,21,"BUH!",0
text_h_fuh:	.byte 28,22,"FUH!",0
text_h_ques:	.byte 28,23,"???",0
	.byte $FF

title_data:
	.incbin "graphics/dating_title.hgr.zx02"


bg_data:
	.incbin "graphics/a2_dating.hgr.zx02"


	.include	"zx02_optim.s"

	.include	"hgr_tables.s"

	.include	"audio.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"
;	.include	"random16.s"

m_sounds_l:
	.byte <marzipan_duh,<marzipan_buh,<marzipan_fuh,<marzipan_on_point
m_sounds_h:
	.byte >marzipan_duh,>marzipan_buh,>marzipan_fuh,>marzipan_on_point
m_sounds_len:
	.byte 15,15,15,31

marzipan_duh:
	.incbin "sounds/m_duh.btc.zx02"
marzipan_buh:
	.incbin "sounds/m_buh.btc.zx02"
marzipan_fuh:
	.incbin "sounds/m_fuh.btc.zx02"
marzipan_on_point:
	.incbin "sounds/m_sb_on_point.btc.zx02"

h_sounds_l:
	.byte <homestar_duh,<homestar_buh,<homestar_fuh
h_sounds_h:
	.byte >homestar_duh,>homestar_buh,>homestar_fuh
h_sounds_len:
	.byte 15,15,15

homestar_duh:
	.incbin "sounds/h_duh.btc.zx02"
homestar_buh:
	.incbin "sounds/h_buh.btc.zx02"
homestar_fuh:
	.incbin "sounds/h_fuh.btc.zx02"




