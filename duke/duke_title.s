; Duke Title

; loads a HGR version of the title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

duke_title_start:
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

	lda     #<new_title
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>new_title
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

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

	;============================
	; init vars

;	jsr	init_state

	;============================
	; set up initial location

	lda	#LOAD_DUKE1
	sta	WHICH_LOAD		; start at first level

	rts


	;==========================
	; includes
	;==========================

	.include	"gr_pageflip.s"
	.include	"gr_copy.s"
	.include	"wait_a_bit.s"
	.include	"gr_offsets.s"
	.include	"decompress_fast_v2.s"

;	.include	"init_state.s"
;	.include	"graphics_title/title_graphics.inc"
;	.include	"lc_detect.s"


	; pt3 player
;	.include "pt3_lib_core.s"
;	.include "pt3_lib_init.s"
;	.include "interrupt_handler.s"
;	.include "pt3_lib_mockingboard_detect.s"
;	.include "pt3_lib_mockingboard_setup.s"


;	.include "wait_a_bit.s"


new_title:
.incbin "title/new_title.lzsa"


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



;PT3_LOC = theme_music

;.align $100
;theme_music:
;.incbin "audio/theme.pt3"

