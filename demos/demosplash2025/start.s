; Unnamed Demo

; for Demosplash 2025

; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "qload.inc"
;.include "music.inc"

DEBUG=0

ds25_start:
	;=====================
	; initializations
	;=====================

	bit	PAGE1
	bit	KEYRESET		; clear keypress strobe

	jsr	hardware_detect		; detect hardware

	lda	APPLEII_MODEL
	sta	message_type_offset	; update detected hardware message

	;=====================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=====================
	; clear text screen

	lda	#$A0
	jsr	clear_top_a
	jsr	clear_bottom

	;======================
	; print start message

	jsr	set_normal

	lda	#<start_message
	sta	OUTL
	lda	#>start_message
	sta	OUTH

	jsr	move_and_print_list

	;===============================
	; pause at warning if not e/c/gs

	lda	APPLEII_MODEL
	cmp	#'e'
	beq	good_to_go
	cmp	#'g'
	beq	good_to_go
	cmp	#'c'
	beq	good_to_go

	jsr	wait_until_keypress

good_to_go:

	;=========================================
	;=========================================
	; start loading the demo parts
	;=========================================
	;=========================================

	;==================================
	; load CREDITS into the language card
	;       into $D000 bank 2
	;==================================

	; read/write RAM, use $d000 bank2
	lda	LCBANK2			; need to read twice
	lda	LCBANK2

	lda	#PART_CREDITS		; load MUSIC from disk
	sta	WHICH_LOAD

	jsr	load_file

	;==================================
	; load music into the language card
	;       into $D000 bank 1
	;==================================

	; read/write RAM, use $d000 bank1
	lda	LCBANK1			; need to read twice
	lda	LCBANK1

	lda	#PART_MUSIC		; load MUSIC from disk
	sta	WHICH_LOAD

	jsr	load_file

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; patch mockingboardv

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

	;======================
	; make hires tables
	;======================
	; note: need to do this after language card enabled
	; note! Currently at $FD00/$FE00

	jsr	hgr_make_tables



	;====================================
	;====================================
	; do falling letters effect
	;====================================
	;====================================

	jsr	font_drop


	;====================================
	;====================================
	; Clear DHGR PAGE1
	;	MAIN:$2000 and AUX:$2000
	;====================================
	;====================================

	lda	#0
	jsr	hgr_page1_clearscreen
	sta	WRAUX			; writes to AUX memory
	jsr	hgr_page1_clearscreen
	sta	WRMAIN			; writes back to MAIN memory

	;====================================
	;====================================
	; Pre-Load some programs into AUX MEM
	;====================================
	;====================================

	sta	$C008		; use MAIN zero-page/stack/language card

	;=============================
	; want to load INTRO last

	; TODO: wrangle the files


;	lda	#PART_MONSTERS
;	sta	WHICH_LOAD
;	jsr	load_from_disk


	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================


	; load intro

	sei				; disable interrupts

	; load extra

	lda	#PART_EXTRA
	sta	WHICH_LOAD
	jsr	load_from_disk

	lda	#PART_INTRO
	sta	WHICH_LOAD
	jsr	load_from_disk



	; run intro

	cli			; start music

.if 0
;	2C 8B C0             bit     LCBANK1	; read write ram RR $C083 (bank2) $C08B (bank1)
;	2C 8B C0             bit     LCBANK1
;	8D 05 C0             sta     WRITEAUXMEM
;	8D 03 C0             sta     READAUXMEM      ; after this, off in la-la land
;	4C 0C 00

	lda	#$2C
	sta	$00
	lda	#$8B
	sta	$01
	lda	#$C0
	sta	$02

	lda	#$2C
	sta	$03
	lda	#$8B
	sta	$04
	lda	#$C0
	sta	$05

	lda	#$8D
	sta	$06
	lda	#$05
	sta	$07
	lda	#$C0
	sta	$08

	lda	#$8D
	sta	$09
	lda	#$03
	sta	$0A
	lda	#$C0
	sta	$0B

	lda	#$4C
	sta	$0C
	lda	#$0C
	sta	$0D
	lda	#$00
	sta	$0E

	jmp	$0000

.endif

	jsr	$6000


	;=======================
	;=======================
	; Run monsters
	;=======================
	;=======================

	; load monsters

	sei				; disable interrupts
	lda	#PART_MONSTERS
	sta	WHICH_LOAD
	jsr	load_from_disk
	cli				; re-enable music

.if 0
	; copy monsters from AUX $6000 to MAIN $6000

	lda	#$60		; AUX src $6000
	ldy	#$60		; MAIN dest $6000
	ldx	#64		; 16k*4 = 32 pages
	jsr	copy_aux_main
.endif

	; run monsters

	jsr	$6000


	;=======================
	;=======================
	; Run Woz
	;=======================
	;=======================

.if 0
	; load monsters

	sei				; disable interrupts
	lda	#PART_MONSTERS
	sta	WHICH_LOAD
	jsr	load_from_disk
	cli				; re-enable music


	; copy DANCING from AUX $8000 to MAIN $2000

;	lda	#$80		; AUX src $8000
;	ldy	#$20		; MAIN dest $2000
;	ldx	#32		; 8k*4 = 32 pages
;	jsr	copy_aux_main

	; Also copy from MAIN $2000 to AUX $2000.  Inefficient :(

;	lda	#$20		; AUX dest $2000
;	ldy	#$20		; MAIN src $2000
;	ldx	#32		; 8k*4
;	jsr	copy_main_aux

;	sei				; stop music interrupts
;	jsr	mute_ay_both
;	jsr	clear_ay_both		; stop from making noise

	; load woz

;	lda	#PART_DANCING		; Dancing
;	sta	WHICH_LOAD
;	jsr	load_file


	; restart music

;	cli		; start interrupts (music)

	;======================
	; start woz

;	jsr	$2000



.endif

	;=======================
	;=======================
	; Run fourcolor
	;=======================
	;=======================
.if 0
	; load from disk

	sei
	lda	#PART_FOURCOLOR	; Multi-color monster
	sta	WHICH_LOAD
	jsr	load_file

	; Run Four Color

	cli			; start music

	jsr	$6000

.endif
	;=======================
	;=======================
	; Run Credits
	;=======================
	;=======================

	; copy from MAIN Language Card BANK2

	; we can't zx02 it directly because that lives in BANK1 of the LC

	lda	LCBANK2
	lda	LCBANK2

	; copy CREDITS.zx02 from MAIN $D000 to MAIN $A000

	lda	#$D0		; MAIN src $D000
	ldy	#$A0		; MAIN dest $A000
	ldx	#16		; 4k*4 = 16 pages
	jsr	copy_main_main


	lda	LCBANK1			; restore BANK1
	lda	LCBANK1

	; decompress

	lda	#$40			; load to $6000
	sta	DRAW_PAGE

	lda	#<$A000
	sta	zx_src_l+1
	lda	#>$A000
	sta	zx_src_h+1

        jsr     zx02_full_decomp_main

;	sei
;	lda	#PART_CREDITS
;	sta	WHICH_LOAD
;	jsr	load_file

	; Run credits

;	cli			; start music

	jsr	$6000

blah:
	jmp	blah



	;============================
	; load from disk
	;============================
	; WHICH_LOAD is which to load
	; copy to AUX unless AUX_LOAD is 0

load_from_disk:

	jsr     load_file

	; copy to proper AUX location

	ldx	WHICH_LOAD
	lda	aux_dest,X		; load AUX dest
	beq	skip_aux_copy

	pha

	ldy	load_address_array,X	; where we loaded in MAIN

	lda	length_array,X	; number of pages
	tax			; in X
	pla			; restore AUX dest to A

	jsr	copy_main_aux	; tail call?

skip_aux_copy:

	rts

.include "main_memcopy.s"


start_message:	  ;01234567890123456789012345678901234567890
	.byte 0,0,"LOADING MonsterSplash DEMO / dSr",0
	.byte 0,1,"DEMOSPLASH 2025",0
	.byte 0,2,"REQUIRES APPLE IIE, 128K, MOCKINGBOARD",0
	.byte 0,3,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0
;	.byte 0,10,"MUSIC BY mAZE",0
;	.byte 0,12,"GRAPHICS BY GRIMNIR",0
;	.byte 0,13,"DISK BY QKUMBA",0
;	.byte 0,14,"WIPES BY 4AM/QKUMBA",0
;	.byte 0,16,".",0
;	.byte 0,17,"ZX02 DECOMPRESSION BY DMSC",0
;	.byte 0,18,"EVERYTHING ELSE BY DEATER",0
;	.byte 10,20,".",0
;	.byte 10,21,".",0
	.byte $FF

;load_message:
;	.byte 16,22,	"LOADING",0


;.include "font/font_drop.s"
