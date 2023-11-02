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

	lda	#0			; load MUSIC_INTRO from disk
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

	; load from disk

	lda     #2		; INTRO
	sta     WHICH_LOAD
	jsr     load_file

	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================

	cli

	jsr	$6000


	;=======================
	;=======================
	; Load music / chess
	;=======================
	;=======================

	sei				; stop music interrupts

	jsr	clear_ay_both		; stop from making noise

	; load music

	lda	#1		; MUSIC_MAIN
	sta	WHICH_LOAD
	jsr	load_file

	; load from disk

	lda     #3		; CHESS
	sta     WHICH_LOAD
	jsr     load_file


	; restart music


	;============================
	; Re-Init the Mockingboard
	;============================

	; NOTE: I don't know how much of this is actually necessary
	;	wasted a lot of time debugging, leaving it as-is
	;	as it seems to be working

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	;========================
	; patch mockingboard

        jsr     mockingboard_patch      ; patch to work in slots other than 4?
	jsr	mockingboard_init
	;=======================
	; Set up 50Hz interrupt
	;========================


	jsr	mockingboard_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song

	cli		; start interrupts

	;=======================
	;=======================
	; Run Chess
	;=======================
	;=======================

	jsr	$8000

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

	; debug gorilla music
	lda     #25
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

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

	; debug leaves music
	lda     #30
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

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

	; debug lens music
	lda     #34
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

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

	; debug plasma music
	lda     #47
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

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


	; debug plasmacube music
	lda     #52
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

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


	; debug dots music
	lda     #60
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

	; run dots

	jsr	$8000


	;=======================
	;=======================
	; Load 10-12 to RAM
	;=======================
	;=======================

	; disable music

	sei

	jsr	clear_ay_both		; stop from making noise

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

	cli

	;=======================
	; run SPHERES
	;============================================
	; copy SPHERES from AUX $8000 to MAIN $8000

	lda	#$80		; AUX src $8000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main


	; debug spheres music
	lda     #68
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern

	jsr	$8000

	;=======================
	; run OCEAN
	;=======================
	; copy OCEAN from AUX $2000 to MAIN $6000

	lda	#$20		; AUX src $1000
	ldy	#$60		; MAIN dest $6000
	ldx	#96		; 16 pages
	jsr	copy_aux_main

	; debug ocean music
	lda     #72
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern


	jsr	$6000

	;=======================
	; run POLAR
	;=======================
	; copy POLAR from AUX $1000 to MAIN $8000

	lda	#$10		; AUX src $1000
	ldy	#$80		; MAIN dest $8000
	ldx	#16		; 16 pages
	jsr	copy_aux_main

	; setup music ocean=pattern24 (3:07) pattern#47
;	lda	#76
;	sta	current_pattern_smc+1
;	jsr	pt3_set_pattern

	; run polar

	jsr	$8000

	;=============================
	; ask for side2
	;=============================

	sei				; disable music
	jsr	clear_ay_both		; stop from making noise

	bit	PAGE1			; be sure we're on PAGE1

	; clear text screen
	lda	#$A0
	sta	clear_all_color+1
	jsr	clear_all

	; switch to text/gr
	bit	TEXTGR

	; print non-inverse

	jsr	set_normal

	; print messages
	lda	#<disk_change_string
	sta	OUTL
	lda	#>disk_change_string
	sta	OUTH

	; print the text

	jsr	move_and_print

	bit	KEYRESET			; just to be safe
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

;.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"

;.include "title.s"

disk_change_string:
;             0123456789012345678901234567890123456789
.byte   5,22,"INSERT DISK 2 AND PRESS ANY KEY",0

.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"
