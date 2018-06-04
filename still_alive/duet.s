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

; Electric Duet Player Routine circa 1980

; Most comments added by Vince Weaver

;.define EQU =

; These are all "Free" zero page locations
;FREQ1		EQU	$06
;FREQ2		EQU	$07
;DURATION	EQU	$08
;INSTRUMENT1	EQU	$09
;INSTRUMENT2	EQU	$1D
;MADDRL		EQU	$1E
;MADDRH		EQU	$1F
;LOC4E		EQU	$4E
;COUNT256	EQU	$4F

play_ed:
	LDA	#$01		; 900: A9 01	; 2 *!*
	STA	INSTRUMENT1	; 902: 85 09	; 3	set default
	STA	INSTRUMENT2	; 904: 85 1D	; 3	 instruments
	PHA			; 906: 48	; 3	1 on stack
	PHA			; 907: 48	; 3	1 on stack
	PHA			; 908: 48	; 3	1 on stack
	BNE	load_triplet	; 909: D0 15	; 4 *!* start decoding

change_instrmnt:
	INY			; 90B: C8	; 2
	LDA	(MADDRL),Y	; 90C: B1 1E	; 5 *!*	load next byte
	STA	INSTRUMENT1	; 90E: 85 09	; 3	save instrument
	INY			; 910: C8	; 2
	LDA	(MADDRL),Y	; 911: B1 1E	; 5 *!*	load next byte
	STA	INSTRUMENT2	; 913: 85 1D	; 3	save instrument

triplet_loop:
	LDA	MADDRL		; 915: A5 1E	; 3 *!*	increment pointer
	CLC			; 917: 18	; 2	by three
	ADC	#$03		; 918: 69 03	; 2 *!*
	STA	MADDRL		; 91A: 85 1E	; 3

	BCC	load_triplet	; 91C: 90 02	; 4 *!* if overflow
	INC	MADDRH		; 91E: E6 1F	; 5	update high byte

load_triplet:
	LDY	#$00		; 920: A0 00	; 2 *!*	Set Y to zero
	LDA	(MADDRL),Y	; 922: B1 1E	; 5 *!*	Load first byte
	CMP	#$01		; 924: C9 01	; 2	Compare to 1
	BEQ	change_instrmnt	; 926: F0 E3	; 4 *!* If one change inst
	BCS	play_note	; 928: B0 0D	; 4 *!* If >1, then duration
	PLA			; 92A: 68	; 4	pop off stack
	PLA			; 92B: 68	; 4	pop off stack
	PLA			; 92C: 68	; 4	pop off stack

	; fallthrough if first byte was zero

	; Load byte from music stream
	; Set X=EOR if note zero, set X=CMP if it is

load_freq:
	LDX	#$49		; 92D: A2 49	; 2 *!*	X=0x49 (EOR opcode)
	INY			; 92F: C8	; 2	increment to next byte
	LDA	(MADDRL),Y	; 930: B1 1E	; 5 *!*	load next byte
	BNE	exit_player	; 932: D0 02	; 4 *!* if not zero
	LDX	#$C9		; 934: A2 C9	; 2 *!* X=0xC9 (CMP opcode)

exit_player:
	; if byte0==0 and byte1==0 then done playing
	RTS			; 936: 60	; 6	return


	; We've got a duration/note/note triplet here

play_note:
	STA	DURATION	; 937: 85 08	; 3	store out duration
	JSR	load_freq	; 939: 20 2D09	; 6	get freq#1
	STX	selfmodify1	; 93C: 8E 8309	; 4	if 0 self-modify EOR/CMP
	STA	FREQ1		; 93F: 85 06	; 3
	LDX	INSTRUMENT1	; 941: A6 09	; 3 *!*

instr1_adjust:
	LSR	A		; 943: 4A	; 2	rshift freq by inst#
	DEX			; 944: CA	; 2
	BNE	instr1_adjust	; 945: D0 FC	; 4 *!*
	STA	selfmodify2+1	; 947: 8D 7C09	; 4	self-modify a CPY

	JSR	load_freq	; 94A: 20 2D09	; 6	get freq#2
	STX	selfmodify3	; 94D: 8E BB09	; 4	if 0 self-modify EOR/CMP
	STA	FREQ2		; 950: 85 07	; 3
	LDX	INSTRUMENT2	; 952: A6 1D	; 3 *!*
instr2_adjust:
	LSR	A		; 954: 4A	; 2	rshift freq by inst#
	DEX			; 955: CA	; 2
	BNE	instr2_adjust	; 956: D0 FC	; 4 *!*
	STA	selfmodify4+1	; 958: 8D B409	; 4	self modify a CPX

	PLA			; 95B: 68	; 4
	TAY			; 95C: A8	; 2
	PLA			; 95D: 68	; 4
	TAX			; 95E: AA	; 2
	PLA			; 95F: 68	; 4
	BNE	label8		; 960: D0 03	; 4 *!*

label99:
	BIT	$C030		; 962: 2C 30C0	; 4		SPEAKER
label8:
	CMP	#$00		; 965: C9 00	; 2
	BMI	label7		; 967: 30 03	; 4 *!*
	NOP			; 969: EA	; 2
	BPL	label9		; 96A: 10 03	; 4 *!*
label7:
	BIT	$C030		; 96C: 2C 30C0	; 4		SPEAKER
label9:
	STA	LOC4E		; 96F: 85 4E	; 3
	BIT	$C000		; 971: 2C 00C0	; 4	KEYBOARD DATA
	BMI	exit_player	; 974: 30 C0	; 4 *!*	if keypress, exit
	DEY			; 976: 88	; 2
	BNE	selfmodify2	; 977: D0 02	; 4 *!*
	BEQ	label11		; 979: F0 06	; 4 *!*
selfmodify2:
	CPY	#$00		; 97B: C0 00	; 2
	BEQ	selfmodify1	; 97D: F0 04	; 4 *!*		!!!
	BNE	label13		; 97F: D0 04	; 4 *!*
label11:
	LDY	FREQ1		; 981: A4 06	; 3 *!*
selfmodify1:
	EOR	#$40		; 983: 49 40	; 2 *!*		!!!
label13:
	BIT	LOC4E		; 985: 24 4E	; 3
	BVC	label14		; 987: 50 07	; 4 *!*
	BVS	label15		; 989: 70 00	; 4 *!*
label15:
	BPL	label16		; 98B: 10 09	; 4 *!*
	NOP			; 98D: EA	; 2
	BMI	label17		; 98E: 30 09	; 4 *!*
label14:
	NOP			; 990: EA	; 2
	BMI	label16		; 991: 30 03	; 4 *!*
	NOP			; 993: EA	; 2
	BPL	label17		; 994: 10 03	; 4 *!*
label16:
	CMP	$C030		; 996: CD 30C0	; 4		SPEAKER
label17:
	DEC	COUNT256	; 999: C6 4F	; 5	div by 256 counter
	BNE	label18		; 99B: D0 11	; 4 *!*

	DEC	DURATION	; 99D: C6 08	; 5
	BNE	label18		; 99F: D0 0D	; 4 *!*
	BVC	label19		; 9A1: 50 03	; 4 *!*
	BIT	$C030		; 9A3: 2C 30C0	; 4		SPEAKER
label19:
	PHA			; 9A6: 48	; 3
	TXA			; 9A7: 8A	; 2
	PHA			; 9A8: 48	; 3
	TYA			; 9A9: 98	; 2
	PHA			; 9AA: 48	; 3
	JMP	triplet_loop	; 9AB: 4C 1509	; 3

label18:
	DEX			; 9AE: CA	; 2
	BNE	selfmodify4	; 9AF: D0 02	; 4 *!*
	BEQ	label21		; 9B1: F0 06	; 4 *!*
selfmodify4:
	CPX	#$00		; 9B3: E0 00	; 2
	BEQ	selfmodify3	; 9B5: F0 04	; 4 *!*		!!!
	BNE	label23		; 9B7: D0 04	; 4 *!*
label21:
	LDX	FREQ2		; 9B9: A6 07	; 3 *!*
selfmodify3:
	EOR	#$80		; 9BB: 49 80	; 2 *!*		!!!
label23:
	BVS	label99		; 9BD: 70 A3	; 4 *!*
	NOP			; 9BF: EA	; 2
	BVC	label8		; 9C0: 50 A3	; 4 *!*

