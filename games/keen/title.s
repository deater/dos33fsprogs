; Keen1 Title

; loads a HGR version of the title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

div7_table     = $9C00
mod7_table     = $9D00
hposn_high     = $9E00
hposn_low      = $9F00

keen_title_start:
	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	HIRES
	bit	FULLGR

	;===================
	; machine workarounds
	;===================
	; mostly IIgs
	;===================
	; thanks to 4am who provided this code from Total Replay

	lda	ROM_MACHINEID
	cmp	#$06
	bne	not_a_iigs
	sec
	jsr	$FE1F			; check for IIgs
	bcs	not_a_iigs

	; gr/text page2 handling broken on early IIgs models
	; this enables the workaround

	jsr	ROM_TEXT2COPY		; set alternate display mode on IIgs
	cli				; enable VBL interrupts

	; also set background color to black instead of blue
	lda	NEWVIDEO
	and	#%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta   NEWVIDEO
	lda   #$F0
	sta   TBCOLOR			; white text on black background
	lda   #$00
	sta   CLOCKCTL			; black border
	sta   CLOCKCTL			; set twice for VidHD

not_a_iigs:

	;===================
	; Load hires graphics
	;===================
reload_everything:

	lda	#<new_title
	sta	ZX0_src
	lda	#>new_title
	sta	ZX0_src+1

	lda	#$20	; decompress to hgr page1

	jsr	full_decomp

	;===================================
	; detect if we have a language card
	; and load sound into it if possible
	;===================================

;	lda	#0
;	sta	SOUND_STATUS		; clear out, sound enabled

;	jsr	detect_language_card
;	bcs	no_language_card

	; update sound status
;	lda	SOUND_STATUS
;	ora	#SOUND_IN_LC
;	sta	SOUND_STATUS

	; load sounds into LC

	; read ram, write ram, use $d000 bank1
;	bit	$C08B
;	bit	$C08B

;	lda	#<linking_noise_compressed
;	sta	getsrc_smc+1
;	lda	#>linking_noise_compressed
;	sta	getsrc_smc+2

;	lda	#$D0	; decompress to $D000

;	jsr	decompress_lzsa2_fast

;blah:

	; read rom, nowrite, use $d000 bank1
;	bit	$C08A

no_language_card:

	;===================================
	; Setup Mockingboard
	;===================================
;	lda	#0
;	sta	DONE_PLAYING
;	sta	LOOP

	; detect mockingboard
;	jsr	mockingboard_detect

;	bcc	mockingboard_notfound

mockingboard_found:
;;       jsr     mockingboard_patch      ; patch to work in slots other than 4?

;	lda	SOUND_STATUS
;	ora	#SOUND_MOCKINGBOARD
;	sta	SOUND_STATUS

	;=======================
	; Set up 50Hz interrupt
	;========================

;	jsr	mockingboard_init
;	jsr	mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

;	jsr	reset_ay_both
;	jsr	clear_ay_both

	;==================
	; init song
	;==================

;	jsr     pt3_init_song

;	jmp     done_setup_sound


mockingboard_notfound:


done_setup_sound:


	;===================================
	; init
	;===================================

	lda	#$0
	sta	HGR_PAGE
	jsr	hgr_make_tables

	;===================================
	; Do Intro Sequence
	;===================================

	; wait a bit at LOAD screen

	lda	#100
	jsr	wait_a_bit


	;===================================
	; Draw title message
	;===================================

	lda	#<title_sprite
	sta	INL
	lda	#>title_sprite
	sta	INH

	lda	#8
	sta	SPRITE_X

	lda	#48
	sta	SPRITE_Y

	lda	#$20
	sta	DRAW_PAGE

	jsr	hgr_draw_sprite

	;===========================
	; title loop
	;==========================

	lda	#0
	sta	WHICH_CURSOR
	sta	FRAMEL
	sta	FRAMEH
	sta	MENU_OPTION
title_loop:

	lda	KEYPRESS
	bpl	done_title_keyboard

	bit	KEYRESET

	and	#$7f		; clear high bit
	and	#$df		; convert to uppercase

	cmp	#13		; exit if enter pressed
	beq	done_intro

	cmp	#'H'
	bne	not_help

	jsr	print_help
not_help:

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B		; up key
	bne	check_down
up_pressed:

	lda	MENU_OPTION
	beq	done_title_keyboard

	jsr	erase_marker

	dec	MENU_OPTION

	jsr	draw_marker

	jmp	done_title_keyboard

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A		; down key
	bne	done_title_keyboard

down_pressed:

	lda	MENU_OPTION
	cmp	#7
	beq	done_title_keyboard

	jsr	erase_marker

	inc	MENU_OPTION

	jsr	draw_marker

	jmp	done_title_keyboard


done_title_keyboard:
	inc	FRAMEL
	bne	noframeoflo
	inc	FRAMEH
noframeoflo:
	lda	FRAMEL
	bne	no_adjust_cursor

	lda	FRAMEH
	and	#$0f
	bne	no_adjust_cursor

	clc
	lda	WHICH_CURSOR
	adc	#1
	cmp	#3
	bne	no_cursor_oflo
	lda	#0

no_cursor_oflo:
	sta	WHICH_CURSOR

	jsr	draw_marker

no_adjust_cursor:
	jmp	title_loop

done_intro:

	; restore to full screen (no text)

	lda	MENU_OPTION
	cmp	#0
	beq	new_game	; new game
	cmp	#1
	beq	nothing		; continue game
	cmp	#2
	beq	do_story

nothing:
	jmp	title_loop

	;=====================
	;=====================
	; do story
	;=====================
	;=====================
do_story:
	bit	FULLGR
	bit	LORES

	lda	#LOAD_STORY
	sta	WHICH_LOAD		; assume new game (mars map)

	rts

	;=====================
	;=====================
	; new game
	;=====================
	;=====================
new_game:
init_vars:
	bit	FULLGR
	bit	LORES




	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	JOYSTICK_ENABLED
	sta	LEVEL_OVER

	sta	SCORE0			; set score to 0
	sta	SCORE1
	sta	SCORE2

	sta	RAYGUNS			; number of laser blasts
	sta	KEYCARDS
	sta	SHIP_PARTS
	sta	POGO

	lda	#4			; number of lives
	sta	KEENS


	;============================
	; set up initial location

	lda	#10
	sta	MARS_TILEX
	lda	#34
	sta	MARS_TILEY

	lda	#0
	sta	MARS_X
	sta	MARS_Y

	lda	#LOAD_MARS
	sta	WHICH_LOAD		; assume new game (mars map)

	rts


	;==========================
	; includes
	;==========================

	.include	"gr_pageflip.s"
	.include	"gr_copy.s"
;	.include	"wait_a_bit.s"
	.include	"gr_offsets.s"
	.include	"zx02_optim.s"

	.include	"text_help.s"
	.include	"gr_fast_clear.s"
	.include	"text_print.s"
	.include	"hgr_sprite.s"
	.include	"hgr_tables.s"

;	.include	"lc_detect.s"


	; pt3 player
;	.include "pt3_lib_core.s"
;	.include "pt3_lib_init.s"
;	.include "interrupt_handler.s"
;	.include "pt3_lib_mockingboard_detect.s"
;	.include "pt3_lib_mockingboard_setup.s"

new_title:
.incbin "graphics/keen1_title.hgr.zx02"

.include "graphics/title_sprites.inc"


	;====================================
	; wait for keypress or a few seconds
	;====================================

wait_a_bit:

	bit	KEYRESET
	tax

keyloop:
	lda	#200			; delay a bit
	jsr	WAIT

	lda	KEYPRESS
	bmi	done_keyloop

;	bmi	keypress_exit

	dex
	bne	keyloop

done_keyloop:
	bit	KEYRESET

	cmp	#'H'|$80
	bne	really_done_keyloop


	lda	#$04
	sta	DRAW_PAGE
	jsr	print_help
	bit	SET_GR
	lda	#$20
	sta	DRAW_PAGE
	bit	PAGE1

	ldx	#100

	jmp	keyloop

really_done_keyloop:


	rts

	;=============================
	; erase
	;=============================
erase_marker:
	lda	#<ball_bg
	sta	INL
	lda	#>ball_bg
	sta	INH

	lda	#12
	sta	SPRITE_X

	lda	MENU_OPTION
	asl
	asl
	asl
	clc
	adc	#55
	sta	SPRITE_Y

;	lda	#$20
;	sta	DRAW_PAGE

	jsr	hgr_draw_sprite

	rts



	;=============================
	; draw
	;=============================
draw_marker:
	ldx	WHICH_CURSOR
	lda	cursor_lookup_l,X
	sta	INL
	lda	cursor_lookup_h,X
	sta	INH

	lda	#12
	sta	SPRITE_X

	lda	MENU_OPTION
	asl
	asl
	asl
	clc
	adc	#55
	sta	SPRITE_Y

;	lda	#$20
;	sta	DRAW_PAGE

	jsr	hgr_draw_sprite

	rts

cursor_lookup_h:
	.byte	>ball0,>ball1,>ball2
cursor_lookup_l:
	.byte	<ball0,<ball1,<ball2


;PT3_LOC = theme_music

;.align $100
;theme_music:
;.incbin "audio/theme.pt3"

