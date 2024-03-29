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
	; detect model
	;===================

	jsr	detect_appleii_model

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

	lda	#'S'+$80		; change NO to slot
	sta	$7d0+30

	lda	MB_ADDR_H		; $C4 = 4, want $B4 1100 -> 1011
	and	#$87
	ora	#$30

	sta	$7d0+31         ; 23,31

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

        jsr     mockingboard_patch      ; patch to work in slots other than 4?


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

	jsr	pt3_init_song

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

	lda	#40
	jsr	wait_a_bit


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
	; Do Intro Sequence
	;===================================

	; SKIP: broderbund logo (w music)
	; SKIP: cyan logo (with cyan theme)


	; wait a bit at MYST screen

	lda	#50
	jsr	wait_a_bit



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
	lda	#$20
	jsr	draw_and_wait

	; Second
	ldx	#<cyan2_lzsa
	ldy	#>cyan2_lzsa
	lda	#$FF
	jsr	draw_and_wait

	; Third
	ldx	#<cyan3_lzsa
	ldy	#>cyan3_lzsa
	lda	#$FE
	jsr	draw_and_wait

        jsr     mockingboard_disable_interrupt  ; disable music

        jsr     clear_ay_both

        jmp     cyan_title_done

cyan_title_nomb:
	; First
	ldx	#<cyan1_lzsa
	ldy	#>cyan1_lzsa
	lda	#5
	jsr	draw_and_wait

	; Second
	ldx	#<cyan2_lzsa
	ldy	#>cyan2_lzsa
	lda	#5
	jsr	draw_and_wait

	; Third
	ldx	#<cyan3_lzsa
	ldy	#>cyan3_lzsa
	lda	#30
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

	ldx	#<fissure_lzsa
	ldy	#>fissure_lzsa
	lda	#150
	jsr	draw_and_wait


	;===================================
	; FISSURE_BOOK_SMALL: starry expanse...
	;===================================

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

	ldx	#<fissure_book_small_lzsa
	ldy	#>fissure_book_small_lzsa
	lda	#115
	jsr	draw_and_wait

	;===================================
	; FISSURE_BOOK_BIG: I have tried to speculate...
	;===================================

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

	ldx	#<fissure_book_big_lzsa
	ldy	#>fissure_book_big_lzsa
	lda	#150
	jsr	draw_and_wait

	;===================================
	; FALLING_LEFT: Still, the question...
	;===================================

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

	ldx	#<falling_left_lzsa
	ldy	#>falling_left_lzsa
	lda	#128
	jsr	draw_and_wait

	;===================================
	; FALLING_RIGHT: I know my aprehensions...
	;===================================

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

	ldx	#<falling_right_lzsa
	ldy	#>falling_right_lzsa
	lda	#143
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
	bit	LORES

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
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip
	pla
	jsr	wait_a_bit
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

	lda	#$BA    ; decompress to $BA00

	jsr	decompress_lzsa2_fast

	; re-enable interrupts as SSI code probably broke things

	jsr	mockingboard_init
	jsr	reset_ay_both

;	jsr	mockingboard_setup_interrupt

	; to make it work on IIc?
	jsr	done_iic_hack

	jsr	pt3_init_song

	cli
skip_start_music:

	lda	#TITLE_BOOK_CLOSED
	sta	LOCATION
	jmp	change_location


;PT3_LOC = theme_music
;
;.align $100
;theme_music:
;.incbin "audio/theme.pt3"


PT3_LOC = $BA00

cyan_music_compressed:
.incbin "audio/cyan.pt3.lzsa"
theme_music_compressed:
.incbin "audio/theme.pt3.lzsa"

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

config_string:
;             0123456789012345678901234567890123456789
.byte	0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0
;                             MOCKINGBOARD: NONE


; set normal text
set_normal:
        lda     #$80
        sta     ps_smc1+1

        lda     #09             ; ora
        sta     ps_smc1

        rts

        ; restore inverse text
set_inverse:
        lda     #$29
        sta     ps_smc1
        lda     #$3f
        sta     ps_smc1+1

        rts




load_linking_noise:
	; load sound effect into language card
	; do this late as IIc mockingboard support messes with language card

	 ; update sound status
        lda     SOUND_STATUS
        and     #SOUND_IN_LC
        beq     skip_load_linking_noise

        ; load sounds into LC

        ; read ram, write ram, use $d000 bank1
        bit     $C08B
        bit     $C08B

        lda     #<linking_noise_compressed
        sta     getsrc_smc+1
        lda     #>linking_noise_compressed
        sta     getsrc_smc+2

        lda     #$D0    ; decompress to $D000

        jsr     decompress_lzsa2_fast

   ; read rom, nowrite, use $d000 bank1
        bit     $C08A

skip_load_linking_noise:
	rts
