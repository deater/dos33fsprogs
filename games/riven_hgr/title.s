; Riven HGR Title Screen

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "qload.inc"

.if DISK=00
	.include "disk00_files/disk00_defines.inc"
.endif

.if DISK=01
	.include "disk01_files/disk01_defines.inc"
.endif

.if DISK=02
	.include "disk02_files/disk02_defines.inc"
.endif

.if DISK=03
	.include "disk03_files/disk03_defines.inc"
.endif

.if DISK=04
	.include "disk04_files/disk04_defines.inc"
.endif

.if DISK=05
	.include "disk05_files/disk05_defines.inc"
.endif

.if DISK=06
	.include "disk06_files/disk06_defines.inc"
.endif

.if DISK=10
	.include "disk10_files/disk10_defines.inc"
.endif

.if DISK=16
	.include "disk16_files/disk16_defines.inc"
.endif

.if DISK=38
	.include "disk38_files/disk38_defines.inc"
.endif

.if DISK=39
	.include "disk39_files/disk39_defines.inc"
.endif

.if DISK=40
	.include "disk40_files/disk40_defines.inc"
.endif

.if DISK=41
	.include "disk41_files/disk41_defines.inc"
.endif

.if DISK=43
	.include "disk43_files/disk43_defines.inc"
.endif

.if DISK=44
	.include "disk44_files/disk44_defines.inc"
.endif

.if DISK=50
	.include "disk50_files/disk50_defines.inc"
.endif

.if DISK=60
	.include "disk60_files/disk60_defines.inc"
.endif


riven_title:

	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	; set disk# (DISK provided at compile time)

	lda	#48+(DISK/10)
	sta	title_text+28
	lda	#48+(DISK-((DISK/10)*10))
	sta	title_text+29

	; setup text screen

	lda	#0
	sta	DRAW_PAGE

	; print non-inverse

	jsr	set_normal

	; print the title screen text
	lda	#<title_text
	sta	OUTL
	lda	#>title_text
	sta	OUTH
	jsr	move_and_print_list


	;===================
	; detect hardware

	jsr	hardware_detect

	;=============================
	; set up model string to print

	lda	#<model_string
	sta	OUTL
	lda	#>model_string
	sta	OUTH

	lda	APPLEII_MODEL
	sta	model_string+19

	; special case IIgs, need to print two characters
	cmp	#'g'
	bne	go_print

	lda	#'s'
	sta	model_string+20

go_print:

	jsr	move_and_print

	;===========================
	; patch lowercase printing
	;===========================
	; urgh, II,+ patch, e/c/gs no?  there are other
	;	corner cases we're going to miss here

	lda	APPLEII_MODEL
	cmp	#'+'
	beq	patch_uppercase
	cmp	#' '
	beq	patch_uppercase

non_ii_or_iiplus:
	sta	$C00F	; ALTCHR, allow lowercase inverse
;	lda	#$7f
;	sta	set_inverse+1
	jmp	no_patch_uppercase

patch_uppercase:
	jsr	force_uppercase
no_patch_uppercase:

	;==========================
	; wait a bit
	;==========================


	ldx	#50
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
	; Load title graphic
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
	; we will use it for sound later if detected
	;===================================

	lda	#0
	sta	SOUND_STATUS		; clear out, sound enabled

	jsr	detect_language_card
	bcs	no_language_card

	; update sound status
	lda	SOUND_STATUS
	ora	#SOUND_IN_LC
	sta	SOUND_STATUS

no_language_card:

	; currently no music so no need for Mockingboard code

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

	; we currently don't do this as we were over-writing
	;	things that shouldn't.  It is living dangerously
	;	not clearing things out though

	; clear out zero page values to 0
	;	clear everything from $80 .. $A0?

;	lda	#0
;	ldx	#$20
;clear_loop:
;	sta	$80,X
;	dex
;	bpl	clear_loop

	lda	#0
	sta	LEVEL_OVER
	sta	STATE_MAGLEV		; init maglevs
	sta	STATE_DOORS		; reset doors
	sta	STATE_SWITCHES		; reset switches
	sta	STATE_EVENTS		; reset events
	sta	ROOM_ROTATION		; reset room rotation
;	sta	JOYSTICK_ENABLED

	; init hi-res graphics

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables

	; initial cursor location

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	;===================================
	; Wait a bit
	;===================================

	; wait a bit at LOAD screen

	ldx	#100
	jsr	wait_a_bit


	;=============================
	; show menu
	;=============================

	jsr	clear_bottom
	bit	TEXTGR

	; print text
	lda	#<menu_text
	sta	OUTL
	lda	#>menu_text
	sta	OUTH
	jsr	move_and_print_list

	lda	#0
	sta	COUNT

pointer_loop:

	lda	COUNT
	bne	show_pointer2

show_pointer1:
	; show pointer
	lda	#<menu_pointer1
	sta	OUTL
	lda	#>menu_pointer1
	jmp	show_pointer_common

show_pointer2:
	; show pointer
	lda	#<menu_pointer2
	sta	OUTL
	lda	#>menu_pointer2

show_pointer_common:
	sta	OUTH

	; print the text

	jsr	move_and_print_list

pointer_keyloop:
	lda	KEYPRESS
	bpl	pointer_keyloop

	cmp	#$8d
	beq	done_pointer_loop

	lda	COUNT
	eor	#$1
	sta	COUNT

	bit	KEYRESET

	jmp	pointer_loop

done_pointer_loop:

	lda	COUNT
	bne	game_continue

	;==========================
	; new game
	;	start with disk0, the intro
	;	should clear out variables too in case
	;	we ever implement save game support
game_new:

	; there must be a way to do this better, but for now waste
	;	a disk change slot on each disk with the opener

	lda	#$E0|5
	sta	LEVEL_OVER

	rts

game_continue:

.if DISK=00

	; start at arrival

	lda	#LOAD_START
	sta	WHICH_LOAD

	lda	#0
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=01
	lda	#LOAD_ARRIVAL
	sta	WHICH_LOAD		; assume new game (dome island)

	lda	#RIVEN_ARRIVAL
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=02
	lda	#LOAD_STEPS1
	sta	WHICH_LOAD

	lda	#RIVEN_STEPS1
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=03
	lda	#LOAD_DSTEPS1
	sta	WHICH_LOAD

	lda	#RIVEN_DOWN1
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=04
	lda	#LOAD_BRIDGE1
	sta	WHICH_LOAD

	lda	#RIVEN_BRIDGE1
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION
.endif

.if DISK=05
	lda	#LOAD_CHAIR
	sta	WHICH_LOAD

	lda	#RIVEN_ENTRANCE
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=06
	lda	#LOAD_ATRUS_JOURNAL
	sta	WHICH_LOAD

	lda	#RIVEN_JOURNAL
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif


.if DISK=10
	lda	#LOAD_15
	sta	WHICH_LOAD

	lda	#RIVEN_15
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=16
	lda	#LOAD_DOME_BRIDGE
	sta	WHICH_LOAD

	lda	#RIVEN_DOME_BRIDGE
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif




.if DISK=38
	lda	#LOAD_PROJECTOR
	sta	WHICH_LOAD

	lda	#RIVEN_PROJECTOR
	sta	LOCATION

	lda	#DIRECTION_S
	sta	DIRECTION

	; DEBUG -- doors open when start on this disk
	lda	STATE_DOORS
	ora	#TEMPLE_DOOR
	sta	STATE_DOORS

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

.if DISK=41
	lda	#LOAD_TUNNEL2
	sta	WHICH_LOAD		; south in tunnel

	lda	#RIVEN_TUNNEL5
	sta	LOCATION

	lda	#DIRECTION_S
	sta	DIRECTION
.endif

.if DISK=43
	lda	#LOAD_BRIDGE
	sta	WHICH_LOAD

	lda	#RIVEN_MID_BRIDGE
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION
.endif

.if DISK=44
	lda	#LOAD_PATH
	sta	WHICH_LOAD

	lda	#RIVEN_PATH
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION
.endif

.if DISK=50
	lda	#LOAD_CHIPPER
	sta	WHICH_LOAD

	lda	#RIVEN_CHIPPER
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif

.if DISK=60
	lda	#LOAD_SPIRES
	sta	WHICH_LOAD

	lda	#RIVEN_SPIRES
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION
.endif



	rts

	;==========================
	; includes
	;==========================

	.include	"hgr_tables.s"

	.include	"hardware_detect.s"

	.include	"lc_detect.s"

model_string:
.byte 0,23,"DETECTED APPLE II",0,0,0

riven_title_image:
.incbin "graphics_title/riven_title.hgr.zx02"

          ;01234567890123456789012345678901234567890
title_text:
.byte 0, 0,"LOADING RIVEN SUBSET DISK 00 V0.11",0
;
;

;
.byte 0, 3,"CREDITS:",0
.byte 0, 4,"+ APPLE II PORT: VINCE 'DEATER' WEAVER",0
.byte 0, 5,"+ DISK CODE    : QKUMBA",0
.byte 0, 6,"+ ZX02 CODE    : DMSC",0
.byte 0, 7,"+ IIPIX        : K. KENNAWAY",0
.byte 0, 8,"+ SOUND        : O. SCHMIDT",0

.byte 12,10,"** DISCLAIMER **",0
.byte 0,12,"THIS PRODUCT CONTAINS TRADEMARKS AND/OR",0
.byte 7,13,"COPYRIGHTED WORKS OF CYAN.",0
.byte 6,14,"ALL RIGHTS RESERVED BY CYAN.",0
.byte 0,15,"THIS PRODUCT IS NOT OFFICIAL AND IS NOT",0
.byte 11,16,"ENDORSED BY CYAN.",0

;
.byte 8,18,       "______",0
.byte 6,19,     "A \/\/\/ SOFTWARE PRODUCTION",0
;
.byte 3,21, "HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0,$FF


menu_text:
.byte 10,21,"NEW GAME (SHOW INTRO)",0
.byte 10,22,"CONTINUE GAME FROM THIS DISK",0,$FF

menu_pointer1:
.byte 4,21,"---> ",0
.byte 4,22,"     ",0,$FF

menu_pointer2:
.byte 4,21,"     ",0
.byte 4,22,"---> ",0,$FF
