; Monster Splash

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

	bit	KEYRESET
	jsr	wait_until_keypress

good_to_go:

	; print loading message (flashing)

	ldx	#0
print_load_message:
	lda	load_message,X
	beq	done_load_message
	sta	$6A8+16,X
	inx
	jmp	print_load_message
done_load_message:

;	jsr	wait_until_keypress

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
	; Pre-Load some programs into AUX MEM
	;====================================
	;====================================

	sta	$C008		; use MAIN zero-page/stack/language card

	;==============================
	; load four-color to AUX:$1000

	; note we can't load to AUX until after MUSIC (with copy aux routines)

	lda	#PART_FOURCOLOR		; Multi-color monster
	sta	WHICH_LOAD
	jsr	load_from_disk		; load and copy


	;========================
	; load monsters

	lda	#PART_MONSTERS
	sta	WHICH_LOAD
	jsr	load_from_disk


	;=========================
	; load monsters2

	; first load to MAIN:6000
	; then copy to AUX:D000

	lda	#PART_MONSTERS2
	sta	WHICH_LOAD
	jsr	load_from_disk

        ; switch to AUXZP, ALTZP now $d000/ZP in aux

	sta	AUXZP

	ldy	#0
altzp_loop:

altzp_smc1:
	lda	$6000,Y
altzp_smc2:
	sta	$D000,Y
	iny
	bne	altzp_loop

	inc	altzp_smc1+2
	inc	altzp_smc2+2
	lda	altzp_smc1+2
	cmp	#$90
	bne	altzp_loop

	; restore MAINZP

	sta	MAINZP




	;========================
	; load woz

	lda	#PART_WOZ
	sta	WHICH_LOAD
	jsr	load_from_disk

	;==================
	; load extra

	lda	#PART_EXTRA
	sta	WHICH_LOAD
	jsr	load_from_disk

	;=============================
	; want to load INTRO last


	lda	#PART_INTRO
	sta	WHICH_LOAD
	jsr	load_from_disk

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



	;=======================
	;=======================
	; Run intro
	;=======================
	;=======================


	; run intro

	cli			; start music

;	jsr	test_intterupt_banking

	jsr	$6000


	;=======================
	;=======================
	; Run monsters
	;=======================
	;=======================

	; copy monsters from AUX $6000 to MAIN $6000

	lda	#$60		; AUX src $6000
	ldy	#$60		; MAIN dest $6000
	ldx	#64		; 16k*4 = 64 pages
	jsr	copy_aux_main

	; run monsters

	jsr	$6000

	;=======================
	;=======================
	; Run monsters2
	;=======================
	;=======================

	; load monsters2

	; copy from ALTZP $D000 to MAIN $6000

        ; switch to AUXZP, ALTZP now $d000/ZP in aux



	; takes
	;	6+((14*256)+23)*48)+4 = 173146 cycles = 100ms
	;		50 Hz = 20ms?  lose 5 cycles?
	;		maybe each time through briefly turn irq off/on?



	ldy	#0						; 2
altzp2_loop:

	sei				; for now, w/o interrupts
	sta	AUXZP						; 4

altzp2_smc1:
	lda	$D000,Y						; 4+
altzp2_smc2:
	sta	$6000,Y						; 5
	iny							; 2
	bne	altzp2_loop					; 2/3

	; restore MAINZP

	sta	MAINZP						; 4
	cli			; restart music

	inc	altzp2_smc1+2					; 6
	inc	altzp2_smc2+2					; 6
	lda	altzp2_smc2+2					; 6
	cmp	#$90						; 2
	bne	altzp2_loop					; 2/3


	; run monsters2

	jsr	$6000



	;=======================
	;=======================
	; Run Woz
	;=======================
	;=======================

	; load woz

	; copy WOZ from AUX $A000 to MAIN $A000

	lda	#$A0		; AUX src $A000
	ldy	#$A0		; MAIN dest $A000
	ldx	#32		; 8k*4 = 32 pages
	jsr	copy_aux_main

	; decompress to $6000

	lda	#$40			; load to $6000
	sta	DRAW_PAGE

	lda	#<$A000
	sta	zx_src_l+1
	lda	#>$A000
	sta	zx_src_h+1

        jsr     zx02_full_decomp_main


	;======================
	; start woz

	jsr	$6000


	;=======================
	;=======================
	; Run fourcolor
	;=======================
	;=======================

	; Copy into place

	lda	#$10		; src:  AUX:$1000
	ldy	#$60		; dest: MAIN:$6000
	ldx	#$10		; len:  4k

	jsr	copy_aux_main

	jsr	$6000


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

	; Run credits


	jsr	$6000

forever:
	jmp	forever



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
	.byte 4,0,"LOADING MonsterSplash DEMO / dSr",0
	.byte 12,2,"DEMOSPLASH  2025",0
	.byte 1,4,"REQUIRES APPLE IIE, 128K, MOCKINGBOARD",0
	.byte 7,6,"SYSTEM DETECTED: APPLE II"
message_type_offset:
	.byte "   ",0

	.byte 3,20,">>Wer mit Ungeheuern kaempft, mag",0
	.byte 3,21,"  zusehn dass er nicht dabei zum",0
	.byte 3,22,"  Ungeheuer wird.<<  -- Nietzsche",0
;	.byte 3,23,"Und wenn du lange in einen Abgrund blickst,
;	.byte 3,24,"blickt der Abgrund auch in dich hinein."



	.byte $FF

load_message:
;	.byte 16,12,	$6A8
	.byte "LOADING",0



.if 0

test_interrupt_banking:

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

