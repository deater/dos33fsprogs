; Fake BIOS screen
;  for another project

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

bios_test:
	;===================
	; set graphics mode
	;===================

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#0
	sta	FAKE_KEY_COUNT

	;=======================
	; Hardware Detect Model
	;=======================
	; Yes Michaelangel007 I will eventually update linux_logo 6502

	; we did this earlier?
;	jsr	detect_appleii_model

	lda	APPLEII_MODEL
	cmp	#'g'
	bne	not_iigs

is_a_iigs:
	; set background color to black instead of blue
	lda     NEWVIDEO
	and	#%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta	NEWVIDEO
	lda	#$F0
	sta	TBCOLOR		; white text on black background
	lda	#$00
	sta	CLOCKCTL	; black border
	sta	CLOCKCTL	; set twice for VidHD

	lda	#'s'
	sta	model_patch_1+9

	lda	#'C'
	sta	cpu_patch_1+14
	sta	cpu_patch_2+2
	lda	#'8'
	sta	cpu_patch_1+15
	sta	cpu_patch_2+3
	lda	#'1'
	sta	cpu_patch_1+16
	sta	cpu_patch_2+4
	lda	#'6'
	sta	cpu_patch_1+17
	sta	cpu_patch_2+5
not_iigs:

	; update text printed

	lda	APPLEII_MODEL
	cmp	#'3'
	bne	no_not_a_iii

	lda	#'/'			; 3 slashes
	sta	model_patch_1+6
	sta	model_patch_1+7
	sta	model_patch_1+8
	bne	hardware_detect_ram	; bra

no_not_a_iii:

	lda	APPLEII_MODEL
	sta	model_patch_1+8	; patch to ' ' '+' 'e' 'c' or 'g'

	;=======================
	; Hardware Detect RAM
	;=======================
hardware_detect_ram:

	;=================================================
	; assume 48k for base model (not necessarily true)

	lda	#48		; FIXME: detect less on earlier models?
	sta	TOTAL_RAM

	;================================================
	; detect language card 16k
	; could cheat and just make it 64k in this case
	; can you have a language card on a 4k system?

	jsr	detect_language_card
	bcs	ram_no_lc
ram_yes_lc:
	; carry clear here
	lda	#16
	adc	TOTAL_RAM
	sta	TOTAL_RAM

	; update text string
	lda	#'1'
	sta	lang_card_patch+34
	lda	#'6'
	sta	lang_card_patch+35

ram_no_lc:

	;================================================
	; detect aux memory
	;	iigs we're lazy and say 64k
	;	iic always 64k AUX
	;	iie we have to probe
	;		in theory can have 0k, 1k or 64k of it

	jsr	detect_aux_ram

	cmp	#0
	beq	ram_no_aux

	cmp	#1
	beq	ram_1k_aux
ram_64k_aux:
	clc
	lda	TOTAL_RAM
	adc	#64
	sta	TOTAL_RAM

	lda	#'6'
	sta	aux_mem_patch+34
	lda	#'4'
	sta	aux_mem_patch+35



	bne	ram_done_aux	; bra

ram_1k_aux:
	inc	TOTAL_RAM
	lda	#'1'
	sta	aux_mem_patch+35

ram_no_aux:
ram_done_aux:
	;====================
	; detect CPU
	;====================

	lda	APPLEII_MODEL
	cmp	#'g'		; already handled IIgs
	beq	done_detect_cpu

	jsr	detect_65c02
	bne	was_not_65c02

	lda	#'C'
	sta	cpu_patch_1+14
	sta	cpu_patch_2+2
	lda	#'0'
	sta	cpu_patch_1+15
	sta	cpu_patch_2+3
	lda	#'2'
	sta	cpu_patch_1+16
	sta	cpu_patch_2+4

was_not_65c02:

done_detect_cpu:

	;====================
	; detect disk slot
	;====================

;	lda	$B5F7			; slot*16

	lda	WHICH_SLOT

	lsr
	lsr
	lsr
	lsr
	adc	#'0'
	sta	slot_patch1+1
;	sta	slot_patch2+1
	sta	slot_patch3+1
	sta	slot_patch5+7
	sta	slot_patch6+7

	;=====================
	; Detect mockingboard
	;=====================

	lda	#0
	sta	SOUND_STATUS

PT3_ENABLE_APPLE_IIC = 1

	jsr	mockingboard_detect
	bcc	mockingboard_notfound

mockingboard_found:
	lda	MB_ADDR_H
	and	#$7
	ora	#$30

	sta	mock_slot_patch+7

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

mockingboard_notfound:


	;===================
	; Load graphics
	;===================

	lda	#<graphics_data
	sta	zx_src_l+1
	lda	#>graphics_data
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	; Bios screen 1

	lda	#0
	sta	CH
	sta	CV

	lda	#<bios_message_1
	ldy	#>bios_message_1
	ldx	#5
	jsr	draw_multiple_strings

	lda	#0
	sta	CH
	lda	#176
	sta	CV

	lda	#<bios_message_1a
	ldy	#>bios_message_1a
	ldx	#2
	jsr	draw_multiple_strings


	;=========================
	; do fake memory count

	lda	TOTAL_RAM
	sta	MEMCOUNT
memcount_loop:
	lda	KEYPRESS				; 4
	bmi	done_memcount				; 3

	lda	#100
	jsr	wait

	jsr	increment_memory
	dec	MEMCOUNT
	bne	memcount_loop

done_memcount:

	bit	KEYRESET	; clear the keyboard buffer

;	bit	$C0E9			; turn on drive motor (slot6)

	; TODO: drive2 as well?

	ldx	#35
	jsr	long_wait

;	bit	$C0E8			; turn off drive motor (slot6)


	;==============================
	; print system config screen
	;==============================

	; TODO:
	; clear/fade the energy star logo first
	; clear offscreen so no blinds effect

	lda	#$cc
	jsr	fade_logo_mask

	lda	#200
	jsr	wait

	lda	#$33
	jsr	fade_logo_mask

	lda	#200
	jsr	wait

	; clear screen while offscreen
	; avoid blinds effect
	jsr	hgr_page2_clearscreen
	bit	PAGE2
	jsr	hgr_page1_clearscreen
	bit	PAGE1

	jsr	BELL

	; print first part of message

	lda	#10
	sta	CH
	lda	#0
	sta	CV

	lda	#<bios_message_2
	ldy	#>bios_message_2
	ldx	#8
	jsr	draw_multiple_strings

	; optionally print mockingboard text

	lda	SOUND_STATUS
	beq	print_rest

	jsr	DrawCondensedStringAgain

print_rest:

	; print rest
	lda	#<super_serial_text
	ldy	#>super_serial_text
	ldx	#2
	jsr	draw_multiple_strings



	ldx	#10
	jsr	long_wait

	;====================
	; print DOS string
	;====================

	jsr	DrawCondensedStringAgain

	ldx	#10
	jsr	long_wait

	;====================
	; type the CD command
	;====================

	ldx	#15
	jsr	draw_dos_command

	jsr	DrawCondensedStringAgain

	;====================
	; type the DIR command
	;====================

;	jsr	DrawCondensedStringAgain
;	ldx	#6
;	jsr	draw_dos_command

;	jsr	DrawCondensedStringAgain

	;====================
	; show DIR
	;====================

;	bit	$C0E9			; turn on drive motor (slot6)

;	lda	#<bios_message_6
;	ldy	#>bios_message_6
;	ldx	#7
;	jsr	draw_multiple_strings

;	bit	$C0E8			; turn off drive motor (slot6)

	;=======================
	; type the A2 command
	;=======================

	ldx	#4
	jsr	draw_dos_command



end:
	ldx	#5
	jsr	long_wait

	rts


fake_keypress:
	inc	FAKE_KEY_COUNT

	lda	FAKE_KEY_COUNT
	and	#$1
	beq	do_fake_key

no_fake_key:
	clc
	rts

do_fake_key:
	sec
	rts


;	jmp	end


	;     0123456789012345678901234567890123456789
bios_message_1:
	.byte "Apple II Modular BIOS",13,0
	.byte "Copyright (C) 1977-1991",13,13,0
model_patch_1:	; +8
	.byte "Apple II  ",13,13,0
cpu_patch_2:	; +2
	.byte "6502   CPU at 1.023MHz",13,0
	.byte "Memory Test:      0B OK",13,0
bios_message_1a:
	.byte "Press ",$17,"-D to enter SETUP",13,0
	.byte "02/13/78-6502-564D57 V1.1",0

bios_message_2:

	.byte "System Configuration",13,0

	.byte $1D	; 0,8
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$15,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $1C, 13,0
cpu_patch_1:	; +14
	.byte $1F," CPU Type: 6502   ",$14," Base Memory: 48K  ",$1F,13,0 ; 16
lang_card_patch:  ; +34
	.byte $1F," Co-Proc:  NONE   ",$14," Lang Card:    0K  ",$1F,13,0  ; 24
aux_mem_patch:	; +34
	.byte $1F," Clock:  1.023MHz ",$14," AUX Memory:   0K  ",$1F,13,0  ; 32

	.byte $19 ; 40
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$13,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $18, 13, 0

disk_text:
slot_patch5:	;+7
	.byte $1F," Slot 6 Disk 1: Disk II 140K          ",$1F,13,0 ; 48
slot_patch6:
	.byte $1F," Slot 6 Disk 2: Disk II 140K          ",$1F,13,0 ; 56

mockingboard_text:
mock_slot_patch:	; +7
	.byte $1F," Slot 4       : VIA 6522/Mockingboard ",$1F,13,0 ; 64
super_serial_text:
	.byte $1F," Slot 1       : Super Serial Card     ",$1F,13,0 ; 72


	.byte $1B ; 80
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $1A, 13,0

bios_message3:
	.byte "Starting DOS 3.3...",13,13,0 ; 88


bios_message4:
slot_patch1:
	.byte "S6D1>",0	; 104
	.byte "c",0
	.byte "d",0
	.byte " ",0
	.byte "d",0
	.byte "e",0
	.byte "m",0
	.byte "o",0
	.byte "s",0
	.byte "\",0
	.byte "a",0
	.byte "2",0
	.byte "r",0
	.byte "e",0
	.byte "a",0
	.byte "l",13,0

bios_message7:
slot_patch3:
	.byte "S6D1>",0		; 184
	.byte "a",0
	.byte "2",0
	.byte "r",0


font_data:
	.include "font_console_1x8.s"
	.include "fonts/a2_cga_thin.inc"

graphics_data:
	.incbin "graphics/a2_energy.hgr.zx02"

	.include "../wait_keypress.s"


memcount:
	.byte $00,$00,$00

memcount_string:
;	.byte 13,48,
	.byte $00,$00,$00,$00,$00,$00,0


	;================================
	;================================
	;================================
	;================================

increment_memory:

	sed
	clc
	lda	memcount+2
	adc	#$24
	sta	memcount+2
	lda	memcount+1
	adc	#$10
	sta	memcount+1
	lda	memcount
	adc	#0
	sta	memcount
	cld

	; copy to output buffer
	ldx	#0
	stx	INL
	stx	LEAD0
do_memcount_loop:


memcount_top_nibble:
	lda	memcount,X
	lsr
	lsr
	lsr
	lsr
	bne	tn_display_digit
	ldy	LEAD0
	bne	tn_display_digit
tn_no_display_digit:
	lda	#$20		; space
	bne	tn_actually_display_digit
tn_display_digit:
	clc
	adc	#$30
	sta	LEAD0
tn_actually_display_digit:
	ldy	INL
	sta	memcount_string,Y
	inc	INL


memcount_bottom_nibble:
	lda	memcount,X
	and	#$f
	bne	display_digit
	ldy	LEAD0
	bne	display_digit
no_display_digit:
	lda	#$20		; space
	bne	actually_display_digit
display_digit:
	clc
	adc	#$30
	sta	LEAD0
actually_display_digit:
	ldy	INL
	sta	memcount_string,Y

	inc	INL


	inx
	cpx	#3
	bne	do_memcount_loop

	bit	SPEAKER

	lda	#13
	sta	CH
	lda	#48
	sta	CV

	lda	#<memcount_string
	ldy	#>memcount_string
	jmp	DrawCondensedString	; tail call


	;==============================
	;==============================
	;==============================
	;==============================
draw_multiple_strings:
	dex
	stx	STRING_COUNT

	jsr	DrawCondensedString

multiple_loop:
	jsr	DrawCondensedStringAgain
	dec	STRING_COUNT
	bne	multiple_loop

	rts

	;==============================
	;==============================
	;==============================
	;==============================
draw_dos_command:
	stx	STRING_COUNT

dos_command_loop:
	jsr	DrawCondensedStringAgain

	lda	OUTL
	pha
	lda	OUTH
	pha

dos_command_inner:
	; draw curosr
	lda	#<dos_cursor
	ldy	#>dos_cursor
	jsr	DrawCondensedString
	dec	CH
	lda	#200
	jsr	wait

	jsr	fake_keypress
;	lda	KEYPRESS
	bcs	dos_keypress

	jsr	DrawCondensedStringAgain
	dec	CH
	lda	#200
	jsr	wait

	jsr	fake_keypress

;	lda	KEYPRESS
	bcs	dos_keypress

	jmp	dos_command_inner
dos_keypress:
	bit	KEYRESET

	lda	#<dos_space
	ldy	#>dos_space
	jsr	DrawCondensedString

	dec	CH

	pla
	sta	OUTH
	pla
	sta	OUTL

	dec	STRING_COUNT
	bne	dos_command_loop

	rts

dos_cursor:
	.byte "_",0
dos_space:
	.byte " ",0


	;=======================
	;=======================
	;=======================
	; 210,0 to 210,64
fade_logo_mask:
	sta	mask_smc+1

fade_logo:
	ldx	#63
outer_loop:

	lda	hposn_low,X
	sta	inner_loop_smc1+1
	sta	inner_loop_smc2+1
	lda	hposn_high,X
	sta	inner_loop_smc1+2
	sta	inner_loop_smc2+2

	ldy	#39
inner_loop:
inner_loop_smc1:
	lda	$2000,Y
mask_smc:
	and	#$CC
inner_loop_smc2:
	sta	$2000,Y
	dey
	cpy	#29
	bne	inner_loop

	dex
	bpl	outer_loop

	rts


	; in X
long_wait:
	lda	#200
	jsr	wait

	lda	KEYPRESS
	bmi	early_out

	dex
	bne	long_wait
early_out:
	bit	KEYRESET

	rts



.include "../hgr_clear_screen.s"


.include "aux_detect.s"
.include "65c02_detect.s"
;.include "pt3_lib_mockingboard_setup.s"

;.include "pt3_lib_detect_model.s"
;.include "../lc_detect.s"
;.include "../pt3_lib_mockingboard_detect.s"
;.include "../wait.s"

