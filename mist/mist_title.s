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
	; Load hires graphics
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

	lda	#8
	jsr	wait_a_bit


	;===================================
	; Setup Mockingboard
	;===================================
	lda	#0
	sta	DONE_PLAYING
	sta	LOOP

	; detect mockingboard
	jsr	mockingboard_detect

	bcc	mockingboard_notfound

mockingboard_found:
;       jsr     mockingboard_patch      ; patch to work in slots other than 4?

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr     pt3_init_song

	jmp     done_setup_sound


mockingboard_notfound:


done_setup_sound:



	;===================================
	; Do Intro Sequence
	;===================================

	; SKIP: broderbund logo (w music)
	; SKIP: cyan logo (with cyan theme)


	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE

	;===================================
	; M Y S T letters
	;===================================
	; missing the dramatic music
	; they should spin in, and letters are made of fire

	; M
	ldx	#<m_title_m_lzsa
	ldy	#>m_title_m_lzsa
	lda	#4
	jsr	draw_and_wait

	; Y
	ldx	#<m_title_y_lzsa
	ldy	#>m_title_y_lzsa
	lda	#4
	jsr	draw_and_wait

	; S
	ldx	#<m_title_s_lzsa
	ldy	#>m_title_s_lzsa
	lda	#4
	jsr	draw_and_wait

	; T
	ldx	#<m_title_t_lzsa
	ldy	#>m_title_t_lzsa
	lda	#25
	jsr	draw_and_wait

	;===================================
	; FISSURE: I realized the moment...
	;===================================
	; touch linking book as fissure pulses

	bit	TEXTGR			; split text/gr

	ldx	#<fissure_lzsa
	ldy	#>fissure_lzsa
	lda	#50
	jsr	draw_and_wait


	;===================================
	; FISSURE_BOOK_SMALL: starry expanse...
	;===================================

	ldx	#<fissure_book_small_lzsa
	ldy	#>fissure_book_small_lzsa
	lda	#50
	jsr	draw_and_wait

	;===================================
	; FISSURE_BOOK_BIG: I have tried to speculate...
	;===================================

	ldx	#<fissure_book_big_lzsa
	ldy	#>fissure_book_big_lzsa
	lda	#50
	jsr	draw_and_wait

	;===================================
	; FALLING_LEFT: Still, the question...
	;===================================

	ldx	#<falling_left_lzsa
	ldy	#>falling_left_lzsa
	lda	#50
	jsr	draw_and_wait

	;===================================
	; FALLING_RIGHT: I know my aprehensions...
	;===================================

	ldx	#<falling_right_lzsa
	ldy	#>falling_right_lzsa
	lda	#50
	jsr	draw_and_wait

	;===================================
	; BOOK_AIR : The ending...
	;===================================

	ldx	#<book_air_lzsa
	ldy	#>book_air_lzsa
	lda	#15
	jsr	draw_and_wait

	;===================================
	; BOOK_SPARKS : has not yet...
	;===================================

	ldx	#<book_sparks_lzsa
	ldy	#>book_sparks_lzsa
	lda	#15
	jsr	draw_and_wait

	;===================================
	; BOOK_GLOW : been written...
	;===================================

	ldx	#<book_glow_lzsa
	ldy	#>book_glow_lzsa
	lda	#15
	jsr	draw_and_wait

	;===================================
	; BOOK_GROUND :
	;===================================

	ldx	#<book_ground_lzsa
	ldy	#>book_ground_lzsa
	lda	#50
	jsr	draw_and_wait

	; restore to full screen (no text)

	bit	FULLGR

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

	lda	#TITLE_BOOK_GROUND
	sta	LOCATION		; start at first room

	lda	#DIRECTION_N
	sta	DIRECTION

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
	lda	LOCATION
	cmp	#TITLE_BOOK_OPEN
	bne	nothing_special

	lda	ANIMATE_FRAME
	cmp	#32		; if done animating, skip
	bcs	nothing_special

animate_ocean:
	cmp	#26
	bcs	animate_actual

	and	#1
	beq	even_ocean

odd_ocean:
	lda	#<dock_animate_sprite1
	sta	INL
	lda	#>dock_animate_sprite1
	jmp	draw_animation
even_ocean:
	lda	#<dock_animate_sprite2
	sta	INL
	lda	#>dock_animate_sprite2
	jmp	draw_animation

animate_actual:
	sec
	sbc	#26
	asl
	tay

	; slow down animation
	lda	#$3f
	sta	if_smc+1

	lda	dock_animation_sprites,Y
	sta	INL
	lda	dock_animation_sprites+1,Y

draw_animation:

	sta	INH
	lda	#24
	sta	XPOS
	lda	#12
	sta	YPOS
	jsr	put_sprite_crop

inc_frame:
	lda	FRAMEL
if_smc:
	and	#$f
	bne	done_inc_frame

	inc	ANIMATE_FRAME

done_inc_frame:

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


	; pt3 player
	.include "pt3_lib_core.s"
	.include "pt3_lib_init.s"
	.include "interrupt_handler.s"
	.include "pt3_lib_mockingboard_detect.s"
	.include "pt3_lib_mockingboard_setup.s"



file:
.incbin "graphics_title_hgr/mist_title.lzsa"

linking_noise_compressed:
.incbin "audio/link_noise.btc.lzsa"


	;====================================
	; draw a screen and wait
	;====================================
	; X = low of lzsa
	; Y = high of lzsa
	; A = pause delay

draw_and_wait:
	pha
	stx	getsrc_smc+1
	sty	getsrc_smc+2
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip
	pla
	jsr	wait_a_bit
	rts

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

	dex
	bne	keyloop

done_keyloop:

	bit	KEYRESET

	rts


get_mist_book:

	; play music if mockingboard

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	skip_start_music
	cli
skip_start_music:

	lda	#TITLE_BOOK_CLOSED
	sta	LOCATION
	jmp	change_location


PT3_LOC = theme_music

.align $100
theme_music:
.incbin "audio/theme.pt3"




.if 0


; click on book, plays theme





; FISSURE: I realized the momemnt

;                1         2         3
;      0123456789012345678901234567890123456789
.byte " I REALIZED, THE MOMENT I FELL INTO THE"
.byte "  FISSURE, THAT THE BOOK WOULD NOT BE"
.byte "       DESTROYED AS I HAD PLANNED."

; FISSURE_BOOK: _starry expanse (book tiny)

;      0123456789012345678901234567890123456789
.byte " IT CONTINUED FALLING INTO THAT STARRY"
.byte "     EXPANSE OF WHICH I HAD ONLY A"
.byte "            FLEETING GLIMPSE."

; FALLING_BOOK: (book big) falling by starscape (I have tried to speculate)

;      0123456789012345678901234567890123456789
.byte "I HAVE TRIED TO SPECULATE WHERE IT MIGHT"
.byte "     HAVE LANDED, BUT I MUST ADMIT,"
.byte "  HOWEVER-- SUCH CONJECTURE IS FUTILE."

; FALLING_LEFT (still, the question) /(left)
;      0123456789012345678901234567890123456789
.byte " STILL, THE QUESTION ABOUT WHOSE HANDS"
.byte "  MIGHT SOMEDAY HOLD MY MYST BOOK ARE"
.byte "            UNSETTLING TO ME."

; FALLING_RIGHT I know my aprehensions (right)
;      0123456789012345678901234567890123456789
.byte "   I KNOW THAT MY APPREHENSIONS MIGHT"
.byte "    NEVER BE ALLAYED, AND SO I CLOSE,"
.byte "          REALIZING THAT PERHAPS,"

; BOOK_GROUND the ending has not yet been written (falls, blue sparks)
;      0123456789012345678901234567890123456789
.byte "  THE ENDING HAS NOT YET BEEN WRITTEN"


.endif
