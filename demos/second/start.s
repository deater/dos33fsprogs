; Unwisely messing with Second Reality

;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "music.inc"

second_start:
	;=====================
	; initializations
	;=====================

	;=====================
	; detect model
	;=====================

	jsr	detect_appleii_model

	;=====================
	; Machine workarounds
	;=====================
	; mostly IIgs
	; thanks to 4am for this code from total replay

	lda	ROM_MACHINEID
	cmp	#$06
	bne     not_a_iigs
	sec
	jsr	$FE1F		; check for IIgs
	bcs	not_a_iigs

	; gr/text page2 handling broken on early IIgs models
	; this enables the workaround

	jsr     ROM_TEXT2COPY		; set alternate display mode on IIgs
	cli				; enable VBL interrupts

	; also set background color to black instead of blue
	lda	NEWVIDEO
	and	#%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta	NEWVIDEO
	lda	#$F0
	sta	TBCOLOR		; white text on black background
	lda	#$00
	sta	CLOCKCTL	; black border
	sta	CLOCKCTL	; set twice for VidHD

not_a_iigs:


	;===================
	; restart?
	;===================
restart:
	lda	#0
	sta	DRAW_PAGE

	;===================
	; show title screen
	;===================

	jsr	show_title


	;===================
	; print config
	;===================

	jsr	set_normal

	lda	#<config_string
	sta	OUTL
	lda	#>config_string
	sta	OUTH

	jsr	move_and_print

	; print detected model

	lda	APPLEII_MODEL
	ora	#$80
	sta	$7d0+8                  ; 23,8

	; if GS print the extra S
	cmp	#'G'|$80
	bne	not_gs
	lda	#'S'|$80
	sta	$7d0+9

not_gs:

	;=========================================
	; detect if we have a language card (64k)
	;===================================
	; we might want to later load sound high,
	;	for now always enable sound


	lda	#0
	sta	SOUND_STATUS	; clear out, sound enabled

	jsr	detect_language_card
	bcs	no_language_card

yes_language_card:
	; update status on title screen
	lda	#'6'|$80
	sta	$7d0+11         ; 23,11
	lda	#'4'|$80
	sta	$7d0+12		; 23,12

	; update sound status
	lda	SOUND_STATUS
	ora	#SOUND_IN_LC
	sta	SOUND_STATUS

;	jmp	done_language_card

no_language_card:

done_language_card:

	;===================================
	; Detect Mockingboard
	;===================================

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

	sta     $7d0+31                 ; 23,31


	; for now, don't require language card
	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	dont_enable_mc

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

	;==================================
	; load sound into the language card
	;       into $D000 set 1
	;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda	#1
	sta	WHICH_LOAD

	jsr	load_file

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; patch mockingboard

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

	jsr	pt3_init_song





dont_enable_mc:

mockingboard_notfound:

skip_all_checks:


	;=======================
	; wait for keypress
	;=======================

;	jsr	wait_until_keypress

	lda	#25
	jsr	wait_a_bit



	;===================
	; Load graphics
	;===================
load_loop:

;	jsr	HGR
	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	;=======================
	; start music
	;=======================

	lda	#3
;	lda	#2

	sta	WHICH_LOAD

	jsr	load_file


	cli

	jmp	$4000

forever:
	jmp	forever

.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"

.include "title.s"

config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0

.include "pt3_lib_mockingboard_patch.s"

