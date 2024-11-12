; Driven Demo, Startup

;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload.inc"
;.include "music.inc"

DEBUG=0

driven_start:
	;=====================
	; initializations
	;=====================

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
	; TODO: do d'ni countdown
	; 4 - 9

	sta	$C008		; use MAIN zero-page/stack/language card

	;=============================
	; want to load 4..9

	lda	#4
	sta	COUNT

load_program_loop:
	;============================
	; load next program to MAIN $6000

	; load from disk

	lda     COUNT		; which one
	sta     WHICH_LOAD
	jsr     load_file

	; copy to proper AUX location

	ldx	COUNT
	lda	aux_dest,X	; load AUX dest
	pha

	ldy	#$60		; MAIN src $6000

	lda	length_array,X	; number of pages
	tax			; in X
	pla			; restore AUX dest to A

	jsr	copy_main_aux

	inc	COUNT
	lda	COUNT
	cmp	#10
	bne	load_program_loop

.endif

.if 0
	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

	; load from disk

	lda     #PART_INTRO		; INTRO
	sta     WHICH_LOAD
	jsr     load_file

	; Run intro

	cli			; start music

	jsr	$8000
.endif



.if 1
	;=======================
	;=======================
	; Run Atrus
	;=======================
	;=======================

	sei				; stop music interrupts
	jsr	mute_ay_both
	jsr	clear_ay_both		; stop from making noise

	; load atrus

	lda	#PART_ATRUS		; Atrus
	sta	WHICH_LOAD
	jsr	load_file


	; restart music

	cli		; start interrupts (music)

	;======================
	; run atrus

	jsr	$8000
.endif


	;=======================
	;=======================
	; Run Maglev
	;=======================
	;=======================
.if 1
	sei				; stop music interrupts
	jsr	mute_ay_both
	jsr	clear_ay_both		; stop from making noise

	; load maglev

	lda	#PART_MAGLEV		; Maglev
	sta	WHICH_LOAD
	jsr	load_file


	; restart music

	cli		; start interrupts (music)

	; run maglev

	jsr	$4000
.endif


	;=======================
	;=======================
	; Load GRAPHICS
	;=======================
	;=======================

	sei				; stop music interrupts
	jsr	mute_ay_both
	jsr	clear_ay_both		; stop from making noise

	; load dni

	lda	#PART_GRAPHICS		; GRAPHICS
	sta	WHICH_LOAD
	jsr	load_file


	; restart music

	cli		; start interrupts (music)

	; Run GRAPHICS

	jsr	$6000


.if 0
	;==========================
	;==========================
	; Run 4-9, copy from AUX
	;==========================
	;==========================

	;=======================
	; run GORILLA (#4)
	;=======================
	; copy GORILLA from AUX $7000 to MAIN $8000

	lda	#$70		; AUX src $7000
	ldy	#$80		; MAIN dest $8000
	ldx	#32		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug gorilla music
	lda     #25
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	; run gorilla

	jsr	$8000

	;=======================
	; run LEAVES (#5)
	;=======================
	; copy LEAVES from AUX $5000 to MAIN $8000

	lda	#$50		; AUX src $5000
	ldy	#$80		; MAIN dest $8000
	ldx	#32		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug leaves music
	lda     #30
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	; run leaves

	jsr	$8000


	;=======================
	; run LENS/ROTOZOOM (#6)
	;=======================
	; copy LENS from AUX $4000 to MAIN $6000

	lda	#$40		; AUX src $4000
	ldy	#$60		; MAIN dest $6000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug lens music
	lda     #34
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	; run lens

	jsr	$6000


	;=======================
	; run PLASMA (#7)
	;=======================
	; copy PLASMA from AUX $3000 to MAIN $8000

	lda	#$30		; AUX src $3000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug plasma music
	lda     #47
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	; run plasma

	jsr	$8000

	;=======================
	; run PLASMACUBE (#8)
	;=======================
	; copy PLASMACUBE from AUX $2000 to MAIN $8000

	lda	#$20		; AUX src $2000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug plasmacube music
	lda     #52
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	; run plasmacube

	jsr	$8000

	;=======================
	; run DOTS (#9)
	;=======================
	; copy DOTS from AUX $1000 to MAIN $8000

	lda	#$10		; AUX src $1000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug dots music
	lda     #60
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif
	; run dots

	jsr	$8000


	;=======================
	;=======================
	; Load 10-12 to RAM
	;=======================
	;=======================

	; disable music

	sei

	jsr	mute_ay_both		; stop from making noise

	;=============================
	; want to load 10..12

	lda	#10
	sta	COUNT

load_program_loop2:
	;============================
	; load next program to MAIN $6000

	; load from disk

	lda     COUNT		; which one
	sta     WHICH_LOAD
	jsr     load_file

	; copy to proper AUX location

	ldx	COUNT
	lda	aux_dest,X	; load AUX dest
	pha

	ldy	#$60		; MAIN src $6000

	lda	length_array,X	; number of pages
	tax			; in X
	pla			; restore AUX dest to A

	jsr	copy_main_aux

	inc	COUNT
	lda	COUNT
	cmp	#13
	bne	load_program_loop2


	;==========================
	;==========================
	; Run 10-12
	;==========================
	;==========================

	; restart music

	jsr	unmute_ay_both		; restart
	cli

	;=======================
	; run SPHERES
	;============================================
	; copy SPHERES from AUX $8000 to MAIN $8000

	lda	#$80		; AUX src $8000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug spheres music
	lda     #68
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	jsr	$8000

	;=======================
	; run OCEAN
	;=======================
	; copy OCEAN from AUX $2000 to MAIN $6000

	lda	#$20		; AUX src $1000
	ldy	#$60		; MAIN dest $6000
	ldx	#96		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; debug ocean music
	lda     #72
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern
.endif

	jsr	$6000

	;=======================
	; run POLAR
	;=======================
	; copy POLAR from AUX $1000 to MAIN $8000

	lda	#$10		; AUX src $1000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

.if DEBUG=1
	; setup music ocean=pattern24 (3:07) pattern#47
;	lda	#76
;	sta	current_pattern_smc+1
;	jsr	pt3_set_pattern
.endif

	; run polar

	jsr	$8000

.endif



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


forever:
	jmp	forever


	.include "wait_keypress.s"
	.include "zx02_optim.s"
	.include "gs_interrupt.s"
	.include "pt3_lib_mockingboard_patch.s"
	.include "hardware_detect.s"


start_message:
	.byte 0,0,"LOADING DRIVEN DEMO",0
	.byte 0,1,"REQUIRES APPLE IIE, 128K, MOCKINGBOARD",0
	.byte 0,3,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0
	.byte $FF
