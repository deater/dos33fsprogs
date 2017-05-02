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

.define EQU =

; These are all "Free" zero page locations
LOC6	EQU	$06
LOC7	EQU	$07
LOC8	EQU	$08
LOC9	EQU	$09
LOC1D	EQU	$1D
LOC1E	EQU	$1E
LOC1F	EQU	$1F
LOC4E	EQU	$4E
LOC4F	EQU	$4F

	LDA	#$01		; 900: A9 01	; 2 *!*
	STA	LOC9		; 902: 85 09	; 3
	STA	LOC1D		; 904: 85 1D	; 3
	PHA			; 906: 48	; 3
	PHA			; 907: 48	; 3
	PHA			; 908: 48	; 3
	BNE	label1		; 909: D0 15	; 4 *!*
label2:
	INY			; 90B: C8	; 2
	LDA	(LOC1E),Y	; 90C: B1 1E	; 5 *!*
	STA	LOC9		; 90E: 85 09	; 3
	INY			; 910: C8	; 2
	LDA	(LOC1E),Y	; 911: B1 1E	; 5 *!*
	STA	LOC1D		; 913: 85 1D	; 3
loop:
	LDA	LOC1E		; 915: A5 1E	; 3 *!*
	CLC			; 917: 18	; 2
	ADC	#$03		; 918: 69 03	; 2 *!*
	STA	LOC1E		; 91A: 85 1E	; 3
	BCC	label1		; 91C: 90 02	; 4 *!*
	INC	LOC1F		; 91E: E6 1F	; 5
label1:
	LDY	#$00		; 920: A0 00	; 2 *!*
	LDA	(LOC1E),Y	; 922: B1 1E	; 5 *!*
	CMP	#$01		; 924: C9 01	; 2
	BEQ	label2		; 926: F0 E3	; 4 *!*
	BCS	label3		; 928: B0 0D	; 4 *!*
	PLA			; 92A: 68	; 4
	PLA			; 92B: 68	; 4
	PLA			; 92C: 68	; 4
sub1:
	LDX	#$49		; 92D: A2 49	; 2 *!*
	INY			; 92F: C8	; 2
	LDA	(LOC1E),Y	; 930: B1 1E	; 5 *!*
	BNE	label4		; 932: D0 02	; 4 *!*
	LDX	#$C9		; 934: A2 C9	; 2 *!*
label4:
	RTS			; 936: 60	; 6
label3:
	STA	LOC8		; 937: 85 08	; 3
	JSR	sub1		; 939: 20 2D09	; 6
	STX	$0983		; 93C: 8E 8309	; 4		; self-modify
	STA	LOC6		; 93F: 85 06	; 3
	LDX	LOC9		; 941: A6 09	; 3 *!*
label5:
	LSR	A		; 943: 4A	; 2
	DEX			; 944: CA	; 2
	BNE	label5		; 945: D0 FC	; 4 *!*
	STA	$097C		; 947: 8D 7C09	; 4		; self-modify
	JSR	sub1		; 94A: 20 2D09	; 6
	STX	$09BB		; 94D: 8E BB09	; 4		; self-modify
	STA	LOC7		; 950: 85 07	; 3
	LDX	LOC1D		; 952: A6 1D	; 3 *!*
label6:
	LSR	A		; 954: 4A	; 2
	DEX			; 955: CA	; 2
	BNE	label6		; 956: D0 FC	; 4 *!*
	STA	$09B4		; 958: 8D B409	; 4		; self-modify
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
	BIT	$C000		; 971: 2C 00C0	; 4
	BMI	label4		; 974: 30 C0	; 4 *!*
	DEY			; 976: 88	; 2
	BNE	label10		; 977: D0 02	; 4 *!*
	BEQ	label11		; 979: F0 06	; 4 *!*
label10:
	CPY	#$00		; 97B: C0 00	; 2
	BEQ	label12		; 97D: F0 04	; 4 *!*		!!!
	BNE	label13		; 97F: D0 04	; 4 *!*
label11:
	LDY	LOC6		; 981: A4 06	; 3 *!*
label12:
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
	DEC	LOC4F		; 999: C6 4F	; 5
	BNE	label18		; 99B: D0 11	; 4 *!*
	DEC	LOC8		; 99D: C6 08	; 5
	BNE	label18		; 99F: D0 0D	; 4 *!*
	BVC	label19		; 9A1: 50 03	; 4 *!*
	BIT	$C030		; 9A3: 2C 30C0	; 4		SPEAKER
label19:
	PHA			; 9A6: 48	; 3
	TXA			; 9A7: 8A	; 2
	PHA			; 9A8: 48	; 3
	TYA			; 9A9: 98	; 2
	PHA			; 9AA: 48	; 3
	JMP	loop		; 9AB: 4C 1509	; 3
label18:
	DEX			; 9AE: CA	; 2
	BNE	label20		; 9AF: D0 02	; 4 *!*
	BEQ	label21		; 9B1: F0 06	; 4 *!*
label20:
	CPX	#$00		; 9B3: E0 00	; 2
	BEQ	label22		; 9B5: F0 04	; 4 *!*		!!!
	BNE	label23		; 9B7: D0 04	; 4 *!*
label21:
	LDX	LOC7		; 9B9: A6 07	; 3 *!*
label22:
	EOR	#$80		; 9BB: 49 80	; 2 *!*		!!!
label23:
	BVS	label99		; 9BD: 70 A3	; 4 *!*
	NOP			; 9BF: EA	; 2
	BVC	label8		; 9C0: 50 A3	; 4 *!*
