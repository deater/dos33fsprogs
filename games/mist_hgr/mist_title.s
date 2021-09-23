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
	; init vgi
	;===================

	lda	#$20
	sta	HGR_PAGE	; put this somewhere else?

	jsr	vgi_init

	;===================
	; detect model
	;===================

	jsr     detect_appleii_model

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
	; print config
	;===================

	; print non-inverse
	jsr	set_normal

	lda	#<config_string
	sta	OUTL
	lda	#>config_string
	sta	OUTH

	jsr	move_and_print

	; print detected model

	lda	APPLEII_MODEL
	ora	#$80
	sta	$7d0+8		; 23,8

	; if GS print the extra S
	cmp	#'G'|$80
	bne	not_gs
	lda	#'S'|$80
	sta	$7d0+9

not_gs:

	;===================================
	; detect if we have a language card
	; and load sound into it if possible
	;===================================

	lda	#0
	sta	SOUND_STATUS		; clear out, sound enabled

	jsr	detect_language_card
	bcs	no_language_card

yes_language_card:
	; update status
	lda	#'6'|$80
	sta	$7d0+11		; 23,11
	lda	#'4'|$80
	sta	$7d0+12		; 23,12

	; update sound status
	lda	SOUND_STATUS
	ora	#SOUND_IN_LC
	sta	SOUND_STATUS
no_language_card:

	;===================================
	; Setup Mockingboard
	;===================================

PT3_ENABLE_APPLE_IIC = 1

	lda	#0
	sta	DONE_PLAYING
	sta	LOOP

	; detect mockingboard
	jsr	mockingboard_detect

	bcc	mockingboard_notfound

mockingboard_found:

	; print detected location

	lda	#'S'+$80		; change NO to Slot
	sta	$7d0+30

	lda	MB_ADDR_H		; $C4 = 4, want $B4 1100 -> 1011
	and	#$87
	ora	#$30

	sta	$7d0+31		; 23,31

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

	;===========================
	; detect SSI-263 too
	;===========================
detect_ssi:
	lda	MB_ADDR_H
	and	#$87			; slot
	jsr	detect_ssi263

	lda	irq_count
	beq	ssi_not_found

	lda	#'Y'+$80
	sta	$7d0+39		; 23,39

	lda	#SOUND_SSI263
	ora	SOUND_STATUS
	sta	SOUND_STATUS

ssi_not_found:

	jsr	mockingboard_patch	; patch to work in slots other than 4?

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

	lda	#<cyan_music_compressed
	sta	getsrc_smc+1
	lda	#>cyan_music_compressed
	sta	getsrc_smc+2

        lda	#$BA	; decompress to $BA00

	jsr	decompress_lzsa2_fast

	jsr     pt3_init_song

	jmp     done_setup_sound


mockingboard_notfound:


done_setup_sound:

	lda	APPLEII_MODEL
	cmp	#'C'
	beq	link_noise_not_yet

	jsr	load_linking_noise
link_noise_not_yet:


	;==========================
	; wait a bit at text title
	;==========================

	lda	#$40
	jsr	wait_a_bit

	;===================
	; setup HGR
	;===================

	; we could just call HGR here instead?

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
	; Do Intro Sequence
	;===================================

	; SKIP: broderbund logo (w music)

	; instead do a MYST screen (not in original)

	; wait a bit at MYST screen

	lda	#50
	jsr	wait_a_bit



	;===================
	; init screen
	;===================

	lda	#0
	sta	DRAW_PAGE

	;===================================
	; Cyan Logo
	;===================================
	; missing most of the animation
	; also missing (good) music

	; play music if mockingboard

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	cyan_title_nomb


cyan_title_mb:

	cli

	; First
	ldx	#<cyan1_lzsa
	ldy	#>cyan1_lzsa
	lda	#$FF
	jsr	draw_and_wait

	; Second
	ldx	#<cyan2_lzsa
	ldy	#>cyan2_lzsa
	lda	#$FE
	jsr	draw_and_wait

	jsr	mockingboard_disable_interrupt	; disable music

	jsr	clear_ay_both

	jmp	cyan_title_done

cyan_title_nomb:

	; First
	ldx	#<cyan1_lzsa
	ldy	#>cyan1_lzsa
	lda	#20
	jsr	draw_and_wait

	; Second
	ldx	#<cyan2_lzsa
	ldy	#>cyan2_lzsa
	lda	#40
	jsr	draw_and_wait
cyan_title_done:

	;===================================
	; M Y S T letters
	;===================================
	; missing the dramatic music
	; they should spin in, and letters are made of fire

	; M
	ldx	#<m_title_m_lzsa
	ldy	#>m_title_m_lzsa
	lda	#10
	jsr	draw_and_wait

	; Y
	ldx	#<m_title_y_lzsa
	ldy	#>m_title_y_lzsa
	lda	#10
	jsr	draw_and_wait

	; S
	ldx	#<m_title_s_lzsa
	ldy	#>m_title_s_lzsa
	lda	#10
	jsr	draw_and_wait

	; T
	ldx	#<m_title_t_lzsa
	ldy	#>m_title_t_lzsa
	lda	#25
	jsr	draw_and_wait

	;===================================
	; FISSURE: I realized the moment...
	;===================================
	; "I REALIZED, THE MOMENT I FELL INTO THE"
	; "FISSURE, THAT THE BOOK WOULD NOT BE"
	; "DESTROYED AS I HAD PLANNED."

	; touch linking book as fissure pulses (says "Fissure")

fissure_speech:
	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	fissure_no_speech

	lda	ssi263_slot
	jsr	ssi263_speech_init

	lda	#<myst_fissure
	sta	SPEECH_PTRL
	lda	#>myst_fissure
	sta	SPEECH_PTRH

	jsr	ssi263_speak
fissure_no_speech:

	ldx	#<fissure_stars_lzsa
	ldy	#>fissure_stars_lzsa
	lda	#10
	jsr	draw_and_wait

	ldx	#<fissure_crescent_lzsa
	ldy	#>fissure_crescent_lzsa
	lda	#10
	jsr	draw_and_wait

	bit	TEXTGR			; split text/gr

	jsr	clear_bottom
	lda	#<narration1
	sta	OUTL
	lda	#>narration1
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	ldx	#<fissure_lzsa
	ldy	#>fissure_lzsa
	lda	#60
	jsr	draw_and_wait

	ldx	#<fissure2_lzsa
	ldy	#>fissure2_lzsa
	lda	#60
	jsr	draw_and_wait


	;===================================
	; FISSURE_BOOK_SMALL: starry expanse...
	;===================================
	; "Expanse" -> tiny book
	; "Glimpse" -> big book
	;
	; "IT CONTINUED FALLING INTO THAT STARRY",0
	; "EXPANSE OF WHICH I HAD ONLY A",0
	; "FLEETING GLIMPSE.",0

starry_speech:
	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	starry_no_speech

	lda	#<myst_starry
	sta	SPEECH_PTRL
	lda	#>myst_starry
	sta	SPEECH_PTRH

	jsr	ssi263_speak
starry_no_speech:

	jsr	clear_bottom

	ldx	#<fissure_book_small_lzsa
	ldy	#>fissure_book_small_lzsa
	lda	#1
	jsr	draw_and_wait

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	lda	#40
	jsr	wait_a_bit

	ldx	#<fissure_book_big_lzsa
	ldy	#>fissure_book_big_lzsa
	lda	#75
	jsr	draw_and_wait

	;===================================
	; FALLING_LEFT: I have tried to speculate...
	;===================================
	; screen goes black at "I"
	; falling book on left through landed
	; then fade out at "futile"
	;
	; "I HAVE TRIED TO SPECULATE WHERE IT MIGHT"
	; "HAVE LANDED, BUT I MUST ADMIT,"
	; "HOWEVER-- SUCH CONJECTURE IS FUTILE."

speculate_speech:
	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	speculate_no_speech

	lda	#<myst_speculate
	sta	SPEECH_PTRL
	lda	#>myst_speculate
	sta	SPEECH_PTRH

	jsr	ssi263_speak
speculate_no_speech:

	jsr	clear_bottom

	ldx	#<starfield_lzsa
	ldy	#>starfield_lzsa
	lda	#1
	jsr	draw_and_wait


	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	ldx	#<falling_left_top_lzsa
	ldy	#>falling_left_top_lzsa
	lda	#31
	jsr	draw_and_wait

	ldx	#<falling_left_center_lzsa
	ldy	#>falling_left_center_lzsa
	lda	#31
	jsr	draw_and_wait

	ldx	#<falling_left_bottom_lzsa
	ldy	#>falling_left_bottom_lzsa
	lda	#31
	jsr	draw_and_wait

	ldx	#<erase_left_bottom_lzsa
	ldy	#>erase_left_bottom_lzsa
	lda	#50
	jsr	draw_and_wait

	;===================================
	; FALLING_RIGHT: Still, the question...
	;===================================
	; "STILL, THE QUESTION ABOUT WHOSE HANDS"
	; "MIGHT SOMEDAY HOLD MY MYST BOOK ARE"
	; "UNSETTLING TO ME."

unsettling_speech:
	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	unsettling_no_speech

	lda	#<myst_unsettling
	sta	SPEECH_PTRL
	lda	#>myst_unsettling
	sta	SPEECH_PTRH

	jsr	ssi263_speak
unsettling_no_speech:


	jsr	clear_bottom

	ldx	#<starfield_lzsa
	ldy	#>starfield_lzsa
	lda	#30
	jsr	draw_and_wait

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	ldx	#<falling_right_top_lzsa
	ldy	#>falling_right_top_lzsa
	lda	#30
	jsr	draw_and_wait

	ldx	#<falling_right_bottom_lzsa
	ldy	#>falling_right_bottom_lzsa
	lda	#30
	jsr	draw_and_wait

	ldx	#<erase_right_bottom_lzsa
	ldy	#>erase_right_bottom_lzsa
	lda	#35
	jsr	draw_and_wait

	;===================================
	; FALLING_LEFT_AGAIN: I know my aprehensions...
	;===================================
	; "I KNOW THAT MY APPREHENSIONS MIGHT"
	; "NEVER BE ALLAYED, AND SO I CLOSE,"
	; "REALIZING THAT PERHAPS,"

allayed_speech:
	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	allayed_no_speech

	lda	#<myst_allayed
	sta	SPEECH_PTRL
	lda	#>myst_allayed
	sta	SPEECH_PTRH

	jsr	ssi263_speak
allayed_no_speech:

	jsr	clear_bottom


	ldx	#<falling_left_top_lzsa
	ldy	#>falling_left_top_lzsa
	lda	#1
	jsr	draw_and_wait

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	lda	#20
	jsr	wait_a_bit

	ldx	#<falling_left_center_lzsa
	ldy	#>falling_left_center_lzsa
	lda	#30
	jsr	draw_and_wait

	ldx	#<falling_left_bottom_lzsa
	ldy	#>falling_left_bottom_lzsa
	lda	#30
	jsr	draw_and_wait

	ldx	#<erase_left_bottom_lzsa
	ldy	#>erase_left_bottom_lzsa
	lda	#45
	jsr	draw_and_wait

	;===================================
	; BOOK_AIR : The ending...
	;===================================

written_speech:
	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	written_no_speech

	lda	#<myst_written
	sta	SPEECH_PTRL
	lda	#>myst_written
	sta	SPEECH_PTRH

	jsr	ssi263_speak
written_no_speech:


	ldx	#<book_ground_stars_lzsa
	ldy	#>book_ground_stars_lzsa
	lda	#1
	jsr	draw_and_wait

	; the ending

	jsr	clear_bottom
	jsr	move_and_print

	ldx	#<book_air_lzsa
	ldy	#>book_air_lzsa
	lda	#10
	jsr	draw_and_wait

	; has not yet
	jsr	move_and_print

	ldx	#<book_air2_lzsa
	ldy	#>book_air2_lzsa
	lda	#10
	jsr	draw_and_wait

	; been written
	jsr	move_and_print

	ldx	#<book_air3_lzsa
	ldy	#>book_air3_lzsa
	lda	#10
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
	lda	#15
	jsr	draw_and_wait

;	jmp	done_intro


skip_intro:

;	ldx	#<book_ground_n_lzsa
;	ldy	#>book_ground_n_lzsa
;	lda	#1
;	jsr	draw_and_wait


	;================================
	; shut off speech if still going
	;================================

	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	no_not_speeking

	jsr	ssi263_speech_shutdown
no_not_speeking:


done_intro:

	; restore to full screen (no text)

	bit	FULLGR
;	bit	LORES

	; init cursor

	lda	#20
	sta	CURSOR_X
	lda	#89
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


	jsr	save_bg_14x14		; save initial bg

game_loop:
	;=================
	; reset things
	;=================


	;====================================
	; copy background to current page
	;====================================

;	jsr	gr_copyg_to_current

	;====================================
	; handle special-case forground logic
	;====================================

	; handle animated linking book
	lda	LOCATION
	cmp	#TITLE_BOOK_OPEN
	bne	nothing_special

	lda	ANIMATE_FRAME
	cmp	#37		; if done animating, skip
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
	jsr	animate_book

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

	jsr	draw_pointer				; draw pointer

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

	; clear to black
;	lda     #$80
;	jsr     BKGND0


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

;	.include	"common_sprites.inc"

	.include	"leveldata_title.inc"


	; pt3 player
	.include "pt3_lib_detect_model.s"
	.include "pt3_lib_core.s"
	.include "pt3_lib_init.s"
	.include "pt3_lib_mockingboard_setup.s"
	.include "interrupt_handler.s"
	.include "pt3_lib_mockingboard_detect.s"

	; ssi-263 code
	.include "ssi263.inc"
	.include "ssi263_simple_speech.s"
	.include "ssi263_detect.s"
	.include "title_speech.s"

	.include "wait_a_bit.s"


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
	lda	#$8			; load to page $800
	jsr	decompress_lzsa2_fast

	lda	#$0
	sta	VGIL
	lda	#$8
	sta	VGIH

	jsr	play_vgi

	pla

	jsr	wait_a_bit

	; check if escape was pressed, skip into in that case
	lda	LAST_KEY
	cmp	#27|$80				; check for ESCAPE
	bne	no_escape

	pla
	pla	; get return value off stack

	jmp	skip_intro

no_escape:

	rts


get_mist_book:

	; play music if mockingboard

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	skip_start_music

	lda	#$00
	sta	DONE_PLAYING

	lda	#<theme_music_compressed
	sta	getsrc_smc+1
	lda	#>theme_music_compressed
	sta	getsrc_smc+2

        lda	#$BA	; decompress to $BA00

	jsr	decompress_lzsa2_fast

	; re-enable interrupts as SSI code probably broke things

	jsr	mockingboard_init
	jsr	reset_ay_both

;	jsr     mockingboard_setup_interrupt

	; to make it work on IIc?
	jsr	done_iic_hack


	jsr     pt3_init_song

	cli
skip_start_music:

	lda	#TITLE_BOOK_CLOSED
	sta	LOCATION
	jmp	change_location


PT3_LOC = $BA00

;.align $100
;theme_music:
cyan_music_compressed:
.incbin "audio/cyan.pt3.lzsa"
theme_music_compressed:
.incbin "audio/theme.pt3.lzsa"


; click on book, plays theme

; FISSURE: I realized the momemnt

narration1:
;                1         2         3
;      0123456789012345678901234567890123456789
.byte 1,20,"I REALIZED, THE MOMENT I FELL INTO THE",0
.byte 2,21,"FISSURE, THAT THE BOOK WOULD NOT BE",0
.byte 7,22,"DESTROYED AS I HAD PLANNED.",0
;.byte 1,20,"I realized, the moment I fell into the",0
;.byte 2,21,"fissure, that the book would not be",0
;.byte 7,22,"destroyed as I had planned.",0

; FISSURE_BOOK: _starry expanse (book tiny)

narration2:
;      0123456789012345678901234567890123456789
.byte 1,20,"IT CONTINUED FALLING INTO THAT STARRY",0
.byte 5,21,"EXPANSE OF WHICH I HAD ONLY A",0
.byte 12,22,"FLEETING GLIMPSE.",0

; FALLING_BOOK: (book big) falling by starscape (I have tried to speculate)
narration3:
;      0123456789012345678901234567890123456789
.byte 0,20,"I HAVE TRIED TO SPECULATE WHERE IT MIGHT",0
.byte 5,21,"HAVE LANDED, BUT I MUST ADMIT,",0
.byte 2,22,"HOWEVER-- SUCH CONJECTURE IS FUTILE.",0

narration4:
; FALLING_RIGHT (still, the question) /(left)
;      0123456789012345678901234567890123456789
.byte 1,20,"STILL, THE QUESTION ABOUT WHOSE HANDS",0
.byte 2,21,"MIGHT SOMEDAY HOLD MY MYST BOOK ARE",0
.byte 12,22,"UNSETTLING TO ME.",0

narration5:
; FALLING_LEFT_AGAIN I know my aprehensions (right)
;      0123456789012345678901234567890123456789
.byte 3,20,"I KNOW THAT MY APPREHENSIONS MIGHT",0
.byte 4,21,"NEVER BE ALLAYED, AND SO I CLOSE,",0
.byte 10,22,"REALIZING THAT PERHAPS,",0

narration6:
; BOOK_GROUND the ending has not yet been written (falls, blue sparks)
;      0123456789012345678901234567890123456789
;.byte 2,20,"  THE ENDING HAS NOT YET BEEN WRITTEN",0
.byte 2,20,"THE ENDING",0
.byte 13,20,"HAS NOT YET",0
.byte 25,20,"BEEN WRITTEN",0




config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0
;                             MOCKINGBOARD: NONE


	;==============================
	; animate book
	;==============================
	; animate a 9x12 animation at fixed location 161,41 (161/7=23)
	; sprite is in INL:INH
animate_book:

	lda	#40
	sta	YPOS

animate_book_yloop:

	ldy	#0
	ldx	#0
	lda	YPOS
	jsr	HPOSN	; (Y,X),(A)  (values stores in HGRX,XH,Y)

	clc
	lda	GBASL
	adc	#23
	sta	GBASL

	ldy	#0
animate_xloop:

	lda	(INL),Y
	sta	(GBASL),Y

	iny
	cpy	#9
	bne	animate_xloop

	inc	YPOS
	lda	YPOS

	cmp	#88
	beq	done_animate_book

	and	#$3
	bne	animate_book_yloop

	; only move to next line every 4 lines

	clc
	lda	INL
	adc	#9
	sta	INL
	lda	INH
	adc	#0
	sta	INH

	jmp	animate_book_yloop

done_animate_book:
	rts




load_linking_noise:
	; load sound effect into language card
	; do this late as IIc mockingboard support messes with language card

	; update sound status
	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	skip_load_linking_noise

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

	; read rom, nowrite, use $d000 bank1
	bit	$C08A

skip_load_linking_noise:
	rts
