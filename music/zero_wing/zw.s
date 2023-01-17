; Zero Wing Into
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "music.inc"

zw_start:
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

	;=======================
	; start music
	;=======================

	cli




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
	bit	TEXTGR
	bit	PAGE0


	;=============================
	; In AD...
	;=============================

	jsr	clear_bottom

	lda	#<inad_text
	sta	OUTL
	lda	#>inad_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; War was beginning
	;=============================


	jsr	clear_bottom

	lda	#<ship_data
	sta	zx_src_l+1

	lda	#>ship_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; OPERATOR
	;=============================

	jsr	clear_bottom

	lda	#<operator_data
	sta	zx_src_l+1

	lda	#>operator_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<operator_text
	sta	OUTL
	lda	#>operator_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

	jsr	wait_until_keypress


	;=============================
	; CATS
	;=============================

	jsr	clear_bottom

	lda	#<cats_data
	sta	zx_src_l+1

	lda	#>cats_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<cats_text
	sta	OUTL
	lda	#>cats_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; CAPTAIN
	;=============================

	jsr	clear_bottom

	lda	#<captain_data
	sta	zx_src_l+1

	lda	#>captain_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<captain_text
	sta	OUTL
	lda	#>captain_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress





	jmp	load_loop




.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"
;	.include	"text_print.s"
;	.include	"gr_offsets.s"


inad_text:
	.byte 14,21,"IN A.D. 2101",0
war_text:
	.byte 11,21,"WAR WAS BEGINNING.",0
what_text:
	.byte 0,21,"CAPTAIN: WHAT HAPPEN ?",0	; scroll
bomb_text:
	.byte 0,21,"MECHANIC: SOMEBODY SET UP US",0
	.byte 10,21,         "THE BOMB.",0
operator_text:
	.byte 0,20,"OPERATOR: WE GET SIGNAL.",0
	.byte 1,22, "CAPTAIN: WHAT !",0
main_text:
	.byte 0,20,"OPERATOR: MAIN SCREEN TURN ON.",0
you_text:
	.byte 0,20,"CAPTAIN: IT'S YOU !!",0
cats_text:
	.byte 0,21,"CATS: HOW ARE YOU GENTLEMEN !!",0
base_text:
	.byte 0,21,"CATS: ALL YOUR BASE ARE BELONG",0
	.byte 6,22,      "TO US.",0
destruction_text:
	.byte 0,21,"CATS: YOU ARE ON THE WAY TO",0
	.byte 6,22,      "DESTRUCTION.",0
captain_text:
	.byte 0,21,"CAPTAIN: WHAT YOU SAY !!",0
survive_text:
	.byte 0,21,"CATS: YOU HAVE NO CHANCE TO",0
	.byte 6,22,      "SURVIVE MAKE YOUR TIME.",0
ha_text:
	.byte 0,21,"CATS: HA HA HA HA ....",0
op_cap_text:
	.byte 0,21,"OPERATOR: CAPTAIN !!",0
zig_text:
	.byte 0,21,"CAPTAIN: TAKE OFF EVERY 'ZIG'!!",0
doing_text:
	.byte 0,21,"CAPTAIN: YOU KNOW WHAT YOU DOING.",0
move_zig_text:
	.byte 0,21,"CAPTAIN: MOVE 'ZIG'.",0
justice_text:
	.byte 0,21,"CAPTAIN: FOR GREAT JUSTICE.",0

cats_data:
	.incbin "graphics/cats.hgr.zx02"

captain_data:
	.incbin "graphics/captain.hgr.zx02"

operator_data:
	.incbin "graphics/operator.hgr.zx02"

ship_data:
	.incbin "graphics/ship.hgr.zx02"

hands_data:
	.incbin "graphics/hands.hgr.zx02"


.include "title.s"

config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0

.include "pt3_lib_mockingboard_patch.s"

