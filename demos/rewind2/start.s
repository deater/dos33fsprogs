; Rewind2 PoC, Startup

;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload.inc"
;.include "music.inc"

DEBUG=0

rewind2_start:
	;=====================
	; initializations
	;=====================

	bit	PAGE1

	jsr	hardware_detect

	lda	APPLEII_MODEL
	sta	message_type_offset

	jsr	hgr_make_tables

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

	lda	APPLEII_MODEL
	cmp	#'e'
	beq	good_to_go

	jsr	wait_until_keypress

good_to_go:

	;=========================================
	;=========================================
	; start loading the demo
	;=========================================
	;=========================================

;	bit	SET_GR
;	bit	LORES		; set lo-res
;	bit	TEXTGR


;	lda	#<load_message
;	sta	OUTL
;	lda	#>load_message
;	sta	OUTH
;	jsr	move_and_print


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

.if 0

	;====================================
	;====================================
	; Pre-Load some programs into AUX MEM
	;====================================
	;====================================

	sta	$C008		; use MAIN zero-page/stack/language card

	;=============================
	; want to load 6..7

	lda	#PART_MAGLEV
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

	jsr	print_next_dni

	inc	COUNT
	lda	COUNT
	cmp	#8
	bne	load_program_loop

.endif

	;=======================
	;=======================
	; Run bear
	;=======================
	;=======================

	; load from disk

	sei
	lda	#PART_BEAR	; HEADPHONES
	sta	WHICH_LOAD
	jsr	load_file

	; Run intro

	cli			; start music

	jsr	$6000




	;=======================
	;=======================
	; Run headphones
	;=======================
	;=======================
.if 0
	; load from disk

	sei
	lda     #PART_HEADPHONES		; HEADPHONES
	sta     WHICH_LOAD
	jsr     load_file

	; Run intro

	cli			; start music

	jsr	$6000


.endif
	;=======================
	;=======================
	; Run Dancing
	;=======================
	;=======================

	sei				; stop music interrupts
	jsr	mute_ay_both
	jsr	clear_ay_both		; stop from making noise

	; load dancing

	lda	#PART_DANCING		; Atrus
	sta	WHICH_LOAD
	jsr	load_file


	; restart music

	cli		; start interrupts (music)

	;======================
	; start dancing

	jsr	$2000

.if 0
	; copy ATRUS from AUX $8200 to MAIN $8000

	lda	#$82		; AUX src $8200
	ldy	#$80		; MAIN dest $8000
	ldx	#58		; 58 pages
	jsr	copy_aux_main

	; run atrus

	jsr	$8000


.endif

blah:
	jmp	blah


start_message:
	.byte 0,0,"LOADING REWIND2 PROOF OF CONCEPT",0
	.byte 0,1,"REQUIRES APPLE IIE/C/GS, 128K, MOCKINGBOARD",0
	.byte 0,3,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0
	.byte $FF

load_message:
	.byte 16,22,	"LOADING",0
