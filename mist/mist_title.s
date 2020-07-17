; Mist Title

; loads a HGR version of the title
; also handles the initial link to mist

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

mist_start:
	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR

	;===================
	; setup location
	;===================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	;===================
	; Load graphics
	;===================
reload_everything:

	lda     #<file
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>file
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	;===================================
	; detect if we have a language card
	; and load sound into it if possible
	;===================================

	lda	#0
	sta	SOUND_STATUS		; clear out, sound enabled

	jsr	detect_language_card
	bcs	no_language_card

	; update sound status
	lda	SOUND_STATUS
	ora	#SOUND_IN_LC
	sta	SOUND_STATUS

	; load sounds into LC

	; read ram, write ram, use $d000 bank1
	bit	$C08B
	bit	$C08B

	lda	#<linking_noise_compressed
	sta	getsrc_smc+1
	lda	#>linking_noise_compressed
	sta	getsrc_smc+2

	lda	#$D0	; decompress to $D000

	jsr	decompress_lzsa2_fast

blah:

	; read rom, nowrite, use $d000 bank1
	bit	$C08A

no_language_card:

	;====================================
	; wait for keypress or a few seconds

	bit	KEYRESET
	lda	#0
	sta	FRAMEL

keyloop:
	lda	#64			; delay a bit
	jsr	WAIT
	inc	FRAMEL
	lda	FRAMEL			; time out eventually
	beq	done_keyloop

	lda	KEYPRESS
	bpl	keyloop

done_keyloop:


	bit	KEYRESET



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
	sta	DRAW_PAGE

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	lda	#0
	sta	LEVEL_OVER

	;============================
	; init vars

	jsr	init_state

	;============================
	; set up initial location

	lda	#TITLE_MIST_LINKING_DOCK
	sta	LOCATION		; start at first room

	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_MIST		; load mist
	sta	WHICH_LOAD


	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first


game_loop:
	;=================
	; reset things
	;=================

	lda	#0
	sta	IN_SPECIAL
	sta	IN_RIGHT
	sta	IN_LEFT

	;====================================
	; copy background to current page
	;====================================

	jsr	gr_copy_to_current

	;====================================
	; handle special-case forground logic
	;====================================

	; handle animated linking book

	; note: the linking book to the dock doesn't have much action

nothing_special:

	;====================================
	; draw pointer
	;====================================

	jsr	draw_pointer

	;====================================
	; page flip
	;====================================

	jsr	page_flip

	;====================================
	; handle keypress/joystick
	;====================================

	jsr	handle_keypress


	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:

	;====================================
	; check level over
	;====================================

	lda	LEVEL_OVER
	bne	really_exit
	jmp	game_loop

really_exit:
	jmp	end_level




	;==========================
	; includes
	;==========================


	.include	"init_state.s"

	.include	"graphics_title/title_graphics.inc"

	.include	"lc_detect.s"

	; puzzles

	; linking books

	.include	"link_book_mist_dock.s"

	.include	"common_sprites.inc"

	.include	"leveldata_title.inc"


file:
.incbin "graphics_title_hgr/mist_title.lzsa"

linking_noise_compressed:
.incbin "audio/link_noise.btc.lzsa"

.align $100
theme_music:
.incbin "audio/theme.pt3"

; broderbund logo (w music)
; cyan logo (with cyan theme)
; myst letters appear (dramatic music)

; fissure: I realized the momemnt
; starry expanse (book big)
; falling by starscape (I have tried to speculate)
; falling again (still) /(left)
; I know my aprehensions (right)
; the ending has not yet been written (falls, blue sparks)
; click on book, plays theme

;                1         2         3
;      0123456789012345678901234567890123456789
.byte " I REALIZED, THE MOMENT I FELL INTO THE"
.byte "  FISSURE, THAT THE BOOK WOULD NOT BE"
.byte "       DESTROYED AS I HAD PLANNED."

;      0123456789012345678901234567890123456789
.byte " IT CONTINUED FALLING INTO THAT STARRY"
.byte "     EXPANSE OF WHICH I HAD ONLY A"
.byte "            FLEETING GLIMPSE."

;      0123456789012345678901234567890123456789
.byte "I HAVE TRIED TO SPECULATE WHERE IT MIGHT"
.byte "     HAVE LANDED, BUT I MUST ADMIT,"
.byte "  HOWEVER-- SUCH CONJECTURE IS FUTILE."

;      0123456789012345678901234567890123456789
.byte " STILL, THE QUESTION ABOUT WHOSE HANDS"
.byte "  MIGHT SOMEDAY HOLD MY MYST BOOK ARE"
.byte "            UNSETTLING TO ME."

;      0123456789012345678901234567890123456789
.byte "   I KNOW THAT MY APPREHENSIONS MIGHT"
.byte "    NEVER BE ALLAYED, AND SO I CLOSE,"
.byte "          REALIZING THAT PERHAPS,"

;      0123456789012345678901234567890123456789
.byte "  THE ENDING HAS NOT YET BEEN WRITTEN"

