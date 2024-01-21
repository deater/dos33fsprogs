; Trogdor

; by deater (Vince Weaver) <vince@deater.net>



trogdor_start:

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

	;============================
	;============================
	; load title image from disk
	;============================
	;============================

	; load from disk

        bit     SET_GR
        bit     HIRES
        bit     TEXTGR
        bit     PAGE2

	lda     #2		; TITLE
	sta     WHICH_LOAD
	jsr     load_file

	bit	PAGE1

	; decompress

	lda     #<$4000
        sta     zx_src_l+1
        lda     #>$4000
        sta     zx_src_h+1
        lda     #$20
        jsr     zx02_full_decomp

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

	; print the text

	jsr	move_and_print

	; print title messages

	lda	#<title_string
	sta	OUTL
	lda	#>title_string
	sta	OUTH

	; print the text

	jsr	move_and_print
	jsr	move_and_print

	; wait a bit, then change to credits

	lda	#50
	jsr	wait_a_bit

	lda	#<bottom_string1
	sta	OUTL
	lda	#>bottom_string1
	sta	OUTH

	; print the text

	jsr	move_and_print

	lda	#50
	jsr	wait_a_bit


	jsr	move_and_print

	jsr	wait_until_keypress

	;=======================
	;=======================
	; Load FLAMES
	;=======================
	;=======================
load_flames:

	; load from disk

	lda     #3		; FLAMES
	sta     WHICH_LOAD
	jsr     load_file


	;=======================
	;=======================
	; Load TROGDOR
	;=======================
	;=======================
load_trogdor:

	; load from disk

	lda     #1		; TROGDOR
	sta     WHICH_LOAD
	jsr     load_file

	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

;	cli			; start music

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



title_string:
.byte	1,20,"NEW FROM VIDELECTRIX: A POSSIBLY LEGAL",0
.byte	7,21,"PROGRAM FOR YOUR APPLE II!",0


bottom_string1:
.byte	3,23," CODE BY DEATER, MUSIC BY TOM_FJM",0
bottom_string2:
.byte	3,23,"    = PRESS ANY KEY TO START =    ",0

;             0123456789012345678901234567890123456789
mockingboard_string:
.byte   6,23,"MOCKINGBOARD DETECTED SLOT 4",0

no_mockingboard_string:
.byte   3,23,"NO MOCKINGBOARD, CONTINUING ANYWAY",0

.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"
