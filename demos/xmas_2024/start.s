; XMAS 2024

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
	; Print message
	;=======================
	;=======================

	; print non-inverse

	jsr	set_normal

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	print_no_mock

print_mock:
	lda	MB_ADDR_H
	and	#$7
	clc
	adc	#$B0
	sta	mockingboard_string+29

	lda	#<mockingboard_string
	sta	OUTL
	lda	#>mockingboard_string
	jmp	done_set_message

print_no_mock:
	lda	#<no_mockingboard_string
	sta	OUTL
	lda	#>no_mockingboard_string

done_set_message:
	sta	OUTH

	; print the mockingboard text

	jsr	move_and_print

	;==============================
	;==============================
	; print title text

	lda	#<title_string
	sta	OUTL
	lda	#>title_string
	sta	OUTH

	jsr	move_and_print_list


	;=======================
	;=======================
	; Load xmas
	;=======================
	;=======================
load_xmas:

	; load from disk

	lda	#2			; load WIPE_DATA_STAR from disk
	sta	WHICH_LOAD		; to $8100

	jsr	load_file


	; load from disk

	lda     #1		; XMAS
	sta     WHICH_LOAD
	jsr     load_file

	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

;	cli			; start music

	jsr	$6000




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


;             0123456789012345678901234567890123456789
mockingboard_string:
.byte   6,22,"MOCKINGBOARD DETECTED SLOT 4",0

no_mockingboard_string:
.byte   3,22,"NO MOCKINGBOARD, CONTINUING ANYWAY",0


;             0123456789012345678901234567890123456789
title_string:
.byte 0,4, "XMAS 2024",0
.byte 0,6, "BY THE GUINEA PIG GANG",0
.byte 0,8, "CODE:  VINCE 'DEATER' WEAVER",0
.byte 0,9, "ART:   GUINEAGIRL2424",0
.byte 0,10,"FX:    4AM/QKUMBA",0
.byte 0,11,"QLOAD: QKUMBA",0
.byte 0,12,"MUSIC: ARRANGED BY TOYMUSIC",0
.byte 0,13,"       (CASIO-8 DEMO SONG)",0
.byte $FF

.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"
