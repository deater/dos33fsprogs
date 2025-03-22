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
	; Run headphones
	;=======================
	;=======================

	; load from disk

	lda     #PART_HEADPHONES		; HEADPHONES
	sta     WHICH_LOAD
	jsr     load_file

	; Run intro

	cli			; start music

	jsr	$6000

blah:
	jmp	blah



.if 0
	;=======================
	;=======================
	; Run Atrus
	;=======================
	;=======================

;	sei				; stop music interrupts
;	jsr	mute_ay_both
;	jsr	clear_ay_both		; stop from making noise

	; load atrus

;	lda	#PART_ATRUS		; Atrus
;	sta	WHICH_LOAD
;	jsr	load_file


	; restart music

;	cli		; start interrupts (music)

	;======================
	; run atrus

;	jsr	$8000


	; copy ATRUS from AUX $8200 to MAIN $8000

	lda	#$82		; AUX src $8200
	ldy	#$80		; MAIN dest $8000
	ldx	#58		; 58 pages
	jsr	copy_aux_main

	; run atrus

	jsr	$8000


.endif


.if 0
	;=======================
	;=======================
	; Run Maglev
	;=======================
	;=======================
	; copy MAGLEV from AUX $200 to MAIN $4000

	lda	#$02		; AUX src $1000
	ldy	#$40		; MAIN dest $4000
	ldx	#127		; 127 pages
	jsr	copy_aux_main

	; run maglev

	jsr	$4000

.endif


.if 0
	;=======================
	;=======================
	; Load GRAPHICS
	;=======================
	;=======================

	sei				; stop music interrupts
	jsr	mute_ay_both
;	jsr	clear_ay_both		; stop from making noise

	; load GRAPHICS

	lda	#PART_GRAPHICS		; GRAPHICS
	sta	WHICH_LOAD
	jsr	load_file


	; restart music

	jsr	unmute_ay_both
	cli		; start interrupts (music)

	; Run GRAPHICS

	jsr	$6000


	;=======================
	;=======================
	; Load Credits
	;=======================
	;=======================

.if DEBUG=1
	; skip to credits music
	lda     #72		; FIXME: not right
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	sei				; stop music interrupts
	jsr	mute_ay_both
	jsr	clear_ay_both		; stop from making noise

	; load credits

	lda	#PART_CREDITS			; CREDITS
	sta	WHICH_LOAD
	jsr	load_file


	; restart music

	cli		; start interrupts (music)

	; Run Credits


	jsr	$8000


	; in theory never get here...

.endif

forever:
	jmp	forever


start_message:
	.byte 0,0,"LOADING REWIND2 PROOF OF CONCEPT",0
	.byte 0,1,"REQUIRES APPLE IIE, 128K, MOCKINGBOARD",0
	.byte 0,3,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0
	.byte $FF

load_message:
	.byte 16,22,	"LOADING",0
