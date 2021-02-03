; Display the TFV title screen
;
; this is the opener, title screen, new game creation, and load game code

.include "zp.inc"
.include "hardware.inc"
.include "common_defines.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	TEXTGR			; mixed gr/text mode
	bit	SET_GR			; set graphics

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	;==========================
	; Do Opening
	;==========================

	jsr	opening

	;======================
	; show the title screen
	;======================

	; Title Screen

title_screen:

	;===========================
	; Clear both bottoms

	jsr     clear_bottoms

	;=============================
	; Load title

	lda     #<(title_lzsa)
        sta     getsrc_smc+1
	lda     #>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$0c

	jsr     decompress_lzsa2_fast

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	lda	#20
	sta	YPOS
	lda	#20
	sta	XPOS


	;=================================
	; title menu loop
	;=================================

	lda	#0
	sta	menu_offset
	lda	#2
	sta	menu_max
title_menu_loop:
	lda	#<title_menu
	sta	OUTL
	lda	#>title_menu
	sta	OUTH

	jsr	draw_menu

	jsr	page_flip

	jsr	increment_frame

	lda	MENU_RESULT
	bmi	title_menu_loop

	; space was pressed!

	beq	title_new_game
	cmp	#1
	beq	title_load_game
	bne	title_load_credits


	;=================================
	; new game started!
	;=================================
title_new_game:

	;=================================
	; enter name

	jsr	enter_name


	;=================================
	; display story

	lda     #<(tfv_story_lzsa)
        sta     getsrc_smc+1
	lda     #>(tfv_story_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr     decompress_lzsa2_fast

	bit	SET_GR
	bit	HIRES
	lda	#0
	sta	DRAW_PAGE
	bit	PAGE0

	; continue the bottom of the "T"

	lda	#' '
	sta	$651		; 20,1

	lda	#<story_string1
	sta	OUTL
	lda	#>story_string1
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	; wait a bit before continuing
	ldx	#50
	jsr	long_wait
	bit	KEYRESET

	jsr	wait_until_keypressed


	jsr	move_and_print
	jsr	move_and_print


	; wait a bit before continuing
	ldx	#50
	jsr	long_wait
	bit	KEYRESET

	jsr	wait_until_keypressed



	; Initial starting values
	lda	#$1
	sta	HERO_LEVEL

	lda	#$01
	sta	HERO_HP_HI
	lda	#$00
	sta	HERO_HP_LO

	lda	#$20
	sta	HERO_MP
	sta	HERO_MP_MAX

	lda	#LOAD_FLYING
	sta	WHICH_LOAD

	rts

	;=================================
	; load game!  for now, debugging
	;=================================
title_load_game:

	jsr	load_game

	rts

	;=================================
	; load credits!
	;=================================
title_load_credits:
	lda	#LOAD_CREDITS
	sta	WHICH_LOAD

	rts



	;===============================
	; increment frame
	;===============================
increment_frame:
	inc	FRAMEL
	bne	done_increment_frame
	inc	FRAMEH
done_increment_frame:
	rts

;===============================================
; External modules
;===============================================

.include "tfv_opener.s"

.include "gr_pageflip.s"
.include "text_print.s"
.include "gr_fast_clear.s"
.include "gr_vlin.s"
.include "gr_copy.s"
.include "decompress_fast_v2.s"
.include "gr_offsets.s"
.include "wait_keypressed.s"
.include "tfv_textentry.s"
.include "long_wait.s"

.include "keyboard.s"
.include "joystick.s"
.include "draw_menu.s"
.include "load_game.s"

;===============================================
; Data
;===============================================

story_string1:	;     0123456789012345678901234567890123456789
	.byte	2,20,  "HE STORY SO FAR...",0
	.byte	1,22,"THE EVIL DR. ROBO-KNEE HAS KIDNAPPED",0
	.byte	1,23,"YOUR GUINEA PIG COMPANION.",0

story_string2:	;     0123456789012345678901234567890123456789
	.byte	1,22,"YOU'VE TRACKED THEM TO THIS LARGE   ",0
	.byte	1,23,"BLUE PLANET.              ",0


title_menu:
	.byte   16,21,"NEW GAME",0
	.byte   16,22,"LOAD GAME",0
	.byte   16,23,"CREDITS",0
	.byte   255

.include "graphics_title/tfv_title.inc"
