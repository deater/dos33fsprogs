; star_lady startup

;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload.inc"
;.include "music.inc"

DEBUG=0

star_lady_start:
	;=====================
	; initializations
	;=====================

	bit	PAGE1
	bit	KEYRESET

	jsr	hardware_detect

	lda	APPLEII_MODEL
	sta	message_type_offset

	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=====================
	; clear text screen

	lda	#$A0
	jsr	clear_top_a
	jsr	clear_bottom

	; print start message

	jsr	set_normal

	lda	#<start_message
	sta	OUTL
	lda	#>start_message
	sta	OUTH

	jsr	move_and_print_list

	;===============================
	; pause at warning if not e/c/gs

	lda	APPLEII_MODEL
	cmp	#'e'
	beq	good_to_go
	cmp	#'g'
	beq	good_to_go
	cmp	#'c'
	beq	good_to_go

	jsr	wait_until_keypress

good_to_go:

	;=========================================
	;=========================================
	; start loading the demo
	;=========================================
	;=========================================

	;==================================
	; load music into the language card
	;       into $D000 set 1
	;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda	#PART_MUSIC		; load MUSIC from disk
	sta	WHICH_LOAD

	jsr	load_file

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; patch mockingboard

	lda	SOUND_STATUS
	beq	skip_mbp1

        jsr     mockingboard_patch      ; patch to work in slots other than 4?

skip_mbp1:

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

skip_all_checks:


	jsr	hgr_make_tables


	;=======================
	;=======================
	; Run ANIMATION
	;=======================
	;=======================

	; load from disk

	sei
	lda	#PART_ANIMATION	; Load bucket
	sta	WHICH_LOAD
	jsr	load_file

	; Run Animation

;	cli			; start music

	jsr	$6000

blah:
	jmp	blah


start_message:	  ;01234567890123456789012345678901234567890
	.byte 0,0,"LOADING STAR_LADY 2025 V1.0",0
	.byte 0,1,"REQUIRES APPLE II, MOCKINGBOARD",0
	.byte 0,3,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0
	.byte 0,10,"MUSIC: INTRO THEME BY ALEX ROSTOV",0
	.byte 0,12,"GRAPHICS BY @REDLOT_TO",0
	.byte 0,16,"FAST DISK LOAD BY QKUMBA",0
	.byte 0,17,"ZX02 DECOMPRESSION BY DMSC",0
	.byte 0,18,"EVERYTHING ELSE BY DEATER",0
	.byte 10,20,"  ______",0
	.byte 10,21,"A \/\/\/ PRODUCTION",0
	.byte $FF

;load_message:
;	.byte 16,22,	"LOADING",0
