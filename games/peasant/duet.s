; ***************************************************************************
; *   Copyright (C) 1979-2015 by Paul Lutus                                 *
; *   http://arachnoid.com/administration                                   *
; *                                                                         *
; *   This program is free software; you can redistribute it and/or modify  *
; *   it under the terms of the GNU General Public License as published by  *
; *   the Free Software Foundation; either version 2 of the License, or     *
; *   (at your option) any later version.                                   *
; *                                                                         *
; *   This program is distributed in the hope that it will be useful,       *
; *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
; *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
; *   GNU General Public License for more details.                          *
; *                                                                         *
; *   You should have received a copy of the GNU General Public License     *
; *   along with this program; if not, write to the                         *
; *   Free Software Foundation, Inc.,                                       *
; *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
; ***************************************************************************

; 645d roughly trogdor music

; Electric Duet Player Routine circa 1980

; Formatting / comments added by Vince Weaver

; These are all "Free" zero page locations
;FREQ1		=	$10
;FREQ2		=	$11
;DURATION	=	$12
;INSTRUMENT1	=	$13
;INSTRUMENT2	=	$14
;MADDRL		=	$15
;MADDRH		=	$16
;LOC4E		=	$4E
;COUNT256	=	$4F

play_ed:
	lda	#$01		; 900: A9 01	; 2 *!*
	sta	INSTRUMENT1	; 902: 85 09	; 3	set default
	sta	INSTRUMENT2	; 904: 85 1D	; 3	 instruments
	pha			; 906: 48	; 3	1 on stack
	pha			; 907: 48	; 3	1 on stack
	pha			; 908: 48	; 3	1 on stack
	bne	load_triplet	; 909: D0 15	; 4 *!* start decoding

change_instrmnt:
	iny			; 90B: C8	; 2
	lda	(MADDRL),Y	; 90C: B1 1E	; 5 *!*	load next byte
	sta	INSTRUMENT1	; 90E: 85 09	; 3	save instrument
	iny			; 910: C8	; 2
	lda	(MADDRL),Y	; 911: B1 1E	; 5 *!*	load next byte
	sta	INSTRUMENT2	; 913: 85 1D	; 3	save instrument

triplet_loop:

	; flash different if trogdor music
	ldy	#2
	lda	(MADDRL),Y
	cmp	#24		; D4
	beq	no_trogdor
	bit	PAGE2
	jmp	done_duet_trog
no_trogdor:
	bit	PAGE1
done_duet_trog:

	lda	MADDRL		; 915: A5 1E	; 3 *!*	increment pointer
	clc			; 917: 18	; 2	by three
	adc	#$03		; 918: 69 03	; 2 *!*
	sta	MADDRL		; 91A: 85 1E	; 3

	bcc	load_triplet	; 91C: 90 02	; 4 *!* if overflow
	inc	MADDRH		; 91E: E6 1F	; 5	update high byte

load_triplet:
	ldy	#$00		; 920: A0 00	; 2 *!*	Set Y to zero
	lda	(MADDRL),Y	; 922: B1 1E	; 5 *!*	Load first byte
	cmp	#$01		; 924: C9 01	; 2	Compare to 1
	beq	change_instrmnt	; 926: F0 E3	; 4 *!* If one change inst
	bcs	play_note	; 928: B0 0D	; 4 *!* If >1, then duration
	pla			; 92A: 68	; 4	pop off stack
	pla			; 92B: 68	; 4	pop off stack
	pla			; 92C: 68	; 4	pop off stack

	; fallthrough if first byte was zero

	; Load byte from music stream
	; Set X=EOR if note zero, set X=CMP if it is

load_freq:
	ldx	#$49		; 92D: A2 49	; 2 *!*	X=0x49 (EOR opcode)
	iny			; 92F: C8	; 2	increment to next byte
	lda	(MADDRL),Y	; 930: B1 1E	; 5 *!*	load next byte
	bne	exit_player	; 932: D0 02	; 4 *!* if not zero
	ldx	#$C9		; 934: A2 C9	; 2 *!* X=0xC9 (CMP opcode)

exit_player:
	; if byte0==0 and byte1==0 then end (I have no idea how)
	rts			; 936: 60	; 6	return

	; We've got a duration/note/note triplet here

play_note:
	sta	DURATION	; 937: 85 08	; 3	store out duration
	jsr	load_freq	; 939: 20 2D09	; 6	get freq#1
	stx	selfmodify1	; 93C: 8E 8309	; 4	if 0 self-modify EOR/CMP
	sta	FREQ1		; 93F: 85 06	; 3
	ldx	INSTRUMENT1	; 941: A6 09	; 3 *!*

instr1_adjust:
	lsr	A		; 943: 4A	; 2	rshift freq by inst#
	dex			; 944: CA	; 2
	bne	instr1_adjust	; 945: D0 FC	; 4 *!*
	sta	selfmodify2+1	; 947: 8D 7C09	; 4	self-modify a CPY

	jsr	load_freq	; 94A: 20 2D09	; 6	get freq#2
	stx	selfmodify3	; 94D: 8E BB09	; 4	if 0 self-modify EOR/CMP
	sta	FREQ2		; 950: 85 07	; 3
	ldx	INSTRUMENT2	; 952: A6 1D	; 3 *!*
instr2_adjust:
	lsr	A		; 954: 4A	; 2	rshift freq by inst#
	dex			; 955: CA	; 2
	bne	instr2_adjust	; 956: D0 FC	; 4 *!*
	sta	selfmodify4+1	; 958: 8D B409	; 4	self modify a CPX

	pla			; 95B: 68	; 4
	tay			; 95C: A8	; 2
	pla			; 95D: 68	; 4
	tax			; 95E: AA	; 2
	pla			; 95F: 68	; 4
	bne	label8		; 960: D0 03	; 4 *!*

label99:
	bit	$C030		; 962: 2C 30C0	; 4		SPEAKER
label8:
	cmp	#$00		; 965: C9 00	; 2
	bmi	label7		; 967: 30 03	; 4 *!*
	nop			; 969: EA	; 2
	bpl	label9		; 96A: 10 03	; 4 *!*
label7:
	bit	$C030		; 96C: 2C 30C0	; 4		SPEAKER
label9:
	sta	LOC4E		; 96F: 85 4E	; 3
	bit	$C000		; 971: 2C 00C0	; 4	KEYBOARD DATA
	bmi	exit_keypress	; 974: 30 C0	; 4 *!*	if keypress, exit
	dey			; 976: 88	; 2
	bne	selfmodify2	; 977: D0 02	; 4 *!*
	beq	label11		; 979: F0 06	; 4 *!*
selfmodify2:
	cpy	#$00		; 97B: C0 00	; 2
	beq	selfmodify1	; 97D: F0 04	; 4 *!*		!!!
	bne	label13		; 97F: D0 04	; 4 *!*
label11:
	ldy	FREQ1		; 981: A4 06	; 3 *!*
selfmodify1:
	eor	#$40		; 983: 49 40	; 2 *!*		!!!
label13:
	bit	LOC4E		; 985: 24 4E	; 3
	bvc	label14		; 987: 50 07	; 4 *!*
	bvs	label15		; 989: 70 00	; 4 *!*
label15:
	bpl	label16		; 98B: 10 09	; 4 *!*
	nop			; 98D: EA	; 2
	bmi	label17		; 98E: 30 09	; 4 *!*
label14:
	nop			; 990: EA	; 2
	bmi	label16		; 991: 30 03	; 4 *!*
	nop			; 993: EA	; 2
	bpl	label17		; 994: 10 03	; 4 *!*
label16:
	cmp	$C030		; 996: CD 30C0	; 4		SPEAKER
label17:
	dec	COUNT256	; 999: C6 4F	; 5	div by 256 counter
	bne	label18		; 99B: D0 11	; 4 *!*

	dec	DURATION	; 99D: C6 08	; 5
	bne	label18		; 99F: D0 0D	; 4 *!*
	bvc	label19		; 9A1: 50 03	; 4 *!*
	bit	$C030		; 9A3: 2C 30C0	; 4		SPEAKER
label19:
	pha			; 9A6: 48	; 3
	txa			; 9A7: 8A	; 2
	pha			; 9A8: 48	; 3
	tya			; 9A9: 98	; 2
	pha			; 9AA: 48	; 3
	jmp	triplet_loop	; 9AB: 4C 1509	; 3

label18:
	dex			; 9AE: CA	; 2
	bne	selfmodify4	; 9AF: D0 02	; 4 *!*
	beq	label21		; 9B1: F0 06	; 4 *!*
selfmodify4:
	cpx	#$00		; 9B3: E0 00	; 2
	beq	selfmodify3	; 9B5: F0 04	; 4 *!*		!!!
	bne	label23		; 9B7: D0 04	; 4 *!*
label21:
	ldx	FREQ2		; 9B9: A6 07	; 3 *!*
selfmodify3:
	eor	#$80		; 9BB: 49 80	; 2 *!*		!!!
label23:
	bvs	label99		; 9BD: 70 A3	; 4 *!*
	nop			; 9BF: EA	; 2
	bvc	label8		; 9C0: 50 A3	; 4 *!*

exit_keypress:
	inc	duet_done
	rts



duet_done:
	.byte $00
