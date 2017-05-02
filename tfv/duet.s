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

	LDA	#$01		; $0900> A9 01 ; 2 *!*
	STA	$09		; $0902> 85 09 ; 3
	STA	$1D		; $0904> 85 1D ; 3
	PHA			; $0906> 48:      PHA             ; 3
	PHA			; $0907> 48:      PHA             ; 3
	PHA			; $0908> 48:      PHA             ; 3
	BNE	label1		; $0909> D0 15:   BNE $0920       ; 4 *!*
label2:
	INY			; $090B> C8:      INY             ; 2
	LDA	($1E),Y		; $090C> B1 1E:   LDA ($1E),Y     ; 5 *!*
	STA	$09		; $090E> 85 09:   STA $09         ; 3
	INY			; $0910> C8:      INY             ; 2
	LDA	($1E),Y		; $0911> B1 1E:   LDA ($1E),Y     ; 5 *!*
	STA	$1D		; $0913> 85 1D:   STA $1D         ; 3
	LDA	$1E		; $0915> A5 1E:   LDA $1E         ; 3 *!*
	CLC			; $0917> 18:      CLC             ; 2
	ADC	#$03		; $0918> 69 03:   ADC #$03        ; 2 *!*
	STA	$1E		; $091A> 85 1E:   STA $1E         ; 3
	BCC	label1		; $091C> 90 02:   BCC $0920       ; 4 *!*
	INC	$1F		; $091E> E6 1F:   INC $1F         ; 5
label1:
	LDY	#$00		; $0920> A0 00:   LDY #$00        ; 2 *!*
	LDA	($1E),Y		; $0922> B1 1E:   LDA ($1E),Y     ; 5 *!*
	CMP	#$01		; $0924> C9 01:   CMP #$01        ; 2
	BEQ	label2		; $0926> F0 E3:   BEQ $090B       ; 4 *!*
	BCS	label3		; $0928> B0 0D:   BCS $0937       ; 4 *!*
	PLA			; $092A> 68:      PLA             ; 4
	PLA			; $092B> 68:      PLA             ; 4
	PLA			; $092C> 68:      PLA             ; 4
	LDX	#$49		; $092D> A2 49:   LDX #$49        ; 2 *!*
	INY			; $092F> C8:      INY             ; 2
	LDA	($1E),Y		; $0930> B1 1E:   LDA ($1E),Y     ; 5 *!*
	BNE	label4		; $0932> D0 02:   BNE $0936       ; 4 *!*
	LDX	#$C9		; $0934> A2 C9:   LDX #$c9        ; 2 *!*
label4:
	RTS			; $0936> 60:      RTS             ; 6
label3:
	STA	$08		; $0937> 85 08:   STA $08         ; 3
	JSR	$092D		; $0939> 20 2D09: JSR $092D       ; 6
	STX	$0983		; $093C> 8E 8309: STX $0983       ; 4
	STA	$06		; $093F> 85 06:   STA $06         ; 3
	LDX	$09		; $0941> A6 09:   LDX $09         ; 3 *!*
label5:
	LSR	A		; $0943> 4A:      LSR A           ; 2
	DEX			; $0944> CA:      DEX             ; 2
	BNE	label5		; $0945> D0 FC:   BNE $0943       ; 4 *!*
	STA	$097C		; $0947> 8D 7C09: STA $097C       ; 4
	JSR	$092D		; $094A> 20 2D09: JSR $092D       ; 6
	STX	$09BB		; $094D> 8E BB09: STX $09BB       ; 4
	STA	$07		; $0950> 85 07:   STA $07         ; 3
	LDX	$1D		; $0952> A6 1D:   LDX $1D         ; 3 *!*
label6:
	LSR	A		; $0954> 4A:      LSR A           ; 2
	DEX			; $0955> CA:      DEX             ; 2
	BNE	label6		; $0956> D0 FC:   BNE $0954       ; 4 *!*
	STA	$09B4		; $0958> 8D B409: STA $09B4       ; 4
	PLA			; $095B> 68:      PLA             ; 4
	TAY			; $095C> A8:      TAY             ; 2
	PLA			; $095D> 68:      PLA             ; 4
	TAX			; $095E> AA:      TAX             ; 2
	PLA			; $095F> 68:      PLA             ; 4
	BNE	label8		; $0960> D0 03:   BNE $0965       ; 4 *!*
label99:
	BIT	$C030		; $0962> 2C 30C0: BIT $C030       ; 4
label8:
	CMP	#$00		; $0965> C9 00:   CMP #$00        ; 2
	BMI	label7		; $0967> 30 03:   BMI $096C       ; 4 *!*
	NOP			; $0969> EA:      NOP             ; 2
	BPL	label9		; $096A> 10 03:   BPL $096F       ; 4 *!*
label7:
	BIT	$C030		; $096C> 2C 30C0: BIT $C030       ; 4
label9:
	STA	$4E		; $096F> 85 4E:   STA $4E         ; 3
	BIT	$C000		; $0971> 2C 00C0: BIT $C000       ; 4
	BMI	label4		; $0974> 30 C0:   BMI $0936       ; 4 *!*
	DEY			; $0976> 88:      DEY             ; 2
	BNE	label10		; $0977> D0 02:   BNE $097B       ; 4 *!*
	BEQ	label11		; $0979> F0 06:   BEQ $0981       ; 4 *!*
label10:
	CPY	#$00		; $097B> C0 00:   CPY #$00        ; 2
	BEQ	label12		; $097D> F0 04:   BEQ $0983       ; 4 *!*
	BNE	label13		; $097F> D0 04:   BNE $0985       ; 4 *!*
label11:
	LDY	$06		; $0981> A4 06:   LDY $06         ; 3 *!*
label12:
	EOR	#$40		; $0983> 49 40:   EOR #$40        ; 2 *!*
label13:
	BIT	$4E		; $0985> 24 4E:   BIT $4E         ; 3
	BVC	label14		; $0987> 50 07:   BVC $0990       ; 4 *!*
	BVS	label15		; $0989> 70 00:   BVS $098B       ; 4 *!*
label15:
	BPL	label16		; $098B> 10 09:   BPL $0996       ; 4 *!*
	NOP			; $098D> EA:      NOP             ; 2
	BMI	label17		; $098E> 30 09:   BMI $0999       ; 4 *!*
label14:
	NOP			; $0990> EA:      NOP             ; 2
	BMI	label16		; $0991> 30 03:   BMI $0996       ; 4 *!*
	NOP			; $0993> EA:      NOP             ; 2
	BPL	label17		; $0994> 10 03:   BPL $0999       ; 4 *!*
label16:
	CMP	$C030		; $0996> CD 30C0: CMP $C030       ; 4
label17:
	DEC	$4F		; $0999> C6 4F:   DEC $4F         ; 5
	BNE	label18		; $099B> D0 11:   BNE $09AE       ; 4 *!*
	DEC	$08		; $099D> C6 08:   DEC $08         ; 5
	BNE	label18		; $099F> D0 0D:   BNE $09AE       ; 4 *!*
	BVC	label19		; $09A1> 50 03:   BVC $09A6       ; 4 *!*
	BIT	$C030		; $09A3> 2C 30C0: BIT $C030       ; 4
label19:
	PHA			; $09A6> 48:      PHA             ; 3
	TXA			; $09A7> 8A:      TXA             ; 2
	PHA			; $09A8> 48:      PHA             ; 3
	TYA			; $09A9> 98:      TYA             ; 2
	PHA			; $09AA> 48:      PHA             ; 3
	JMP	$0915		; $09AB> 4C 1509: JMP $0915       ; 3
label18:
	DEX			; $09AE> CA:      DEX             ; 2
	BNE	label20		; $09AF> D0 02:   BNE $09B3       ; 4 *!*
	BEQ	label21		; $09B1> F0 06:   BEQ $09B9       ; 4 *!*
label20:
	CPX	#$00		; $09B3> E0 00:   CPX #$00        ; 2
	BEQ	label22		; $09B5> F0 04:   BEQ $09BB       ; 4 *!*
	BNE	label23		; $09B7> D0 04:   BNE $09BD       ; 4 *!*
label21:
	LDX	$07		; $09B9> A6 07:   LDX $07         ; 3 *!*
label22:
	EOR	#$80		; $09BB> 49 80:   EOR #$80        ; 2 *!*
label23:
	BVS	label99		; $09BD> 70 A3:   BVS $0962       ; 4 *!*
	NOP			; $09BF> EA:      NOP             ; 2
	BVC	label8		; $09C0> 50 A3:   BVC $0965       ; 4 *!*
