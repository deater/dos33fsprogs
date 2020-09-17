; Monkey Title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

music_start = $4800

title_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	lda	#0
	sta	clear_all_color+1
	jsr	clear_all

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DRAW_PAGE
	sta	DISP_PAGE

setup_music:
	; decompress music

        lda	#<theme_lzsa
	sta	LZSA_SRC_LO
        lda	#>theme_lzsa
	sta	LZSA_SRC_HI
	lda	#$48			; load to page $4800
	jsr	decompress_lzsa2_fast

	jsr	mockingboard_detect

title_loop:

	;====================================
	; load LF logo
	;====================================

        lda	#<logo_lzsa
	sta	LZSA_SRC_LO
        lda	#>logo_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast


	jsr	gr_copy_to_current

logo_loop:

;	lda	GUYBRUSH_X
;	sta	XPOS
;	lda	GUYBRUSH_Y
;	sta	YPOS

;	lda	#<guybrush_back_sprite
;	sta	INL
;	lda	#>guybrush_back_sprite
;	sta	INH

;	jsr	put_sprite_crop


;	jsr	page_flip



	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:


	jsr	wait_until_keypressed


	;====================================
	; load LF logo
	;====================================

        lda	#<title_lzsa
	sta	LZSA_SRC_LO
        lda	#>title_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast


	jsr	gr_copy_to_current

	jsr	wait_until_keypressed

	;==========================
	; turn off music
	;==========================

	sei		; clear interrupts

	jsr	clear_ay_both

	;==========================
	; load main program
	;==========================

	lda	#LOAD_MONKEY
	sta	WHICH_LOAD

	rts

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_intro/title_graphics.inc"



;	.include	"end_level.s"
;	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
;	.include	"keyboard.s"
	.include	"gr_copy.s"
;	.include	"gr_putsprite_crop.s"
;	.include	"joystick.s"
;	.include	"gr_pageflip.s"
	.include	"decompress_fast_v2.s"
;	.include	"draw_pointer.s"
;	.include	"common_sprites.inc"
;	.include	"guy.brush"

;	.include	"monkey_actions.s"
;	.include	"update_bottom.s"

	.include	"ym_play.s"
	.include	"interrupt_handler.s"
	.include	"mockingboard.s"

wait_until_keypressed:
	lda	KEYPRESS
	bpl	wait_until_keypressed

	bit	KEYRESET

	rts


; music is compressed
; decompressed it is 30720 bytes
; we decompress to $4800
; so total size of our code can't be biggr than $2800 = 10k

theme_lzsa:
.incbin	"music/theme.lzsa"

