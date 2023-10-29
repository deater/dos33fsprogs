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


	;====================================
	;====================================
	; Pre-Load some programs into AUX MEM
	;====================================
	;====================================
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


	;=======================
	;=======================
	; Load intro
	;=======================
	;=======================

	; TODO

	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

	; TODO


	;=======================
	;=======================
	; Load music / chess
	;=======================
	;=======================

	; TODO

	;=======================
	;=======================
	; Run Chess
	;=======================
	;=======================

	; TODO

	;==========================
	;==========================
	; Run 4-9, copy from AUX
	;==========================
	;==========================


	;=======================
	; run DOTS (#9)
	;=======================
	; copy DOTS from AUX $1000 to MAIN $8000

	lda	#$10		; AUX src $1000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main
	jsr	$8000


	;=======================
	;=======================
	; Load 10-12 to RAM
	;=======================
	;=======================

	; TODO

	;==========================
	;==========================
	; Run 10-12
	;==========================
	;==========================

	;=======================
	; run SPHERES
	;============================================

	; TODO


	;=======================
	; run POLAR
	;============================================

	; TODO

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
