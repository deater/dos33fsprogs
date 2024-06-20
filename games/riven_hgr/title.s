; Riven HGR Title Screen

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "qload.inc"

.if DISK=01
	.include "disk01_files/disk01_defines.inc"
.endif

.if DISK=39
	.include "disk39_files/disk39_defines.inc"
.endif

.if DISK=40
	.include "disk40_files/disk40_defines.inc"
.endif

.if DISK=43
	.include "disk43_files/disk43_defines.inc"
.endif


riven_title:

	;============================
	; check to see if new game
	;	if so print title screen
	;	otherwise we get here after flipping disks
	;	so skip all the init

;	lda	NEW_GAME
;	bne	new_game

;	jmp	disk_change

new_game:
	;===========================
	; print the title message that used to be
	;	in hello.bas


	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	; set disk#

	lda	#48+(DISK/10)
	sta	title_text+28
	lda	#48+(DISK-((DISK/10)*10))
	sta	title_text+29



	; clear text screen

;	jsr	clear_all

	lda	#0
	sta	DRAW_PAGE

	; print non-inverse

	jsr	set_normal

	; print messages
	lda	#<title_text
	sta	OUTL
	lda	#>title_text
	sta	OUTH

	; print the text

	ldx	#7
title_loop:

	jsr	move_and_print

	dex
	bne	title_loop


loader_start:

	jsr	hardware_detect

	lda	#<model_string
	sta	OUTL
	lda	#>model_string
	sta	OUTH

	lda	APPLEII_MODEL
	sta	model_string+17

	cmp	#'g'
	bne	go_print

	lda	#'s'
	sta	model_string+18

go_print:

	ldy	#0
print_model:
	lda	(OUTL),Y
	beq	print_model_done
	ora	#$80
	sta	$7d0,Y
	iny
	jmp	print_model
print_model_done:


	;==========================
	; wait a bit
	;==========================


	lda	#50
	jsr	wait_a_bit


	;==========================
	; start graphics
	;==========================


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

	lda	#<riven_title_image
	sta	ZX0_src
	lda	#>riven_title_image
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


	; clear out zero page values to 0
	;	clear everything from $80 .. $A0?

	lda	#0
	ldx	#$20
clear_loop:
	sta	$80,X
	dex
	bpl	clear_loop


	; init hi-res graphics

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables


;	lda	#0
;	sta	JOYSTICK_ENABLED
;	sta	UPDATE_POINTER
;	sta	HOLDING_ITEM
;	sta	HOLDING_PAGE

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	;===================================
	; Do Intro Sequence
	;===================================

	; wait a bit at LOAD screen

	lda	#100
	jsr	wait_a_bit

.if DISK=01
	lda	#LOAD_ARRIVAL
	sta	WHICH_LOAD		; assume new game (dome island)

	lda	#RIVEN_ARRIVAL
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=39
	lda	#LOAD_OUTSIDE
	sta	WHICH_LOAD		; assume new game (dome island)

	lda	#RIVEN_MAGLEV1
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=40
	lda	#LOAD_MAGLEV
	sta	WHICH_LOAD		; sitting in maglev

	lda	#RIVEN_INSEAT
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION
.endif

.if DISK=43
	lda	#LOAD_CART
	sta	WHICH_LOAD

	lda	#RIVEN_OUTSIDE_CART
	sta	LOCATION

	lda	#DIRECTION_S
	sta	DIRECTION
.endif


	rts

	;==========================
	; includes
	;==========================

	.include	"hgr_tables.s"

	.include	"wait_a_bit.s"

	.include	"hardware_detect.s"

;	.include	"text_print.s"

;	.include	"gr_offsets.s"

;	.include	"lc_detect.s"

model_string:
.byte "DETECTED APPLE II",0,0,0




riven_title_image:
.incbin "graphics_title/riven_title.hgr.zx02"

title_text:
.byte 0, 0,"LOADING RIVEN SUBSET DISK 00 V0.04",0
;
;
.byte 0, 3,"BASED ON RIVEN BY CYAN",0
;
;
.byte 0, 6,"APPLE II PORT: VINCE WEAVER",0
.byte 0, 7,"DISK CODE    : QKUMBA",0
;
.byte 0, 9,"       ______",0
.byte 0,10,"     A \/\/\/ SOFTWARE PRODUCTION",0
;
.byte 0,12," HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0

