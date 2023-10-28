; Apple ][ Second Reality, Startup for Disk1

;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload.inc"
;.include "music.inc"

second_start:
	;=====================
	; initializations
	;=====================

	jsr	hardware_detect		; FIXME: remove when hook up part00

	jsr	hgr_make_tables


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


	;============================
	; Load programs into AUXMEM
	;============================

	sta	$C008		; use MAIN zero-page/stack/language card


	;=============================
	; want to load 2..MAX
	;	0 = MUSIC, 1 = INTRO

	lda	#2
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
	cmp	#7
	bne	load_program_loop

.if 0

	;====================
	; load POLAR to $6000

	lda     #4		; POLAR
	sta     WHICH_LOAD
	jsr     load_file

	;======================
	; copy POLAR to AUX $1000

	lda	#$10		; AUX dest $1000
	ldy	#$60		; MAIN src $6000
	ldx	#16		; 16 pages
	jsr	copy_main_aux


	;====================
	; load SPHERES to $6000

	lda     #5		; SPHERES
	sta     WHICH_LOAD
	jsr     load_file

	;======================
	; copy SPHERES to AUX $2000

	lda	#$20		; AUX dest $1000
	ldy	#$60		; MAIN src $6000
	ldx	#16		; 16 pages
	jsr	copy_main_aux

.endif


;	cli	; start music

	;=======================
	; run DOTS
	;============================================
	; copy DOTS from AUX $3000 to MAIN $8000

	lda	#$30		; AUX src $1000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main
	jsr	$8000

	;=======================
	; run SPHERES
	;============================================
	; copy SPHERES from AUX $2000 to MAIN $8000

	lda	#$20		; AUX src $1000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main
	jsr	$8000


	;=======================
	; run POLAR
	;============================================
	; copy POLAR from AUX $1000 to MAIN $8000

	lda	#$10            ; AUX src $1000
	ldy	#$80            ; MAIN dest $8000
	ldx	#16             ; 16 pages
	jsr	copy_aux_main

	; setup music ocean=pattern24 (3:07) pattern#43
;	lda	#43
;	sta	current_pattern_smc+1
;	jsr	pt3_set_pattern
        ; run polar
	jsr     $8000

	;=============================
	; ask for side2
	;=============================

	sei		; disable music

	bit	PAGE1
	bit	TEXTGR
	bit	KEYRESET	; clear keyboard

	; clear text screen

	jsr	clear_all

	; print non-inverse

	jsr	set_normal

	; print messages
	lda	#<disk_change_string
	sta	OUTL
	lda	#>disk_change_string
	sta	OUTH

	; print the text

	jsr	move_and_print

	jsr	wait_until_keypress

	;==================
	; reboot
	;==================

	; swap back in ROM

	lda	$C08A	; read rom, no write

	lda	WHICH_SLOT
	lsr
	lsr
	lsr
	lsr
	ora	#$C0
	sta	reboot_smc+2

reboot_smc:
	jmp	$C600

forever:
	jmp	forever

.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"

.include "title.s"

disk_change_string:
;             0123456789012345678901234567890123456789
.byte   5,22,"INSERT DISK 2 AND PRESS ANY KEY",0

.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"
