; Keen1 Title

; loads a HGR version of the title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

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
	; Do Intro Sequence
	;===================================

	; wait a bit at LOAD screen

	lda	#100
	jsr	wait_a_bit


done_intro:

	; restore to full screen (no text)

	bit	FULLGR
	bit	LORES

	;=====================
	; init vars
	;=====================
init_vars:
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

	lda	#LOAD_STORY

;	lda	#LOAD_MARS
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

;	.include	"lc_detect.s"


	; pt3 player
;	.include "pt3_lib_core.s"
;	.include "pt3_lib_init.s"
;	.include "interrupt_handler.s"
;	.include "pt3_lib_mockingboard_detect.s"
;	.include "pt3_lib_mockingboard_setup.s"

new_title:
.incbin "graphics/keen1_title.hgr.zx02"



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

	bit	SET_TEXT
	jsr	print_help
	bit	SET_GR
	bit	PAGE1

	ldx	#100

	jmp	keyloop

really_done_keyloop:


	rts






;PT3_LOC = theme_music

;.align $100
;theme_music:
;.incbin "audio/theme.pt3"

