; Fake BIOS screen
;  for another project

.include "zp.inc"
.include "hardware.inc"


bios_test:
	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	jsr	build_tables

	;===================
	; Load graphics
	;===================

	lda	#<graphics_data
	sta	ZX0_src
	lda	#>graphics_data
	sta	ZX0_src+1

	lda	#$20			; temporarily load to $2000

	jsr	full_decomp

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

	lda	#128
	sta	MEMCOUNT
memcount_loop:
	lda	KEYPRESS				; 4
	bmi	done_memcount				; 3

	lda	#100
	jsr	WAIT

	jsr	increment_memory
	dec	MEMCOUNT
	bpl	memcount_loop

done_memcount:

	bit	KEYRESET	; clear the keyboard buffer

	bit	$C0E9			; turn on drive motor (slot6)

	; TODO: drive2 as well?

	ldx	#100
	jsr	long_wait

	bit	$C0E8			; turn off drive motor (slot6)


	;==============================
	; print system config screen
	;==============================

	; TODO:
	; clear/fade the energy star logo first
	; clear offscreen so no blinds effect

	lda	#$cc
	jsr	fade_logo_mask

	lda	#200
	jsr	WAIT

	lda	#$33
	jsr	fade_logo_mask

	lda	#200
	jsr	WAIT

	; clear screen while offscreen
	; avoid blinds effect
	jsr	hgr_page2_clearscreen
	bit	PAGE2
	jsr	hgr_page1_clearscreen
	bit	PAGE1

	jsr	BELL


	lda	#10
	sta	CH
	lda	#0
	sta	CV

	lda	#<bios_message_2
	ldy	#>bios_message_2
	ldx	#11
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

	ldx	#17
	jsr	draw_dos_command

	jsr	DrawCondensedStringAgain

	;====================
	; type the DIR command
	;====================

	jsr	DrawCondensedStringAgain
	ldx	#6
	jsr	draw_dos_command

	jsr	DrawCondensedStringAgain

	;====================
	; show DIR
	;====================

	bit	$C0E9			; turn on drive motor (slot6)

	lda	#<bios_message_6
	ldy	#>bios_message_6
	ldx	#7
	jsr	draw_multiple_strings

	bit	$C0E8			; turn off drive motor (slot6)

	;=======================
	; type the LEMM command
	;=======================

	ldx	#5
	jsr	draw_dos_command



end:
	jmp	end


	;     0123456789012345678901234567890123456789
bios_message_1:
	.byte "Apple II Modular BIOS",13,0
	.byte "Copyright (C) 1977-1991",13,13,0
	.byte "Apple IIe ",13,13,0
	.byte "65C02 CPU at 1.023MHz",13,0
	.byte "Memory Test:      0B OK",13,0
bios_message_1a:
	.byte "Press ",$17,"-D to enter SETUP",13,0
	.byte "02/13/78-6502-564D57",0

bios_message_2:

	.byte "System Configuration",13,0

	.byte $1D	; 0,8
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$15,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $1C, 13,0
	.byte $1F," CPU Type: 65C02  ",$14," Base Memory: 48K  ",$1F,13,0 ; 16
	.byte $1F," Co-Proc:   NONE  ",$14," Lang Card:   16K  ",$1F,13,0  ; 24
	.byte $1F," Clock:  1.023MHz ",$14," AUX Memory:  64K  ",$1F,13,0  ; 32

	.byte $19 ; 40
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$13,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $18, 13, 0

	.byte $1F," Slot 6 Disk 1: Disk II 140K          ",$1F,13,0 ; 48
	.byte $1F," Slot 6 Disk 2: Disk II 140K          ",$1F,13,0 ; 56
	.byte $1F," Slot 4       : VIA 6522/Mockingboard ",$1F,13,0 ; 64
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
	.byte "S6D1>",0	; 104
	.byte "c",0
	.byte "d",0
	.byte " ",0
	.byte "g",0
	.byte "a",0
	.byte "m",0
	.byte "e",0
	.byte "s",0
	.byte "\",0
	.byte "l",0
	.byte "e",0
	.byte "m",0
	.byte "m",0
	.byte "i",0
	.byte "n",0
	.byte "g",0
	.byte "s",13,0

bios_message5:
	.byte 13,0
	.byte "S6D1>",0		; 112
	.byte "d",0
	.byte "i",0
	.byte "r",0
	.byte " ",0
	.byte "/",0
	.byte "w",13,0

bios_message_6:
	.byte "Directory of s6d1:\games\lemmings\.",13,0	; 128
	.byte "[.]       [..]     QBOOT    QLOAD",13,0
	.byte "LEVEL1    LEVEL2   LEVEL3   LEVEL4",13,0
	.byte "LEVEL5    LEVEL6   LEVEL7   LEVEL8",13,0
	.byte "LEVEL9    LEVEL10  LEMM",13,0
	.byte "   13 File(s)        90,624 Bytes.",13,0
	.byte "    2 Dir(s)         52,736 Bytes free.",13,13,0

bios_message7:
	.byte "S6D1>",0		; 184
	.byte "l",0
	.byte "e",0
	.byte "m",0
	.byte "m",0

	.include "font_console_1x8.s"
	.include "fonts/a2_cga_thin.inc"

	.include "zx02_optim.s"

graphics_data:
	.incbin "graphics/a2_energy.hgr.zx02"

hposn_low	= $1713	; 0xC0 bytes (lifetime, used by DrawLargeCharacter)
hposn_high	= $1800	; 0xC0 bytes (lifetime, used by DrawLargeCharacter)

	.include "hgr_table.s"


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts						; 6


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
	jsr	WAIT

	lda	KEYPRESS
	bmi	dos_keypress

	jsr	DrawCondensedStringAgain
	dec	CH
	lda	#200
	jsr	WAIT

	lda	KEYPRESS
	bmi	dos_keypress

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
	jsr	WAIT

	lda	KEYPRESS
	bmi	early_out

	dex
	bne	long_wait
early_out:
	bit	KEYRESET

	rts



.include "hgr_clear_screen.s"
