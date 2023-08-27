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

	jsr	wait_until_keypress

	;==============================
	; print system config screen
	;==============================

	; TODO:
	; clear/fade the energy star logo first
	; clear offscreen so no blinds effect

	jsr	HGR
	bit	FULLGR

	lda	#<bios_message_2
	ldy	#>bios_message_2
	ldx	#11
	jsr	draw_multiple_strings

	jsr	wait_until_keypress

	;====================
	; print DOS string
	;====================

	jsr	DrawCondensedStringAgain

	jsr	wait_until_keypress

	;====================
	; type the CD command
	;====================

	ldx	#18
	jsr	draw_dos_command

	;====================
	; type the DIR command
	;====================

	ldx	#7
	jsr	draw_dos_command

	;====================
	; show DIR
	;====================

	lda	#<bios_message_6
	ldy	#>bios_message_6
	ldx	#7
	jsr	draw_multiple_strings

	;=======================
	; type the LEMM command
	;=======================

	jsr	scroll_screen

	jsr	wait_until_keypress


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
	.byte 10,0,"System Configuration",0
	.byte 0,8,  $1D
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $1C, 0
	.byte 0,16, $1F," CPU Type: 65C02    Base Memory: 48K  ",$1F,0
	.byte 0,24,$1F," Co-Proc:   NONE    Lang Card:   16K  ",$1F,0
	.byte 0,32,$1F," Clock:  1.023MHz   AUX Memory:  64K  ",$1F,0

	.byte 0,40,$19
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $18, 0

	.byte 0,48,$1F," Slot 6 Disk 1: Disk II 140K          ",$1F,0
	.byte 0,56,$1F," Slot 6 Disk 2: Disk II 140K          ",$1F,0
	.byte 0,64,$1F," Slot 4       : VIA 6522/Mockingboard ",$1F,0
	.byte 0,72,$1F," Slot 1       : Super Serial Card     ",$1F,0


	.byte 0,80,$1B
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	.byte $1E,$1E,$1E,$1E,$1E,$1E
	.byte $1A, 0

bios_message3:
	.byte 0,88,"Starting DOS 3.3...",0


bios_message4:
	.byte 0,104,"S6D1>",0
	.byte 5,104,"c",0
	.byte 6,104,"d",0
	.byte 7,104," ",0
	.byte 8,104,"g",0
	.byte 9,104,"a",0
	.byte 10,104,"m",0
	.byte 11,104,"e",0
	.byte 12,104,"s",0
	.byte 13,104,"\",0
	.byte 14,104,"l",0
	.byte 15,104,"e",0
	.byte 16,104,"m",0
	.byte 17,104,"m",0
	.byte 18,104,"i",0
	.byte 19,104,"n",0
	.byte 20,104,"g",0
	.byte 21,104,"s",0

bios_message5:
	.byte 0,112,"S6D1>",0
	.byte 5,112,"d",0
	.byte 6,112,"i",0
	.byte 7,112,"r",0
	.byte 8,112," ",0
	.byte 9,112,"/",0
	.byte 10,112,"w",0

bios_message_6:
	.byte 0,128,"Directory of s6d1:\games\lemmings\.",0
	.byte 0,136,"[.]       [..]     QBOOT    QLOAD",0
	.byte 0,144,"LEVEL1    LEVEL2   LEVEL3   LEVEL4",0
	.byte 0,152,"LEVEL5    LEVEL6   LEVEL7   LEVEL8",0
	.byte 0,160,"LEVEL9    LEVEL10  LEMM",0
	.byte 0,168,"13 File(s)        90,624 Bytes.",0
	.byte 0,176," 2 Dir(s)         52,736 Bytes free.",0

bios_message7:
	.byte 0,184,"S6D1>",0
	.byte 5,184,"l",0
	.byte 6,184,"e",0
	.byte 7,184,"m",0
	.byte 8,184,"m",0

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

dos_command_inner:
	; draw curosr

	; erase cursor


	jsr	wait_until_keypress

	dec	STRING_COUNT
	bne	dos_command_loop

	rts


	;================================
	;================================
	;================================
	;================================
scroll_screen:
	ldx	#8
	stx	INL
	ldx	#0
	stx	OUTL

scroll_yloop:
	ldx	INL
	lda	hposn_low,X
	sta	xloop_smc1+1
	lda	hposn_high,X
	sta	xloop_smc1+2

	ldx	OUTL
	lda	hposn_low,X
	sta	xloop_smc2+1
	lda	hposn_high,X
	sta	xloop_smc2+2

	ldy	#39
scroll_xloop:
xloop_smc1:
	lda	$2000,Y
xloop_smc2:
	sta	$2000,Y
	dey
	bpl	scroll_xloop

	inc	INL
	inc	OUTL

	lda	INL
	cmp	#192
	bne	scroll_yloop

	; blank bottom line


	lda	#$00
	ldy	#39
scroll_hline_xloop:
	sta	$23D0,Y
	sta	$27D0,Y
	sta	$2BD0,Y
	sta	$2FD0,Y
	sta	$33D0,Y
	sta	$37D0,Y
	sta	$3BD0,Y
	sta	$3FD0,Y
	dey
	bpl	scroll_hline_xloop

	rts

