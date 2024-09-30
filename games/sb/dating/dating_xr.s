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
	; print directions
	;===================
	; in the actual game this is overlay ontop of the faded gameplay
	; that would be a pain so we're not going to do it

;	lda	#$0
;	sta	DRAW_PAGE

;	jsr	clear_all

;	bit	LORES
;	bit	FULLGR
;	bit	SET_TEXT
;	bit	PAGE1


;	ldx	#7
;print_help:
;	jsr	move_and_print
;	dex
;	bne	print_help

;	jsr	set_flash		; have the "press spacebar" flash
;	jsr	move_and_print

;wait_at_directions:
;	lda	KEYPRESS
;	bpl	wait_at_directions

;	bit	KEYRESET

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


	;===================
	; set up variables

	; have it show garbage on page2 briefly
	; this is better than re-showing title
	; ideally we'd just clear the screen I guess

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


	lda	#$20
	sta	DRAW_PAGE

	; re-set up hgr tables

;	lda	#$20
;	sta	HGR_PAGE
;	jsr	hgr_make_tables


	;==========================
	; main loop
	;===========================
main_loop:



;	jsr	flip_page



	;========================
	;========================
	; draw the scene
	;========================
	;========================

	;==================================
	; copy over (erase) old background
.if 0
	; this isn't fast, but much faster than decompressing
	;	we could be faster if we unrolled, or only
	;	did part of the screen

	lda	#$a0
	sta	bg_copy_in_smc+2

	clc
	lda	DRAW_PAGE
	adc	#$20
	sta	bg_copy_out_smc+2

	ldy	#0
bg_copy_loop:

bg_copy_in_smc:
	lda	$A000,Y
bg_copy_out_smc:
	sta	$2000,Y
	dey
	bne	bg_copy_loop

	inc	bg_copy_in_smc+2
	inc	bg_copy_out_smc+2
	lda	bg_copy_in_smc+2
	cmp	#$C0
	bne	bg_copy_loop
.endif

	inc	FRAME



	;============================
	; play sound
	;============================

;	ldy	#5
;	jsr	play_asplode


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
	; do this after or else '/' counts as escape

	and	#$df			; convert lowercase to upper


	cmp	#' '
	beq	do_sound
	cmp	#13		; return/enter
	beq	do_sound

done_keyboard_check:
	jmp	main_loop

do_sound:
	lda	#<marzipan_sounds
	sta	ZX0_src
	lda	#>marzipan_sounds
	sta	ZX0_src+1

	lda	#$A0

	jsr	full_decomp

; audio file in BTC_L/BTC_H
; pages to play in X

	lda	#$0
	sta	BTC_L
	lda	#$A0
	sta	BTC_H
	ldx	#16

	jsr	play_audio

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

game_text:
	.byte 8,20,"DUH!",0
	.byte 8,21,"BUH!",0
	.byte 8,22,"FUH!",0
	.byte 8,23,"???",0
	.byte 28,20,"DUH!",0
	.byte 28,21,"BUH!",0
	.byte 28,22,"FUH!",0
	.byte 28,23,"???",0
	.byte $FF



;sound_data_fish:
;	.incbin "sounds/fish.btc.zx02"
;sound_data_boat:
;	.incbin "sounds/get_in_boat.btc.zx02"

title_data:
	.incbin "graphics/dating_title.hgr.zx02"


bg_data:
	.incbin "graphics/a2_dating.hgr.zx02"


	.include	"zx02_optim.s"
;	.include	"gr_fast_clear.s"

	.include	"hgr_tables.s"
;	.include	"hgr_sprite_big.s"
;	.include	"hgr_sprite_mask.s"
;	.include	"hgr_sprite.s"


;	.include	"hgr_copy_fast.s"
	.include	"audio.s"
	.include	"play_sounds.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"
;	.include	"random16.s"

marzipan_sounds:
	.incbin "sounds/m_duh.btc.zx02"
	.incbin "sounds/m_buh.btc.zx02"
	.incbin "sounds/m_fuh.btc.zx02"



