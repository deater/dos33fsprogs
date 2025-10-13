; Unnamed Demo

; for Demosplash 2025

; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload.inc"
;.include "music.inc"

DEBUG=0

ds25_start:
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



	;====================================
	;====================================
	; Clear DHGR PAGE1
	;	MAIN:$2000 and AUX:$2000
	;====================================
	;====================================

	lda	#0
	jsr	hgr_page1_clearscreen
	sta	WRAUX			; writes to AUX memory
	jsr	hgr_page1_clearscreen
	sta	WRMAIN			; writes back to MAIN memory

	;====================================
	;====================================
	; Pre-Load some programs into AUX MEM
	;====================================
	;====================================

	sta	$C008		; use MAIN zero-page/stack/language card

	;=============================
	; want to load !!2...3

	lda	#PART_INTRO
	sta	COUNT

load_program_loop:
	;============================
	; load from disk

	lda     COUNT		; which one
	sta     WHICH_LOAD
	jsr     load_file

	; copy to proper AUX location

	ldx	COUNT
	lda	aux_dest,X		; load AUX dest
	pha

	ldy	load_address_array,X	; where we loaded in MAIN

	lda	length_array,X	; number of pages
	tax			; in X
	pla			; restore AUX dest to A

	jsr	copy_main_aux

	inc	COUNT
	lda	COUNT
	cmp	#4
	bne	load_program_loop

	;=======================
	;=======================
	; Run fourcolor
	;=======================
	;=======================

	; load from disk

	sei
	lda	#PART_FOURCOLOR	; Multi-color monster
	sta	WHICH_LOAD
	jsr	load_file

	; Run Four Color

	cli			; start music

	jsr	$6000


	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

	; copy HEADPHONES from AUX $6000 to MAIN $6000

	lda	#$60		; AUX src $6000
	ldy	#$60		; MAIN dest $6000
	ldx	#32		; 8k*4 = 32 pages
	jsr	copy_aux_main

	; run headphones

	cli			; start music
	jsr	$6000

	;=======================
	;=======================
	; Run Dancing
	;=======================
	;=======================

	; copy DANCING from AUX $8000 to MAIN $2000

;	lda	#$80		; AUX src $8000
;	ldy	#$20		; MAIN dest $2000
;	ldx	#32		; 8k*4 = 32 pages
;	jsr	copy_aux_main

	; Also copy from MAIN $2000 to AUX $2000.  Inefficient :(

;	lda	#$20		; AUX dest $2000
;	ldy	#$20		; MAIN src $2000
;	ldx	#32		; 8k*4
;	jsr	copy_main_aux

;	sei				; stop music interrupts
;	jsr	mute_ay_both
;	jsr	clear_ay_both		; stop from making noise

	; load dancing

;	lda	#PART_DANCING		; Dancing
;	sta	WHICH_LOAD
;	jsr	load_file


	; restart music

;	cli		; start interrupts (music)

	;======================
	; start dancing

;	jsr	$2000


blah:
	jmp	blah


start_message:	  ;01234567890123456789012345678901234567890
	.byte 0,0,"LOADING UNNAMED DEMO / dSr",0
	.byte 0,1,"DEMOSPLASH 2025",0
	.byte 0,2,"REQUIRES APPLE IIE, 128K, MOCKINGBOARD",0
	.byte 0,3,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0
	.byte 0,10,"MUSIC BY mAZE",0
	.byte 0,12,"GRAPHICS BY GRIMNIR",0
	.byte 0,13,"DISK BY QKUMBA",0
	.byte 0,14,"WIPES BY 4AM/QKUMBA",0
	.byte 0,16,".",0
	.byte 0,17,"ZX02 DECOMPRESSION BY DMSC",0
	.byte 0,18,"EVERYTHING ELSE BY DEATER",0
	.byte 10,20,".",0
	.byte 10,21,".",0
	.byte $FF

;load_message:
;	.byte 16,22,	"LOADING",0
