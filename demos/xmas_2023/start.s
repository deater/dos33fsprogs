; XMAS 2023

;
; by deater (Vince Weaver) <vince@deater.net>



xmas_start:

	;=====================
	; initializations
	;=====================

	jsr	hardware_detect

	jsr	hgr_make_tables


	;===================
	; restart?
	;===================
restart:

	lda	#0
	sta	DRAW_PAGE


	;==================================
	; load music into the language card
	;       into $D000 set 1
	;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda	#0			; load MUSIC from disk
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


	;=======================
	;=======================
	; Load xmas
	;=======================
	;=======================
load_xmas:

	; load from disk

	lda     #1		; XMAS
	sta     WHICH_LOAD
	jsr     load_file

	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

	cli			; start music

	jsr	$8000




;	bit	PAGE1			; be sure we're on PAGE1

	; clear text screen
;	lda	#$A0
;	sta	clear_all_color+1
;	jsr	clear_all

	; switch to text/gr
;	bit	TEXTGR

	; print non-inverse

;	jsr	set_normal

	; print messages
;	lda	#<disk_change_string
;	sta	OUTL
;	lda	#>disk_change_string
;	sta	OUTH

	; print the text

;	jsr	move_and_print

;	bit	KEYRESET			; just to be safe
;	jsr	wait_until_keypress


forever:
	jmp	forever


	.include	"wait_keypress.s"
	.include	"zx02_optim.s"

	.include	"gs_interrupt.s"

;.include "title.s"

disk_change_string:
;             0123456789012345678901234567890123456789
;.byte   5,22,"INSERT DISK 2 AND PRESS ANY KEY",0

.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"
