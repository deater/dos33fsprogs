; startup for disk2

;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload2.inc"
;.include "music.inc"

second_start:
	;=====================
	; initializations
	;=====================

	jsr	hardware_detect

	;===================
	; restart?
	;===================
restart:
	lda	#0
	sta	DRAW_PAGE

	;==================================
	; load sound into the language card
	;       into $D000 set 1
	;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda	#0
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

skip_all_checks:


	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
;	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	;=======================
	; load, copy to AUXMEM
	;=======================

	sta	$C008		; use MAIN zero-page/stack/language card

	;====================
	; load nuts to $6000

	lda	#3		; NUTS
	sta	WHICH_LOAD
	jsr	load_file

	;======================
	; copy NUTS to AUX $4000

	lda	#$20		; AUX dest $20
	ldy	#$40		; MAIN src
	ldx	#32		; 64 pages
	jsr	copy_main_aux

	;====================
	; load CREDITS to $6000

	lda	#2		; CREDITS
	sta	WHICH_LOAD
	jsr	load_file

	;===========================
	; copy CREDITS to AUX $2000

	lda	#$20		; AUX dest $20
	ldy	#$60		; MAIN src
	ldx	#64		; 64 pages
	jsr	copy_main_aux


;	lda	#1		; THREED
;	sta	WHICH_LOAD
;	jsr	load_file




	;=======================
	; run THREED
	;=======================

	cli			; start music

	;=======================
	; run NUTS
	;=======================

	;=======================
	; run CREDITS
	;=======================

	;============================================
	; copy CREDITS from AUX $2000 to MAIN $6000

	lda	#$20		; AUX src $2000
	ldy	#$60		; MAIN dest $6000
	ldx	#64		; 64 pages
	jsr	copy_aux_main

	; run credits

	jsr	$6000




	; TODO: RR?

forever:
	jmp	forever


.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"
