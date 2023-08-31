; PLASMAGORIA
;
; version 0.11

;!sl "routineslabel.a"
;!convtab "a2txt.bin" ;

;	*= $4000 ; ORG

; -----------------------------------------------------------------------------
INTPLAYERYM		= $F39C
VBLANK			= $F103
; -----------------------------------------------------------------------------
; Page Zéro
bMocking		= $08	; Mockingboard (00 - NOP / 01 - OK)
bRefresh		= $0B	; byte type NTSC/60Hz - PAL/50Hz (00 = 50HZ | 01 = 60 HZ)
;
OUT1			= $20 ; +$21
OUT2			= $22 ; +$23

; compteur si pas MOCKING
COMPT1			= $30
COMPT2			= $31

;
 
PARAM1			= $60
PARAM2			= $61
PARAM3			= $62
PARAM4			= $63
count			= $64
count2			= $65
;

Page1			= $F0	; +$F1
IndexMask		= $F2
Mask			= $F3

Beat			= $FA
Mark			= $FB

; =============================================================================
RoutINTGS:

		LDA $C083
		LDA $C083
		JMP INTPLAYERYM
; =============================================================================
; ROUTINE MAIN
; =============================================================================
PLASMA_DEBUT:
			BIT $C056		; LORES
			LDA bRefresh
			BNE pd_s1
			; si 50HZ on modifie le délai d'attente final
			LDA #>FADE_OUT2
			STA OFFFADE+2
			LDA #<FADE_OUT2
			STA OFFFADE+1

pd_s1:
			LDA bMocking
			BNE MSTEP0
			JMP NO_MOCKING
; --------------------------------------------------------


; -------------------------------------
MSTEP0:
; init
			CLI				; interrupt ON ! (début music)
			LDA #00
			STA Mark
			LDA #$4C
			STA PARAM1
			LDA #$99
			STA PARAM2
			LDA #$4
			STA count
; boucle
MBP0:
	 		JSR PRECALC2
			JSR AFFICH_IN_MH
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP0
; -------------------------------------
MSTEP1:
; init
			LDA #00
			STA Mark

; boucle
MBP1:
			JSR PRECALC2
			JSR AFFICH_NOR
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP1

; -------------------------------------
MSTEP2:
; init
			LDA #00
			STA Mark
			STA Beat

; boucle
MBP2:
			JSR PRECALC2_BEAT
			JSR AFFICH_BEAT
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP2

; -------------------------------------
MSTEP3:
; init
			LDA #00
			STA Mark
			STA Beat
			STA PARAM1
			STA PARAM2
			STA PARAM3
			STA PARAM4

MBP3:			JSR PRECALC1
			JSR AFFICH_NOR2
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP3

; -------------------------------------
MSTEP4:
 ; init
			LDA #00
			STA Mark
			LDA #10
			STA count2
			LDA #$FE
			STA OFF1PR2+1
			LDA #$03
			STA OFF2PR2+1
			LDA #$05
			STA OFF3PR2+1
			LDA #<MaskP
			STA OFF1MASK+1
			LDA #>MaskP
			STA OFF2MASK+1
			LDA #14
			STA count
; boucle
MBP4:
			JSR PRECALC2
			JSR AFFICH_MASK
			JSR VBLANK
			JSR DUMP
			DEC count
			BNE Ms4
			LDA #14
			STA count
			DEC count2
			BMI MSTEP5
Ms5:
			LDX count2
			LDA TableIndexMaskB,X
			STA OFF1MASK+1
			LDA TableIndexMaskH,X
			STA OFF2MASK+1
Ms4:
			LDA Mark
			BEQ MBP4

; -------------------------------------
MSTEP5:
; init
			LDA #>TLORES2
			STA OFFNOR2+2
; boucle
MBP5:
			JSR PRECALC2
			JSR AFFICH_NOR2
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP5

; -------------------------------------
MSTEP6:
; init
			LDA #00
			STA Mark
			LDA #04
			STA count
; boucle
MBP6:
			JSR PRECALC2
			JSR AFFICH_OUT_HM
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP6

; -------------------------------------
MSTEP7:
			BIT $C057 ; HGR1/PAGE1
			LDA #00
			STA Mark
			TAX
			LDA #$A0
mbCleanTXT:
			STA $800,X
			STA $900,X
			STA $A00,X
			STA $B00,X
			DEX
			BNE mbCleanTXT
			JSR DUMP
			BIT $C051 ; TXT/PAGE1

MBP7:
			LDA Mark
			BEQ MBP7

; -------------------------------------
MSTEP8:

			LDA #00
			STA Mark
			STA PARAM1
			STA PARAM2
			STA PARAM3
			STA PARAM4

			LDX #11
mbaffcred1:
		LDA Text1,X
			STA $A50+11,X
			LDA Text2,X
			STA $B50+11,X
			DEX
			BPL mbaffcred1

MBP8:
		JSR PRECALC1
			JSR AFFICH_MASK1
			JSR VBLANK
			JSR DUMP

			LDA Mark
			BEQ MBP8
; -------------------------------------
MSTEP9:

			LDA #00
			STA Mark

			LDX #11
mbaffcred2:
			LDA Text3,X
			STA $A50+11,X
			LDA Text4,X
			STA $B50+11,X
			DEX
			BPL mbaffcred2

MBP9:
			JSR PRECALC1
			JSR AFFICH_MASK1
			JSR VBLANK
			JSR DUMP

			LDA Mark
			BEQ MBP9
; -------------------------------------
MSTEP10:
; init
			LDA #00
			STA Mark

			LDX #11
			LDA #$A0
mbaffcred3:
			STA $A50+11,X
			STA $B50+11,X
			DEX
			BPL mbaffcred3
; boucle
MBP10:
			JSR PRECALC1
OFFFADE:
			JSR FADE_OUT
			JSR AFFICH_MASK1
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ MBP10
; -------------------------------------
			; fin - nettoyage
			SEI
			LDA		#00
			STA 	OUT2			; pour qu'on soit sûr que OUT2 = 0

			; TIMER/INT off
			LDA 	#%00000000		;
			LDY 	#$0D
			STA 	(OUT2),Y 		; STA $C40D			; interrupt flag register	(Clear ALL Interrupt)
			INY
			STA 	(OUT2),Y		; STA $C40E			; interrupt Enable register (Disable Timer)

			; reset MB
			LDA 	#$00		; Set fct "Reset"
			LDY 	#$00
			STA 	(OUT2),Y	; STA $C400
			LDY 	#$80
			STA		(OUT2),Y	; STA $C480
			LDA 	#$04		; Set fct "Inactive"
			LDY 	#$00
			STA 	(OUT2),Y	; STA $C400
			LDY 	#$80
			STA		(OUT2),Y	; STA $C480

			LDA $C082			; ROM utilisable entre $D000/$FFFF
			JMP $FA62

; ============================================================================
NO_MOCKING:
STEP0:
; init
			LDA #00
			STA Mark

			LDA #$4C
			STA PARAM1
			LDA #$99
			STA PARAM2
			LDA #$4
			STA count
; boucle
BP0:
	 		JSR PRECALC2
			JSR AFFICH_IN_MH
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ BP0
; -------------------------------------
STEP1:
; init
			LDA #00
			STA COMPT1
			LDA #01
			STA COMPT2
; boucle
BP1:
			JSR PRECALC2
			JSR AFFICH_NOR
			JSR VBLANK
			JSR DUMP
			INC COMPT1
			BNE BP1
			DEC COMPT2
			BNE BP1

; -------------------------------------
STEP2:
; init
			LDA #01
			STA COMPT2
			LDA #00
			STA Beat

; boucle
BP2:
			JSR PRECALC2_BEAT
			JSR AFFICH_BEAT
			JSR VBLANK
			JSR DUMP
			INC COMPT1
			BNE BP2
			DEC COMPT2
			BNE BP2

; -------------------------------------
STEP3:
; init
			LDA #00
			STA Beat
			LDA #02
			STA COMPT2
			STA PARAM1
			STA PARAM2
			STA PARAM3
			STA PARAM4

BP3:
			JSR PRECALC1
			JSR AFFICH_NOR2
			JSR VBLANK
			JSR DUMP
			INC COMPT1
			BNE BP3
			DEC COMPT2
			BNE BP3

; -------------------------------------
STEP4:
 ; init
			LDA #02
			STA COMPT2
			LDA #10
			STA count2
			LDA #$FE
			STA OFF1PR2+1
			LDA #$03
			STA OFF2PR2+1
			LDA #$05
			STA OFF3PR2+1
			LDA #<MaskP
			STA OFF1MASK+1
			LDA #>MaskP
			STA OFF2MASK+1
			LDA #$10
			STA count
; boucle
s4_BP4:
			JSR PRECALC2
			JSR AFFICH_MASK
			JSR VBLANK
			JSR DUMP
			DEC count
			BNE s4_s4
			LDA #$10
			STA count
			DEC count2
			BMI STEP5
s5_s5:
			LDX count2
			LDA TableIndexMaskB,X
			STA OFF1MASK+1
			LDA TableIndexMaskH,X
			STA OFF2MASK+1
s4_s4:
			INC COMPT1
			BNE s4_BP4
			DEC COMPT2
			BNE s4_BP4

; -------------------------------------
STEP5:
; init
			LDA #00
			STA COMPT1
			LDA #01
			STA COMPT2
			LDA #>TLORES2
			STA OFFNOR2+2
; boucle
s5_BP5:
			JSR PRECALC2
			JSR AFFICH_NOR2
			JSR VBLANK
			JSR DUMP
			INC COMPT1
			BNE s5_BP5
			DEC COMPT2
			BNE s5_BP5

; -------------------------------------
STEP6:
; init
			LDA #00
			STA Mark
			LDA #04
			STA count
; boucle
s6_BP6:
			JSR PRECALC2
			JSR AFFICH_OUT_HM
			JSR VBLANK
			JSR DUMP
			LDA Mark
			BEQ s6_BP6

; -------------------------------------
STEP7:
			BIT $C057  ; HGR
			LDX #00
			LDA #$A0
bCleanTXT:
			STA $800,X
			STA $900,X
			STA $A00,X
			STA $B00,X
			DEX
			BNE bCleanTXT

			BIT $C051  ; TXT

BP7:
			INC COMPT1
			BNE BP7

; -------------------------------------
STEP8:
			LDA #100
			STA COMPT1
			LDA #01
			STA COMPT2
			LDA #00
			STA PARAM1
			STA PARAM2
			STA PARAM3
			STA PARAM4

			LDX #11
s8_baffcred1:
			LDA Text1,X
			STA $A50+11,X
			LDA Text2,X
			STA $B50+11,X
			DEX
			BPL s8_baffcred1

BP8:
			JSR PRECALC1
			JSR AFFICH_MASK1
			JSR VBLANK
			JSR DUMP

			INC COMPT1
			BNE BP8
			DEC COMPT2
			BNE BP8
; -------------------------------------
STEP9:
			LDA #100
			STA COMPT1
			LDA #01
			STA COMPT2

			LDX #11
s9_baffcred2:
			LDA Text3,X
			STA $A50+11,X
			LDA Text4,X
			STA $B50+11,X
			DEX
			BPL s9_baffcred2

BP9:
			JSR PRECALC1
			JSR AFFICH_MASK1
			JSR VBLANK
			JSR DUMP

			INC COMPT1
			BNE BP9
			DEC COMPT2
			BNE BP9
; -------------------------------------
STEP10:
; init
			LDA #24
			STA COMPT1
			LDA #01
			STA COMPT2

			LDX #11
			LDA #$A0
s10_baffcred3:
			STA $A50+11,X
			STA $B50+11,X
			DEX
			BPL s10_baffcred3
; boucle
BP10:
			JSR PRECALC1
			JSR FADE_OUT
			JSR AFFICH_MASK1
			JSR VBLANK
			JSR DUMP

			INC COMPT1
			BNE BP10
			DEC COMPT2
			BNE BP10

			LDA $C082			; ROM utilisable entre $D000/$FFFF
			JMP $FA62
; ============================================================================
; ROUTINES PRE CALCUL
; ============================================================================
PRECALC1:
			LDA PARAM1
			STA pc_off1+1
			LDA PARAM2
			STA pc_off2+1
			LDA PARAM3
			STA pc_off3+1
			LDA PARAM4
			STA pc_off4+1

			LDX #$28
pc_b1:
pc_off1:
		LDA SIN1
pc_off2:
		ADC SIN2
			STA Table1,X
pc_off3:
		LDA SIN3
pc_off4:
		ADC SIN1
			STA Table2,X
			INC pc_off1+1
 			INC pc_off2+1
 			INC pc_off3+1
 			INC pc_off4+1
 			dex
 			bpl pc_b1

 			INC PARAM1
 			INC PARAM1
 			DEC PARAM2
 			INC PARAM3
 			DEC PARAM4

 			RTS
 ; ============================================================================
PRECALC2:
			LDY PARAM1
			LDX PARAM2
			LDA #00
			STA pc2_off1+1

pc2_b1:
			LDA SIN4,X
			ADC SIN4,Y
pc2_off1:
		STA Table1
			TXA
OFF1PR2:
		ADC #$05
			TAX
			INY
			INC pc2_off1+1
			LDA pc2_off1+1
			BPL pc2_b1

			CLC
			LDA PARAM1
OFF2PR2:
			ADC #$07
			STA PARAM1
			LDA PARAM2
OFF3PR2:
			ADC #$FD
			STA PARAM2
			RTS
; ============================================================================
PRECALC2_BEAT:

			LDY PARAM1
			LDX PARAM2
			LDA #00
			STA pb_off1+1

pb_b1:			LDA SIN4,X
			ADC SIN4,Y
pb_off1:
			STA Table1
			TXA
pb_off2:
			ADC #$F8				; ZOOM ?! (essayer $FE, $F8)
			TAX
			INY
			INC pb_off1+1
			LDA pb_off1+1
			BPL pb_b1

			CLC
			LDA PARAM1
			ADC #07
			STA PARAM1
			LDA PARAM2
			ADC #$FD
			STA PARAM2
			LDA Beat
			BEQ pb_norm
			LDA #%01111111
			STA OFF1+1
			DEC Beat
			JMP pb_end

pb_norm:
		LDA #%11111111
			STA OFF1+1
pb_end:
		RTS
; ============================================================================
FADE_OUT:		; FADE OUT (60HZ)

fo_off1:
			LDX #00
			LDA #$20
			STA TCAR1,X
			INX
			STX fo_off1+1
			RTS
; ============================================================================
FADE_OUT2:		; FADE OUT (50HZ)

fo2_off1:
			LDX #00
			LDA #$20
			STA TCAR1,X
			INX
			STA TCAR1,X
			INX
			STX fo2_off1+1
			RTS

; ============================================================================
; ROUTINES AFFICHAGES
; ============================================================================
AFFICH_OUT_HM:			; affichage disparaissant VERTICALEMENT
				; ATTENTION de bien réinitialiser .offv1+1 et cie si réutilisation

ao_offv1:
		LDX #00

ao_b1b:
		LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39
			LDA #$00

ao_b1:
			STA (Page1),Y
			DEY
			BPL ao_b1
			DEX
			BPL ao_b1b

ao_offv2:		LDX #01			; lignes 0-23
			CPX #12
			BEQ ao_end

ao_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39			; col 0-39
			LDA Table2,X
			STA ao_off1+1
ao_bABS:
			LDA Table1,Y
ao_off1:
			ADC #00
			STA ao_off2+1
ao_off2:
			LDA TLORES2		; attention doit être alignée
			STA (Page1),Y
			DEY
			BPL ao_bABS
  			INX
ao_offv4:
	 		CPX #23
  			BNE ao_bORD


ao_offv3:
	 		LDX #23

ao_b2b:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39
			LDA #$00
ao_b2:
			STA (Page1),Y
			DEY
			BPL ao_b2
  			INX
  			CPX #24
  			BNE ao_b2b

  			DEC count
  			BMI ao_next
 			RTS

ao_next: 		INC ao_offv1+1
  			DEC ao_offv3+1

  			INC ao_offv2+1
  			DEC ao_offv4+1
  			LDA #04
  			STA count

			RTS
ao_end:			INC Mark
			JMP ao_offv3

; ============================================================================
AFFICH_IN_MH:			; affichage apparaissant VERTICALEMENT (milieu vers haut)
				; ATTENTION de bien réinitialiser .offv1+1 et cie si réutilisation

am_offv1:		LDX #11			; lignes 0-23

am_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39			; col 0-39
			LDA Table2,X
			STA am_off1+1
am_bABS:
			LDA Table1,Y
am_off1:
			ADC #00
			STA am_off2+1
am_off2:
			LDA TCAR2		; attention doit être alignée
			STA (Page1),Y
			DEY
			BPL am_bABS
  			INX
am_offv2:
	 		CPX #13
  			BNE am_bORD

  			DEC count
  			BMI am_next
 			RTS

am_next:
	 		DEC am_offv1+1
			BMI am_end
  			INC am_offv2+1
  			LDA #$3
  			STA count
			RTS

am_end:
			INC Mark
			LDA #00
			STA am_offv1+1
			RTS

; ============================================================================
AFFICH_NOR:			; AFFICHAGE "NORMAL"


			LDX #23			; lignes 0-23
afn_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39			; col 0-39
			LDA Table2,X
			STA afn_off1+1
afn_bABS:
			LDA Table1,Y
afn_off1:
			ADC #00
			STA afn_off2+1
afn_off2:
			LDA TCAR2		; attention doit être alignée
			STA (Page1),Y
			DEY
			BPL afn_bABS
  			DEX
  			BPL afn_bORD

			RTS
; ============================================================================
AFFICH_NOR2:			; AFFICHAGE "NORMAL"
			BIT $C050		; gfx (lores)
			LDX #23			; lignes 0-23
afn2_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39			; col 0-39
			LDA Table2,X
			STA afn2_off1+1
afn2_bABS:
			LDA Table1,Y
afn2_off1:		ADC #00
			STA afn2_off2+1
OFFNOR2:
afn2_off2:		LDA TLORES		; attention doit être alignée
			STA (Page1),Y
			DEY
			BPL afn2_bABS
  			DEX
  			BPL afn2_bORD

			RTS
; ============================================================================
AFFICH_BEAT:			; AFFICHAGE BEAT

			LDX #23			; lignes 0-23
afb_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #39			; col 0-39
			LDA Table2,X
			STA afb_off1+1
afb_bABS:
			LDA Table1,Y
afb_off1:
			ADC #00
			STA afb_off2+1
afb_off2:
			LDA TCAR3		; attention doit être alignée
			CMP #$AE
			BNE afb_s1
OFF1:
			AND #%11111111
afb_s1:			STA (Page1),Y
			DEY
			BPL afb_bABS
  			DEX
  			BPL afb_bORD

			RTS
 ; ============================================================================
AFFICH_MASK:		; AFFICHAGE avec MASK

			LDA #08
			STA IndexMask
OFF1MASK:
			LDA #<MaskP
			STA afm_off3+1
			STA afm_off4+1
OFF2MASK:
			LDA #>MaskP
			STA afm_off3+2
			STA afm_off4+2
afm_off4:
			LDA MaskP
			STA Mask

			LDX #00			; lignes 0-23

afm_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #00			; col 0-39
			LDA Table2,X
			STA afm_off1+1
afm_bABS:
			LDA Table1,Y
afm_off1:
			ADC #00
			STA afm_off2+1
			ASL Mask
			BCS afm_off2		; si 1 on affiche
			LDA #$00		; sinon, espace (vide)
			JMP afm_s1
afm_off2:
			LDA TLORES2		; attention doit être alignée
afm_s1:
			STA (Page1),Y
			DEC IndexMask
			BEQ afm_s2
afm_s3:
			INY
			CPY #40
			BNE afm_bABS
  			INX
  			CPX #24
  			BNE afm_bORD
  			RTS

afm_s2:			LDA #08
			STA IndexMask
			INC afm_off3+1
			BNE afm_off3
			INC afm_off3+2
afm_off3:
			LDA MaskP
			STA Mask
			JMP afm_s3
; ============================================================================

AFFICH_MASK1:		; AFFICHAGE avec MASK
			LDA #08
			STA IndexMask
			LDA #<MaskCred
			STA afm1_off3+1
			LDA #>MaskCred
			STA afm1_off3+2
			LDA MaskCred
			STA Mask

			LDX #00			; lignes 0-23
afm1_bORD:
			LDA TTB,X
			STA Page1
			LDA TTH,X
			STA Page1+1

			LDY #00			; col 0-39
			LDA Table2,X
			STA afm1_off1+1
afm1_bABS:
			LDA Table1,Y
afm1_off1:
			ADC #00
			STA afm1_off2+1
			ASL Mask
			BCC afm1_s1			; si 0 on affiche pas
afm1_off2:
			LDA TCAR1		; attention doit être alignée
			STA (Page1),Y
afm1_s1:
			DEC IndexMask
			BEQ afm1_s2
afm1_s3:
			INY
			CPY #40
			BNE afm1_bABS
  			INX
  			CPX #24
  			BNE afm1_bORD
  			RTS

afm1_s2:
			LDA #08
			STA IndexMask
			INC afm1_off3+1
			BNE afm1_off3
			INC afm1_off3+2
afm1_off3:
			LDA MaskCred
			STA Mask
			JMP afm1_s3
; ============================================================================

;!align 255,0 ; 64*2 + 24*3 + 12*4= 248
.align 256

Table1:	; !fill 64,0
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
Table2: ; !fill 64,0
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00

TTB:	.byte $00,$80,$00,$80,$00,$80,$00,$80,$28,$A8,$28,$A8,$28,$A8,$28,$A8,$50,$D0,$50,$D0,$50,$D0,$50,$D0
TTH:	.byte $08,$08,$09,$09,$0A,$0A,$0B,$0B,$08,$08,$09,$09,$0A,$0A,$0B,$0B,$08,$08,$09,$09,$0A,$0A,$0B,$0B

Text1:	.byte "CODE & GFX  "
Text2:	.byte "      GROUIK"

Text3:	.byte "       MUSIC"
Text4:	.byte "CRAWDADDY   "

.align 256
;1align 255,0

SIN1: ; 256
.byte $2E,$30,$32,$34,$35,$36,$38,$3A,$3C,$3C,$3E,$40,$41,$42,$44,$45,$47,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$53,$54,$54
.byte $55,$55,$56,$57,$57,$58,$58,$57,$58,$58,$58,$58,$58,$58,$58,$58,$58,$57,$57,$57,$56,$56,$55,$54,$55,$54,$53,$52,$52,$51,$50,$4F
.byte $4E,$4E,$4D,$4C,$4B,$4B,$4A,$49,$48,$47,$46,$45,$45,$44,$42,$42,$41,$41,$3F,$3F,$3D,$3D,$3C,$3B,$3B,$39,$39,$39,$38,$38,$37,$36
.byte $36,$35,$35,$34,$34,$33,$32,$32,$32,$31,$31,$31,$30,$31,$30,$30,$30,$30,$2F,$2F,$30,$2F,$2F,$2F,$2F,$2F,$2F,$2F,$2E,$2F,$2F,$2F
.byte $2E,$2F,$2F,$2F,$2F,$2E,$2F,$2F,$2F,$2E,$2F,$2F,$2E,$2E,$2F,$2E,$2E,$2D,$2E,$2D,$2D,$2D,$2C,$2C,$2C,$2B,$2B,$2B,$2A,$2A,$29,$28
.byte $28,$27,$27,$26,$26,$25,$25,$23,$23,$22,$21,$21,$20,$1F,$1F,$1D,$1D,$1C,$1B,$1A,$19,$19,$17,$16,$16,$15,$14,$13,$13,$12,$11,$10
.byte $0F,$0F,$0E,$0D,$0C,$0C,$0B,$0A,$09,$09,$08,$08,$08,$07,$06,$07,$06,$06,$06,$06,$05,$06,$05,$05,$06,$05,$06,$06,$07,$07,$08,$08
.byte $09,$09,$0A,$0B,$0B,$0C,$0C,$0D,$0F,$0F,$10,$12,$12,$14,$15,$16,$17,$19,$1A,$1B,$1D,$1E,$20,$21,$22,$24,$26,$27,$28,$2A,$2C,$2E

SIN2: ; 256
.byte $2E,$33,$38,$3C,$40,$43,$47,$4B,$4E,$51,$54,$56,$59,$5A,$5C,$5D,$5D,$5E,$5E,$5D,$5C,$5A,$59,$57,$55,$53,$4F,$4C,$49,$46,$42,$3E
.byte $3A,$36,$32,$2E,$2A,$26,$23,$1F,$1C,$18,$15,$12,$10,$0E,$0C,$0A,$09,$08,$07,$07,$07,$07,$09,$0A,$0B,$0D,$0F,$11,$13,$16,$19,$1C
.byte $1F,$22,$26,$29,$2C,$2F,$32,$36,$38,$3B,$3E,$3F,$42,$44,$46,$47,$48,$49,$4B,$4B,$4B,$4A,$4A,$49,$49,$48,$46,$44,$43,$41,$3F,$3C
.byte $3A,$38,$35,$33,$30,$2E,$2C,$2A,$28,$26,$24,$22,$21,$20,$1F,$1F,$1E,$1E,$1D,$1D,$1E,$1E,$1F,$20,$21,$22,$24,$25,$27,$29,$2B,$2D
.byte $2E,$30,$33,$35,$37,$38,$3A,$3C,$3D,$3E,$3F,$3F,$40,$40,$41,$40,$40,$3F,$3F,$3E,$3D,$3B,$3A,$38,$36,$34,$31,$2F,$2D,$2B,$29,$25
.byte $23,$21,$1F,$1D,$1B,$19,$18,$16,$15,$14,$14,$13,$13,$13,$13,$14,$16,$17,$18,$1A,$1C,$1D,$20,$23,$26,$28,$2C,$2E,$32,$35,$38,$3B
.byte $3E,$41,$45,$48,$4B,$4C,$4F,$51,$53,$54,$55,$55,$57,$57,$57,$56,$55,$53,$52,$50,$4E,$4B,$49,$45,$42,$3F,$3B,$37,$34,$30,$2C,$27
.byte $23,$1F,$1C,$18,$14,$11,$0E,$0B,$09,$07,$05,$03,$02,$01,$00,$00,$01,$01,$02,$03,$05,$07,$0A,$0D,$10,$13,$17,$1A,$1E,$22,$26,$2A

SIN3: ; 256
.byte $26,$2C,$31,$35,$39,$3D,$40,$42,$44,$45,$45,$46,$45,$43,$42,$40,$3C,$3A,$38,$36,$33,$31,$30,$2F,$2F,$2E,$2F,$2F,$30,$33,$33,$36
.byte $37,$3A,$3C,$3C,$3E,$3E,$3D,$3D,$3B,$39,$36,$34,$30,$2B,$28,$23,$1D,$19,$14,$11,$0C,$09,$07,$04,$03,$03,$03,$03,$04,$07,$09,$0C
.byte $0F,$13,$16,$18,$1B,$1E,$20,$22,$22,$23,$24,$24,$23,$22,$21,$20,$1D,$1C,$1B,$1A,$19,$19,$19,$1A,$1C,$1E,$20,$23,$27,$2B,$2F,$33
.byte $37,$3D,$40,$44,$47,$4A,$4C,$4D,$4E,$4E,$4D,$4C,$4A,$47,$45,$41,$3C,$39,$35,$32,$2E,$2B,$28,$26,$25,$23,$23,$22,$22,$24,$24,$25
.byte $26,$29,$2A,$2A,$2B,$2C,$2B,$2B,$29,$28,$25,$23,$20,$1C,$19,$15,$10,$0D,$09,$07,$04,$02,$01,$00,$00,$00,$02,$03,$06,$0A,$0D,$11
.byte $15,$1B,$1F,$23,$27,$2B,$2D,$30,$32,$33,$34,$35,$35,$33,$33,$32,$30,$2E,$2D,$2C,$2B,$2A,$2A,$2A,$2B,$2C,$2E,$30,$32,$36,$38,$3B
.byte $3E,$42,$45,$47,$49,$4B,$4B,$4B,$4A,$49,$47,$45,$42,$3D,$3A,$35,$30,$2B,$26,$22,$1E,$1A,$17,$14,$13,$11,$10,$10,$10,$12,$12,$14
.byte $15,$18,$1A,$1B,$1D,$1E,$1F,$1F,$1F,$1F,$1E,$1D,$1B,$18,$16,$14,$10,$0E,$0C,$0B,$09,$08,$08,$09,$0A,$0C,$0E,$11,$14,$19,$1D,$22

SIN4: ; 256
.byte $40,$41,$43,$44,$46,$47,$49,$4A,$4C,$4D,$4F,$50,$52,$53,$55,$56,$58,$59,$5B,$5C,$5D,$5F,$60,$61,$63,$64,$65,$67,$68,$69,$6A,$6B
.byte $6C,$6D,$6F,$70,$71,$72,$73,$73,$74,$75,$76,$77,$78,$78,$79,$7A,$7A,$7B,$7B,$7C,$7C,$7D,$7D,$7D,$7E,$7E,$7E,$7F,$7F,$7F,$7F,$7F
.byte $7F,$7F,$7F,$7F,$7F,$7F,$7E,$7E,$7E,$7D,$7D,$7D,$7C,$7C,$7B,$7B,$7A,$7A,$79,$78,$78,$77,$76,$75,$74,$73,$73,$72,$71,$70,$6F,$6D
.byte $6C,$6B,$6A,$69,$68,$67,$65,$64,$63,$61,$60,$5F,$5D,$5C,$5B,$59,$58,$56,$55,$53,$52,$50,$4F,$4D,$4C,$4A,$49,$47,$46,$44,$43,$41
.byte $3F,$3E,$3C,$3B,$39,$38,$36,$35,$33,$32,$30,$2F,$2D,$2C,$2A,$29,$27,$26,$24,$23,$22,$20,$1F,$1E,$1C,$1B,$1A,$18,$17,$16,$15,$14
.byte $13,$12,$10,$0F,$0E,$0D,$0C,$0C,$0B,$0A,$09,$08,$07,$07,$06,$05,$05,$04,$04,$03,$03,$02,$02,$02,$01,$01,$01,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$04,$04,$05,$05,$06,$07,$07,$08,$09,$0A,$0B,$0C,$0C,$0D,$0E,$0F,$10,$12
.byte $13,$14,$15,$16,$17,$18,$1A,$1B,$1C,$1E,$1F,$20,$22,$23,$24,$26,$27,$29,$2A,$2C,$2D,$2F,$30,$32,$33,$35,$36,$38,$39,$3B,$3C,$3E

TCAR1: ; 256
.byte $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$cD,$cD,$cD,$cD,$cD,$cD,$cD,$cD
.byte $a3,$a3,$a3,$a3,$a3,$a3,$a3,$a3,$aA,$aA,$aA,$aA,$aA,$aA,$aA,$aA
.byte $c7,$c7,$c7,$c7,$c7,$c7,$c7,$c7,$cF,$cF,$cF,$cF,$cF,$cF,$cF,$cF
.byte $aB,$aB,$aB,$aB,$aB,$aB,$ab,$aB,$a9,$a9,$a9,$a9,$a9,$a9,$a9,$a9
.byte $a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a1,$a1,$a1,$a1,$a1,$a1,$a1,$a1
.byte $bD,$bD,$bD,$bD,$bD,$bd,$bD,$bD,$aD,$aD,$aD,$aD,$aD,$aD,$aD,$aD
.byte $bB,$bB,$bB,$bB,$bB,$bB,$bB,$bB,$bA,$bA,$bA,$bA,$bA,$bA,$bA,$bA
.byte $aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0

.byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE
.byte $bA,$bA,$bA,$bA,$bA,$bA,$bA,$bA,$bB,$bB,$bB,$bB,$bB,$bB,$bB,$bB
.byte $aD,$aD,$aD,$aD,$aD,$aD,$aD,$aD,$bD,$bD,$bD,$bD,$bD,$bd,$bD,$bD
.byte $a1,$a1,$a1,$a1,$a1,$a1,$a1,$a1,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
.byte $a9,$a9,$a9,$a9,$a9,$a9,$a9,$a9,$aB,$aB,$aB,$aB,$aB,$aB,$ab,$aB
.byte $cF,$cF,$cF,$cF,$cF,$cF,$cF,$cF,$c7,$c7,$c7,$c7,$c7,$c7,$c7,$c7
.byte $aA,$aA,$aA,$aA,$aA,$aA,$aA,$aA,$a3,$a3,$a3,$a3,$a3,$a3,$a3,$a3
.byte $cD,$cD,$cD,$cD,$cD,$cD,$cD,$cD,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0


TCAR2: ; 256
.byte $d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4
.byte $c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6
.byte $af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af
.byte $AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB
.byte $bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb
.byte $ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba
.byte $aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE
.byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
.byte $d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4,$d4
.byte $c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6
.byte $af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af,$af
.byte $AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB,$AB
.byte $bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb
.byte $ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba
.byte $aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE
.byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0

TLORES: ; 256
.byte $00,$00,$00,$00,$88,$88,$88,$88
.byte $55,$55,$55,$55,$99,$99,$99,$99
.byte $ff,$ff,$ff,$ff,$bb,$bb,$bb,$bb
.byte $33,$33,$33,$33,$22,$22,$22,$22
.byte $66,$66,$66,$66,$77,$77,$77,$77
.byte $44,$44,$44,$44,$cc,$cc,$cc,$cc
.byte $ee,$ee,$ee,$ee,$dd,$dd,$dd,$dd
.byte $99,$99,$99,$99,$11,$11,$11,$11
.byte $00,$00,$00,$00,$88,$88,$88,$88
.byte $55,$55,$55,$55,$99,$99,$99,$99
.byte $ff,$ff,$ff,$ff,$bb,$bb,$bb,$bb
.byte $33,$33,$33,$33,$22,$22,$22,$22
.byte $66,$66,$66,$66,$77,$77,$77,$77
.byte $44,$44,$44,$44,$cc,$cc,$cc,$cc
.byte $ee,$ee,$ee,$ee,$dd,$dd,$dd,$dd
.byte $99,$99,$99,$99,$11,$11,$11,$11
.byte $00,$00,$00,$00,$88,$88,$88,$88
.byte $55,$55,$55,$55,$99,$99,$99,$99
.byte $ff,$ff,$ff,$ff,$bb,$bb,$bb,$bb
.byte $33,$33,$33,$33,$22,$22,$22,$22
.byte $66,$66,$66,$66,$77,$77,$77,$77
.byte $44,$44,$44,$44,$cc,$cc,$cc,$cc
.byte $ee,$ee,$ee,$ee,$dd,$dd,$dd,$dd
.byte $99,$99,$99,$99,$11,$11,$11,$11
.byte $00,$00,$00,$00,$88,$88,$88,$88
.byte $55,$55,$55,$55,$99,$99,$99,$99
.byte $ff,$ff,$ff,$ff,$bb,$bb,$bb,$bb
.byte $33,$33,$33,$33,$22,$22,$22,$22
.byte $66,$66,$66,$66,$77,$77,$77,$77
.byte $44,$44,$44,$44,$cc,$cc,$cc,$cc
.byte $ee,$ee,$ee,$ee,$dd,$dd,$dd,$dd
.byte $99,$99,$99,$99,$11,$11,$11,$11

TLORES2: ; 256
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88
.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22
.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb,$bb
.byte $33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22
.byte $66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77,$77
.byte $44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc,$cc
.byte $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
.byte $99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$99,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11

TCAR3: ; 256
.byte $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
.byte $C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7
.byte $CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF
.byte $EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF
.byte $BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB
.byte $ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba
.byte $aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE
.byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
.byte $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
.byte $C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7
.byte $CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF
.byte $EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF,$EF
.byte $BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB
.byte $ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba,$ba
.byte $aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE,$aE
.byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0

; (5*24) = 120
MaskP:
.byte $ff, $ff, $ff, $ff, $e0, $ff, $ff, $ff, $ff, $f8, $ff, $ff, $ff, $ff, $fc, $ff, $ff, $ff, $ff, $fe, $ff, $ff, $ff, $ff, $fe, $ff, $ff, $ff, $ff, $ff, $7, $ff, $80, $3f, $ff, $7, $ff, $80, $3f, $fe, $7, $ff, $ff, $ff, $fe, $7, $ff, $ff, $ff, $fc, $7, $ff, $ff, $ff, $fc, $7, $ff, $ff, $ff, $f8, $7, $ff, $ff, $ff, $e0, $7, $ff, $ff, $ff, $c0, $7, $ff, $ff, $ff, $0, $7, $ff, $80, $0, $0, $7, $ff, $80, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0
MaskL:
.byte $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $ff, $ff, $fe, $0, $0, $7, $ff, $c0, $0, $0, $7, $ff, $c0, $0, $0, $7, $ff, $c0, $0, $0, $7, $ff, $c0, $0, $0, $7, $ff, $c0, $0, $0, $7, $ff, $c0, $0, $0, $7, $ff, $c0, $3, $ff, $7, $ff, $c0, $3, $ff, $7, $ff, $c0, $3, $ff, $7, $ff, $c0, $3, $ff, $7, $ff, $c0, $3, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff


;!align 255,0
.align 256
MaskA:
.byte $ff,$ff,$ff,$ff,$ff,$ff,$f8,$0
.byte $3f,$ff,$ff,$f8,$00,$3f,$ff,$ff
.byte $f0,$00,$1f,$ff,$ff,$f0,$00,$1f
.byte $ff,$ff,$e0,$00,$0f,$ff,$ff,$e0
.byte $00,$0f,$ff,$ff,$c0,$80,$07,$ff
.byte $ff,$c1,$80,$07,$ff,$ff,$81,$c0
.byte $03,$ff,$ff,$83,$c0,$03,$ff,$ff
.byte $03,$e0,$01,$ff,$ff,$00,$00,$01
.byte $ff,$fe,$00,$00,$00,$ff,$fe,$07
.byte $f8,$00,$ff,$fc,$0f,$f8,$00,$7f
.byte $fc,$0f,$fc,$00,$7f,$f8,$1f,$fc
.byte $00,$3f,$80,$00,$c0,$00,$01,$80
.byte $00,$c0,$00,$01,$80,$00,$c0,$00
.byte $01,$80,$00,$c0,$00,$01,$80,$00
.byte $c0,$00,$01,$ff,$ff,$ff,$ff,$ff
MaskS:
.byte $0, $1f, $ff, $87, $fc, $7, $ff
.byte $ff, $cf, $fc, $f, $ff, $ff, $ff
.byte $fc, $3f, $ff, $ff, $ff, $fc, $7f
.byte $ff, $ff, $ff, $fc, $ff, $ff, $ff
.byte $ff, $fc, $ff, $fc, $0, $f, $fc
.byte $ff, $ff, $ff, $e0, $7c, $ff, $ff
.byte $ff, $ff, $0, $ff, $ff, $ff, $ff
.byte $f8, $ff, $ff, $ff, $ff, $fc, $7f
.byte $ff, $ff, $ff, $fe, $1f, $ff, $ff
.byte $ff, $fe, $7, $ff, $ff, $ff, $fe
.byte $0, $1f, $ff, $ff, $ff, $7f, $c3
.byte $ff, $ff, $ff, $ff, $e0, $0, $3f
.byte $fe, $ff, $f0, $0, $3f, $fe, $ff
.byte $ff, $ff, $ff, $fc, $ff, $ff, $ff
.byte $ff, $fc, $ff, $ff, $ff, $ff, $f0
.byte $ff, $ff, $ff, $ff, $c0, $ff, $cf
.byte $ff, $fe, $0, $7f, $c0, $ff, $e0, $0

;!align 255,0

.align 256
MaskM:
.byte $ff, $ff, $c1, $ff, $ff, $ff, $ff, $e3, $ff, $ff, $ff, $ff, $f7, $ff, $ff
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
.byte $f, $ff, $ff, $ff, $f0, $f, $ff, $ff, $ff, $f0, $f, $ff, $ff, $ff, $f0
.byte $f, $df, $ff, $bf, $f0, $f, $df, $ff, $bf, $f0, $f, $df, $ff, $3f, $f0
.byte $f, $cf, $ff, $3f, $f0, $f, $cf, $fe, $3f, $f0, $f, $c7, $fe, $3f, $f0
.byte $f, $c7, $fc, $3f, $f0, $f, $c3, $fc, $3f, $f0, $ff, $ff, $fb, $ff, $ff
.byte $ff, $ff, $fb, $ff, $ff, $ff, $fd, $f3, $ff, $ff, $ff, $fd, $f3, $ff
.byte $ff, $ff, $fc, $e3, $ff, $ff, $ff, $fc, $e3, $ff, $ff, $ff, $fc, $e3
.byte $ff, $ff
MaskG:
.byte $0, $3f, $fc, $3f, $e0, $0, $ff, $ff, $bf, $e0, $7, $ff, $ff, $ff, $e0
.byte $1f, $ff, $ff, $ff, $e0, $3f, $ff, $ff, $ff, $e0, $7f, $ff, $ff, $ff
.byte $e0, $7f, $ff, $ff, $ff, $e0, $ff, $ff, $0, $ff, $e0, $ff, $fc, $0, $7f
.byte $e0, $ff, $f8, $0, $0, $0, $ff, $f8, $7f, $ff, $ff, $ff, $f8, $7f, $ff
.byte $ff, $ff, $f8, $7f, $ff, $ff, $ff, $f8, $7f, $ff, $ff, $ff, $f8, $7f
.byte $ff, $ff, $ff, $fc, $7f, $ff, $ff, $ff, $ff, $7, $ff, $e0, $7f, $ff
.byte $ff, $ff, $e0, $7f, $ff, $ff, $ff, $e0, $3f, $ff, $ff, $ff, $e0, $f
.byte $ff, $ff, $ff, $e0, $3, $ff, $ff, $ff, $e0, $0, $7f, $ff, $3f, $e0
.byte $0, $1f, $fc, $1f, $e0

;!align 255,0
.align 256
MaskO:
.byte $0, $3f, $ff, $fe, $0, $3, $ff, $ff, $ff, $c0, $f, $ff, $ff, $ff, $f0
.byte $1f, $ff, $ff, $ff, $f8, $3f, $ff, $ff, $ff, $fc, $7f, $ff, $ff, $ff
.byte $fc, $7f, $ff, $1, $ff, $fe, $ff, $fe, $0, $ff, $fe, $ff, $fe, $0, $7f
.byte $ff, $ff, $fc, $0, $7f, $ff, $ff, $fc, $0, $3f, $ff, $ff, $fc, $0, $3f
.byte $ff, $ff, $fc, $0, $3f, $ff, $ff, $fe, $0, $7f, $fe, $ff, $fe, $0, $ff, $fe, $7f, $ff, $81, $ff, $fc, $7f, $ff, $e3, $ff, $fc, $3f, $ff, $ff, $ff, $f8, $1f, $ff, $ff, $ff, $f0, $f, $ff, $ff, $ff, $e0, $3, $ff, $ff, $ff, $c0, $0, $ff, $ff, $ff, $0, $0, $1f, $ff, $f8, $0, $0, $0, $ff, $80, $0
MaskR:
.byte $ff, $ff, $ff, $ff, $0, $ff, $ff, $ff, $ff, $80, $ff, $ff, $ff, $ff
.byte $c0, $ff, $ff, $ff, $ff, $c0, $ff, $ff, $ff, $ff, $e0, $ff, $ff, $ff
.byte $ff, $e0, $f, $fe, $1, $ff, $e0, $f, $fe, $1, $ff, $e0, $f, $fe, $1
.byte $ff, $c0, $f, $ff, $ff, $ff, $c0, $f, $ff, $ff, $ff, $80, $f, $ff
.byte $ff, $fe, $0, $f, $ff, $ff, $ff, $0, $f, $ff, $ff, $ff, $8f, $f, $ff, $ff, $ff, $cf, $f, $fe, $3, $ff, $cf, $f, $fe, $3, $ff, $ff, $ff, $ff, $f3, $ff, $ff, $ff, $ff, $f1, $ff, $fe, $ff, $ff, $f1, $ff, $fe, $ff, $ff, $f1, $ff, $fc, $ff, $ff, $f1, $ff, $fc, $ff, $ff, $f0, $ff, $f8, $ff, $ff, $f0, $3f, $e0

;!align 255,0
.align 256
MaskI:
.byte $0, $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0, $0
.byte $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0, $0, $3, $ff, $c0, $0, $0, $3
.byte $ff, $c0, $0, $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0, $0, $0, $3, $ff
.byte $c0, $0, $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0
.byte $0, $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0, $0
.byte $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0, $0, $0, $3, $ff, $c0, $0, $0
.byte $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0, $0, $7f, $ff, $fe, $0
MaskCred:
.byte $ff, $ff, $ef, $ff, $ff, $ff, $ff, $ef, $ff, $ff, $ff, $ff, $ef, $ff
.byte $ff, $ff, $ff, $ef, $ff, $ff, $ff, $ff, $ef, $ff, $ff, $ff, $ff, $ef
.byte $ff, $ff, $ff, $ff, $ef, $ff, $ff, $ff, $ff, $ef, $ff, $ff, $ff, $ff
.byte $ef, $ff, $ff, $ff, $80, $0, $ff, $f0, $ff, $ff, $e0, $ff, $f0, $ff
.byte $ff, $e0, $ff, $f0, $ff, $ff, $e0, $ff, $f0, $ff, $ff, $e0, $ff, $f0
.byte $ff, $ff, $e0, $ff, $f0, $ff, $ff, $e0, $ff, $f0, $ff, $ff, $e0, $ff
.byte $f0, $ff, $ff, $e0, $ff, $f0, $ff, $c0, $0, $ff, $f0, $ff, $c0, $0
.byte  $ff, $f0, $ff, $c0, $0, $ff, $f0, $ff, $c0, $0, $ff, $f0, $ff, $c0
.byte $0, $ff, $f0, $ff, $c0, $0, $ff, $f0

;!align 255,0
.align 256
TableIndexMaskB:
.byte <MaskA,<MaskI,<MaskR,<MaskO,<MaskG,<MaskA,<MaskM,<MaskS,<MaskA,<MaskL,<MaskP
TableIndexMaskH:
.byte >MaskA,>MaskI,>MaskR,>MaskO,>MaskG,>MaskA,>MaskM,>MaskS,>MaskA,>MaskL,>MaskP


; =============================================================================

DUMP:

    ; $800->$400

	LDA $800
     sta $400
     LDA $801
     sta $401
     LDA $802
     sta $402
     LDA $803
     sta $403
     LDA $804
     sta $404
     LDA $805
     sta $405
     LDA $806
     sta $406
     LDA $807
     sta $407
     LDA $808
     sta $408
     LDA $809
     sta $409
     LDA $80a
     sta $40a
     LDA $80b
     sta $40b
     LDA $80c
     sta $40c
     LDA $80d
     sta $40d
     LDA $80e
     sta $40e
     LDA $80f
     sta $40f
     LDA $810
     sta $410
     LDA $811
     sta $411
     LDA $812
     sta $412
     LDA $813
     sta $413
     LDA $814
     sta $414
     LDA $815
     sta $415
     LDA $816
     sta $416
     LDA $817
     sta $417
     LDA $818
     sta $418
     LDA $819
     sta $419
     LDA $81a
     sta $41a
     LDA $81b
     sta $41b
     LDA $81c
     sta $41c
     LDA $81d
     sta $41d
     LDA $81e
     sta $41e
     LDA $81f
     sta $41f
     LDA $820
     sta $420
     LDA $821
     sta $421
     LDA $822
     sta $422
     LDA $823
     sta $423
     LDA $824
     sta $424
     LDA $825
     sta $425
     LDA $826
     sta $426
     LDA $827
     sta $427
     LDA $880
     sta $480
     LDA $881
     sta $481
     LDA $882
     sta $482
     LDA $883
     sta $483
     LDA $884
     sta $484
     LDA $885
     sta $485
     LDA $886
     sta $486
     LDA $887
     sta $487
     LDA $888
     sta $488
     LDA $889
     sta $489
     LDA $88a
     sta $48a
     LDA $88b
     sta $48b
     LDA $88c
     sta $48c
     LDA $88d
     sta $48d
     LDA $88e
     sta $48e
     LDA $88f
     sta $48f
     LDA $890
     sta $490
     LDA $891
     sta $491
     LDA $892
     sta $492
     LDA $893
     sta $493
     LDA $894
     sta $494
     LDA $895
     sta $495
     LDA $896
     sta $496
     LDA $897
     sta $497
     LDA $898
     sta $498
     LDA $899
     sta $499
     LDA $89a
     sta $49a
     LDA $89b
     sta $49b
     LDA $89c
     sta $49c
     LDA $89d
     sta $49d
     LDA $89e
     sta $49e
     LDA $89f
     sta $49f
     LDA $8a0
     sta $4a0
     LDA $8a1
     sta $4a1
     LDA $8a2
     sta $4a2
     LDA $8a3
     sta $4a3
     LDA $8a4
     sta $4a4
     LDA $8a5
     sta $4a5
     LDA $8a6
     sta $4a6
     LDA $8a7
     sta $4a7
     LDA $900
     sta $500
     LDA $901
     sta $501
     LDA $902
     sta $502
     LDA $903
     sta $503
     LDA $904
     sta $504
     LDA $905
     sta $505
     LDA $906
     sta $506
     LDA $907
     sta $507
     LDA $908
     sta $508
     LDA $909
     sta $509
     LDA $90a
     sta $50a
     LDA $90b
     sta $50b
     LDA $90c
     sta $50c
     LDA $90d
     sta $50d
     LDA $90e
     sta $50e
     LDA $90f
     sta $50f
     LDA $910
     sta $510
     LDA $911
     sta $511
     LDA $912
     sta $512
     LDA $913
     sta $513
     LDA $914
     sta $514
     LDA $915
     sta $515
     LDA $916
     sta $516
     LDA $917
     sta $517
     LDA $918
     sta $518
     LDA $919
     sta $519
     LDA $91a
     sta $51a
     LDA $91b
     sta $51b
     LDA $91c
     sta $51c
     LDA $91d
     sta $51d
     LDA $91e
     sta $51e
     LDA $91f
     sta $51f
     LDA $920
     sta $520
     LDA $921
     sta $521
     LDA $922
     sta $522
     LDA $923
     sta $523
     LDA $924
     sta $524
     LDA $925
     sta $525
     LDA $926
     sta $526
     LDA $927
     sta $527
     LDA $980
     sta $580
     LDA $981
     sta $581
     LDA $982
     sta $582
     LDA $983
     sta $583
     LDA $984
     sta $584
     LDA $985
     sta $585
     LDA $986
     sta $586
     LDA $987
     sta $587
     LDA $988
     sta $588
     LDA $989
     sta $589
     LDA $98a
     sta $58a
     LDA $98b
     sta $58b
     LDA $98c
     sta $58c
     LDA $98d
     sta $58d
     LDA $98e
     sta $58e
     LDA $98f
     sta $58f
     LDA $990
     sta $590
     LDA $991
     sta $591
     LDA $992
     sta $592
     LDA $993
     sta $593
     LDA $994
     sta $594
     LDA $995
     sta $595
     LDA $996
     sta $596
     LDA $997
     sta $597
     LDA $998
     sta $598
     LDA $999
     sta $599
     LDA $99a
     sta $59a
     LDA $99b
     sta $59b
     LDA $99c
     sta $59c
     LDA $99d
     sta $59d
     LDA $99e
     sta $59e
     LDA $99f
     sta $59f
     LDA $9a0
     sta $5a0
     LDA $9a1
     sta $5a1
     LDA $9a2
     sta $5a2
     LDA $9a3
     sta $5a3
     LDA $9a4
     sta $5a4
     LDA $9a5
     sta $5a5
     LDA $9a6
     sta $5a6
     LDA $9a7
     sta $5a7
     LDA $a00
     sta $600
     LDA $a01
     sta $601
     LDA $a02
     sta $602
     LDA $a03
     sta $603
     LDA $a04
     sta $604
     LDA $a05
     sta $605
     LDA $a06
     sta $606
     LDA $a07
     sta $607
     LDA $a08
     sta $608
     LDA $a09
     sta $609
     LDA $a0a
     sta $60a
     LDA $a0b
     sta $60b
     LDA $a0c
     sta $60c
     LDA $a0d
     sta $60d
     LDA $a0e
     sta $60e
     LDA $a0f
     sta $60f
     LDA $a10
     sta $610
     LDA $a11
     sta $611
     LDA $a12
     sta $612
     LDA $a13
     sta $613
     LDA $a14
     sta $614
     LDA $a15
     sta $615
     LDA $a16
     sta $616
     LDA $a17
     sta $617
     LDA $a18
     sta $618
     LDA $a19
     sta $619
     LDA $a1a
     sta $61a
     LDA $a1b
     sta $61b
     LDA $a1c
     sta $61c
     LDA $a1d
     sta $61d
     LDA $a1e
     sta $61e
     LDA $a1f
     sta $61f
     LDA $a20
     sta $620
     LDA $a21
     sta $621
     LDA $a22
     sta $622
     LDA $a23
     sta $623
     LDA $a24
     sta $624
     LDA $a25
     sta $625
     LDA $a26
     sta $626
     LDA $a27
     sta $627
     LDA $a80
     sta $680
     LDA $a81
     sta $681
     LDA $a82
     sta $682
     LDA $a83
     sta $683
     LDA $a84
     sta $684
     LDA $a85
     sta $685
     LDA $a86
     sta $686
     LDA $a87
     sta $687
     LDA $a88
     sta $688
     LDA $a89
     sta $689
     LDA $a8a
     sta $68a
     LDA $a8b
     sta $68b
     LDA $a8c
     sta $68c
     LDA $a8d
     sta $68d
     LDA $a8e
     sta $68e
     LDA $a8f
     sta $68f
     LDA $a90
     sta $690
     LDA $a91
     sta $691
     LDA $a92
     sta $692
     LDA $a93
     sta $693
     LDA $a94
     sta $694
     LDA $a95
     sta $695
     LDA $a96
     sta $696
     LDA $a97
     sta $697
     LDA $a98
     sta $698
     LDA $a99
     sta $699
     LDA $a9a
     sta $69a
     LDA $a9b
     sta $69b
     LDA $a9c
     sta $69c
     LDA $a9d
     sta $69d
     LDA $a9e
     sta $69e
     LDA $a9f
     sta $69f
     LDA $aa0
     sta $6a0
     LDA $aa1
     sta $6a1
     LDA $aa2
     sta $6a2
     LDA $aa3
     sta $6a3
     LDA $aa4
     sta $6a4
     LDA $aa5
     sta $6a5
     LDA $aa6
     sta $6a6
     LDA $aa7
     sta $6a7
     LDA $b00
     sta $700
     LDA $b01
     sta $701
     LDA $b02
     sta $702
     LDA $b03
     sta $703
     LDA $b04
     sta $704
     LDA $b05
     sta $705
     LDA $b06
     sta $706
     LDA $b07
     sta $707
     LDA $b08
     sta $708
     LDA $b09
     sta $709
     LDA $b0a
     sta $70a
     LDA $b0b
     sta $70b
     LDA $b0c
     sta $70c
     LDA $b0d
     sta $70d
     LDA $b0e
     sta $70e
     LDA $b0f
     sta $70f
     LDA $b10
     sta $710
     LDA $b11
     sta $711
     LDA $b12
     sta $712
     LDA $b13
     sta $713
     LDA $b14
     sta $714
     LDA $b15
     sta $715
     LDA $b16
     sta $716
     LDA $b17
     sta $717
     LDA $b18
     sta $718
     LDA $b19
     sta $719
     LDA $b1a
     sta $71a
     LDA $b1b
     sta $71b
     LDA $b1c
     sta $71c
     LDA $b1d
     sta $71d
     LDA $b1e
     sta $71e
     LDA $b1f
     sta $71f
     LDA $b20
     sta $720
     LDA $b21
     sta $721
     LDA $b22
     sta $722
     LDA $b23
     sta $723
     LDA $b24
     sta $724
     LDA $b25
     sta $725
     LDA $b26
     sta $726
     LDA $b27
     sta $727
     LDA $b80
     sta $780
     LDA $b81
     sta $781
     LDA $b82
     sta $782
     LDA $b83
     sta $783
     LDA $b84
     sta $784
     LDA $b85
     sta $785
     LDA $b86
     sta $786
     LDA $b87
     sta $787
     LDA $b88
     sta $788
     LDA $b89
     sta $789
     LDA $b8a
     sta $78a
     LDA $b8b
     sta $78b
     LDA $b8c
     sta $78c
     LDA $b8d
     sta $78d
     LDA $b8e
     sta $78e
     LDA $b8f
     sta $78f
     LDA $b90
     sta $790
     LDA $b91
     sta $791
     LDA $b92
     sta $792
     LDA $b93
     sta $793
     LDA $b94
     sta $794
     LDA $b95
     sta $795
     LDA $b96
     sta $796
     LDA $b97
     sta $797
     LDA $b98
     sta $798
     LDA $b99
     sta $799
     LDA $b9a
     sta $79a
     LDA $b9b
     sta $79b
     LDA $b9c
     sta $79c
     LDA $b9d
     sta $79d
     LDA $b9e
     sta $79e
     LDA $b9f
     sta $79f
     LDA $ba0
     sta $7a0
     LDA $ba1
     sta $7a1
     LDA $ba2
     sta $7a2
     LDA $ba3
     sta $7a3
     LDA $ba4
     sta $7a4
     LDA $ba5
     sta $7a5
     LDA $ba6
     sta $7a6
     LDA $ba7
     sta $7a7
     LDA $828
     sta $428
     LDA $829
     sta $429
     LDA $82a
     sta $42a
     LDA $82b
     sta $42b
     LDA $82c
     sta $42c
     LDA $82d
     sta $42d
     LDA $82e
     sta $42e
     LDA $82f
     sta $42f
     LDA $830
     sta $430
     LDA $831
     sta $431
     LDA $832
     sta $432
     LDA $833
     sta $433
     LDA $834
     sta $434
     LDA $835
     sta $435
     LDA $836
     sta $436
     LDA $837
     sta $437
     LDA $838
     sta $438
     LDA $839
     sta $439
     LDA $83a
     sta $43a
     LDA $83b
     sta $43b
     LDA $83c
     sta $43c
     LDA $83d
     sta $43d
     LDA $83e
     sta $43e
     LDA $83f
     sta $43f
     LDA $840
     sta $440
     LDA $841
     sta $441
     LDA $842
     sta $442
     LDA $843
     sta $443
     LDA $844
     sta $444
     LDA $845
     sta $445
     LDA $846
     sta $446
     LDA $847
     sta $447
     LDA $848
     sta $448
     LDA $849
     sta $449
     LDA $84a
     sta $44a
     LDA $84b
     sta $44b
     LDA $84c
     sta $44c
     LDA $84d
     sta $44d
     LDA $84e
     sta $44e
     LDA $84f
     sta $44f
     LDA $8a8
     sta $4a8
     LDA $8a9
     sta $4a9
     LDA $8aa
     sta $4aa
     LDA $8ab
     sta $4ab
     LDA $8ac
     sta $4ac
     LDA $8ad
     sta $4ad
     LDA $8ae
     sta $4ae
     LDA $8af
     sta $4af
     LDA $8b0
     sta $4b0
     LDA $8b1
     sta $4b1
     LDA $8b2
     sta $4b2
     LDA $8b3
     sta $4b3
     LDA $8b4
     sta $4b4
     LDA $8b5
     sta $4b5
     LDA $8b6
     sta $4b6
     LDA $8b7
     sta $4b7
     LDA $8b8
     sta $4b8
     LDA $8b9
     sta $4b9
     LDA $8ba
     sta $4ba
     LDA $8bb
     sta $4bb
     LDA $8bc
     sta $4bc
     LDA $8bd
     sta $4bd
     LDA $8be
     sta $4be
     LDA $8bf
     sta $4bf
     LDA $8c0
     sta $4c0
     LDA $8c1
     sta $4c1
     LDA $8c2
     sta $4c2
     LDA $8c3
     sta $4c3
     LDA $8c4
     sta $4c4
     LDA $8c5
     sta $4c5
     LDA $8c6
     sta $4c6
     LDA $8c7
     sta $4c7
     LDA $8c8
     sta $4c8
     LDA $8c9
     sta $4c9
     LDA $8ca
     sta $4ca
     LDA $8cb
     sta $4cb
     LDA $8cc
     sta $4cc
     LDA $8cd
     sta $4cd
     LDA $8ce
     sta $4ce
     LDA $8cf
     sta $4cf
     LDA $928
     sta $528
     LDA $929
     sta $529
     LDA $92a
     sta $52a
     LDA $92b
     sta $52b
     LDA $92c
     sta $52c
     LDA $92d
     sta $52d
     LDA $92e
     sta $52e
     LDA $92f
     sta $52f
     LDA $930
     sta $530
     LDA $931
     sta $531
     LDA $932
     sta $532
     LDA $933
     sta $533
     LDA $934
     sta $534
     LDA $935
     sta $535
     LDA $936
     sta $536
     LDA $937
     sta $537
     LDA $938
     sta $538
     LDA $939
     sta $539
     LDA $93a
     sta $53a
     LDA $93b
     sta $53b
     LDA $93c
     sta $53c
     LDA $93d
     sta $53d
     LDA $93e
     sta $53e
     LDA $93f
     sta $53f
     LDA $940
     sta $540
     LDA $941
     sta $541
     LDA $942
     sta $542
     LDA $943
     sta $543
     LDA $944
     sta $544
     LDA $945
     sta $545
     LDA $946
     sta $546
     LDA $947
     sta $547
     LDA $948
     sta $548
     LDA $949
     sta $549
     LDA $94a
     sta $54a
     LDA $94b
     sta $54b
     LDA $94c
     sta $54c
     LDA $94d
     sta $54d
     LDA $94e
     sta $54e
     LDA $94f
     sta $54f
     LDA $9a8
     sta $5a8
     LDA $9a9
     sta $5a9
     LDA $9aa
     sta $5aa
     LDA $9ab
     sta $5ab
     LDA $9ac
     sta $5ac
     LDA $9ad
     sta $5ad
     LDA $9ae
     sta $5ae
     LDA $9af
     sta $5af
     LDA $9b0
     sta $5b0
     LDA $9b1
     sta $5b1
     LDA $9b2
     sta $5b2
     LDA $9b3
     sta $5b3
     LDA $9b4
     sta $5b4
     LDA $9b5
     sta $5b5
     LDA $9b6
     sta $5b6
     LDA $9b7
     sta $5b7
     LDA $9b8
     sta $5b8
     LDA $9b9
     sta $5b9
     LDA $9ba
     sta $5ba
     LDA $9bb
     sta $5bb
     LDA $9bc
     sta $5bc
     LDA $9bd
     sta $5bd
     LDA $9be
     sta $5be
     LDA $9bf
     sta $5bf
     LDA $9c0
     sta $5c0
     LDA $9c1
     sta $5c1
     LDA $9c2
     sta $5c2
     LDA $9c3
     sta $5c3
     LDA $9c4
     sta $5c4
     LDA $9c5
     sta $5c5
     LDA $9c6
     sta $5c6
     LDA $9c7
     sta $5c7
     LDA $9c8
     sta $5c8
     LDA $9c9
     sta $5c9
     LDA $9ca
     sta $5ca
     LDA $9cb
     sta $5cb
     LDA $9cc
     sta $5cc
     LDA $9cd
     sta $5cd
     LDA $9ce
     sta $5ce
     LDA $9cf
     sta $5cf
     LDA $a28
     sta $628
     LDA $a29
     sta $629
     LDA $a2a
     sta $62a
     LDA $a2b
     sta $62b
     LDA $a2c
     sta $62c
     LDA $a2d
     sta $62d
     LDA $a2e
     sta $62e
     LDA $a2f
     sta $62f
     LDA $a30
     sta $630
     LDA $a31
     sta $631
     LDA $a32
     sta $632
     LDA $a33
     sta $633
     LDA $a34
     sta $634
     LDA $a35
     sta $635
     LDA $a36
     sta $636
     LDA $a37
     sta $637
     LDA $a38
     sta $638
     LDA $a39
     sta $639
     LDA $a3a
     sta $63a
     LDA $a3b
     sta $63b
     LDA $a3c
     sta $63c
     LDA $a3d
     sta $63d
     LDA $a3e
     sta $63e
     LDA $a3f
     sta $63f
     LDA $a40
     sta $640
     LDA $a41
     sta $641
     LDA $a42
     sta $642
     LDA $a43
     sta $643
     LDA $a44
     sta $644
     LDA $a45
     sta $645
     LDA $a46
     sta $646
     LDA $a47
     sta $647
     LDA $a48
     sta $648
     LDA $a49
     sta $649
     LDA $a4a
     sta $64a
     LDA $a4b
     sta $64b
     LDA $a4c
     sta $64c
     LDA $a4d
     sta $64d
     LDA $a4e
     sta $64e
     LDA $a4f
     sta $64f
     LDA $aa8
     sta $6a8
     LDA $aa9
     sta $6a9
     LDA $aaa
     sta $6aa
     LDA $aab
     sta $6ab
     LDA $aac
     sta $6ac
     LDA $aad
     sta $6ad
     LDA $aae
     sta $6ae
     LDA $aaf
     sta $6af
     LDA $ab0
     sta $6b0
     LDA $ab1
     sta $6b1
     LDA $ab2
     sta $6b2
     LDA $ab3
     sta $6b3
     LDA $ab4
     sta $6b4
     LDA $ab5
     sta $6b5
     LDA $ab6
     sta $6b6
     LDA $ab7
     sta $6b7
     LDA $ab8
     sta $6b8
     LDA $ab9
     sta $6b9
     LDA $aba
     sta $6ba
     LDA $abb
     sta $6bb
     LDA $abc
     sta $6bc
     LDA $abd
     sta $6bd
     LDA $abe
     sta $6be
     LDA $abf
     sta $6bf
     LDA $ac0
     sta $6c0
     LDA $ac1
     sta $6c1
     LDA $ac2
     sta $6c2
     LDA $ac3
     sta $6c3
     LDA $ac4
     sta $6c4
     LDA $ac5
     sta $6c5
     LDA $ac6
     sta $6c6
     LDA $ac7
     sta $6c7
     LDA $ac8
     sta $6c8
     LDA $ac9
     sta $6c9
     LDA $aca
     sta $6ca
     LDA $acb
     sta $6cb
     LDA $acc
     sta $6cc
     LDA $acd
     sta $6cd
     LDA $ace
     sta $6ce
     LDA $acf
     sta $6cf
     LDA $b28
     sta $728
     LDA $b29
     sta $729
     LDA $b2a
     sta $72a
     LDA $b2b
     sta $72b
     LDA $b2c
     sta $72c
     LDA $b2d
     sta $72d
     LDA $b2e
     sta $72e
     LDA $b2f
     sta $72f
     LDA $b30
     sta $730
     LDA $b31
     sta $731
     LDA $b32
     sta $732
     LDA $b33
     sta $733
     LDA $b34
     sta $734
     LDA $b35
     sta $735
     LDA $b36
     sta $736
     LDA $b37
     sta $737
     LDA $b38
     sta $738
     LDA $b39
     sta $739
     LDA $b3a
     sta $73a
     LDA $b3b
     sta $73b
     LDA $b3c
     sta $73c
     LDA $b3d
     sta $73d
     LDA $b3e
     sta $73e
     LDA $b3f
     sta $73f
     LDA $b40
     sta $740
     LDA $b41
     sta $741
     LDA $b42
     sta $742
     LDA $b43
     sta $743
     LDA $b44
     sta $744
     LDA $b45
     sta $745
     LDA $b46
     sta $746
     LDA $b47
     sta $747
     LDA $b48
     sta $748
     LDA $b49
     sta $749
     LDA $b4a
     sta $74a
     LDA $b4b
     sta $74b
     LDA $b4c
     sta $74c
     LDA $b4d
     sta $74d
     LDA $b4e
     sta $74e
     LDA $b4f
     sta $74f
     LDA $ba8
     sta $7a8
     LDA $ba9
     sta $7a9
     LDA $baa
     sta $7aa
     LDA $bab
     sta $7ab
     LDA $bac
     sta $7ac
     LDA $bad
     sta $7ad
     LDA $bae
     sta $7ae
     LDA $baf
     sta $7af
     LDA $bb0
     sta $7b0
     LDA $bb1
     sta $7b1
     LDA $bb2
     sta $7b2
     LDA $bb3
     sta $7b3
     LDA $bb4
     sta $7b4
     LDA $bb5
     sta $7b5
     LDA $bb6
     sta $7b6
     LDA $bb7
     sta $7b7
     LDA $bb8
     sta $7b8
     LDA $bb9
     sta $7b9
     LDA $bba
     sta $7ba
     LDA $bbb
     sta $7bb
     LDA $bbc
     sta $7bc
     LDA $bbd
     sta $7bd
     LDA $bbe
     sta $7be
     LDA $bbf
     sta $7bf
     LDA $bc0
     sta $7c0
     LDA $bc1
     sta $7c1
     LDA $bc2
     sta $7c2
     LDA $bc3
     sta $7c3
     LDA $bc4
     sta $7c4
     LDA $bc5
     sta $7c5
     LDA $bc6
     sta $7c6
     LDA $bc7
     sta $7c7
     LDA $bc8
     sta $7c8
     LDA $bc9
     sta $7c9
     LDA $bca
     sta $7ca
     LDA $bcb
     sta $7cb
     LDA $bcc
     sta $7cc
     LDA $bcd
     sta $7cd
     LDA $bce
     sta $7ce
     LDA $bcf
     sta $7cf
     LDA $850
     sta $450
     LDA $851
     sta $451
     LDA $852
     sta $452
     LDA $853
     sta $453
     LDA $854
     sta $454
     LDA $855
     sta $455
     LDA $856
     sta $456
     LDA $857
     sta $457
     LDA $858
     sta $458
     LDA $859
     sta $459
     LDA $85a
     sta $45a
     LDA $85b
     sta $45b
     LDA $85c
     sta $45c
     LDA $85d
     sta $45d
     LDA $85e
     sta $45e
     LDA $85f
     sta $45f
     LDA $860
     sta $460
     LDA $861
     sta $461
     LDA $862
     sta $462
     LDA $863
     sta $463
     LDA $864
     sta $464
     LDA $865
     sta $465
     LDA $866
     sta $466
     LDA $867
     sta $467
     LDA $868
     sta $468
     LDA $869
     sta $469
     LDA $86a
     sta $46a
     LDA $86b
     sta $46b
     LDA $86c
     sta $46c
     LDA $86d
     sta $46d
     LDA $86e
     sta $46e
     LDA $86f
     sta $46f
     LDA $870
     sta $470
     LDA $871
     sta $471
     LDA $872
     sta $472
     LDA $873
     sta $473
     LDA $874
     sta $474
     LDA $875
     sta $475
     LDA $876
     sta $476
     LDA $877
     sta $477
     LDA $8d0
     sta $4d0
     LDA $8d1
     sta $4d1
     LDA $8d2
     sta $4d2
     LDA $8d3
     sta $4d3
     LDA $8d4
     sta $4d4
     LDA $8d5
     sta $4d5
     LDA $8d6
     sta $4d6
     LDA $8d7
     sta $4d7
     LDA $8d8
     sta $4d8
     LDA $8d9
     sta $4d9
     LDA $8da
     sta $4da
     LDA $8db
     sta $4db
     LDA $8dc
     sta $4dc
     LDA $8dd
     sta $4dd
     LDA $8de
     sta $4de
     LDA $8df
     sta $4df
     LDA $8e0
     sta $4e0
     LDA $8e1
     sta $4e1
     LDA $8e2
     sta $4e2
     LDA $8e3
     sta $4e3
     LDA $8e4
     sta $4e4
     LDA $8e5
     sta $4e5
     LDA $8e6
     sta $4e6
     LDA $8e7
     sta $4e7
     LDA $8e8
     sta $4e8
     LDA $8e9
     sta $4e9
     LDA $8ea
     sta $4ea
     LDA $8eb
     sta $4eb
     LDA $8ec
     sta $4ec
     LDA $8ed
     sta $4ed
     LDA $8ee
     sta $4ee
     LDA $8ef
     sta $4ef
     LDA $8f0
     sta $4f0
     LDA $8f1
     sta $4f1
     LDA $8f2
     sta $4f2
     LDA $8f3
     sta $4f3
     LDA $8f4
     sta $4f4
     LDA $8f5
     sta $4f5
     LDA $8f6
     sta $4f6
     LDA $8f7
     sta $4f7
     LDA $950
     sta $550
     LDA $951
     sta $551
     LDA $952
     sta $552
     LDA $953
     sta $553
     LDA $954
     sta $554
     LDA $955
     sta $555
     LDA $956
     sta $556
     LDA $957
     sta $557
     LDA $958
     sta $558
     LDA $959
     sta $559
     LDA $95a
     sta $55a
     LDA $95b
     sta $55b
     LDA $95c
     sta $55c
     LDA $95d
     sta $55d
     LDA $95e
     sta $55e
     LDA $95f
     sta $55f
     LDA $960
     sta $560
     LDA $961
     sta $561
     LDA $962
     sta $562
     LDA $963
     sta $563
     LDA $964
     sta $564
     LDA $965
     sta $565
     LDA $966
     sta $566
     LDA $967
     sta $567
     LDA $968
     sta $568
     LDA $969
     sta $569
     LDA $96a
     sta $56a
     LDA $96b
     sta $56b
     LDA $96c
     sta $56c
     LDA $96d
     sta $56d
     LDA $96e
     sta $56e
     LDA $96f
     sta $56f
     LDA $970
     sta $570
     LDA $971
     sta $571
     LDA $972
     sta $572
     LDA $973
     sta $573
     LDA $974
     sta $574
     LDA $975
     sta $575
     LDA $976
     sta $576
     LDA $977
     sta $577
     LDA $9d0
     sta $5d0
     LDA $9d1
     sta $5d1
     LDA $9d2
     sta $5d2
     LDA $9d3
     sta $5d3
     LDA $9d4
     sta $5d4
     LDA $9d5
     sta $5d5
     LDA $9d6
     sta $5d6
     LDA $9d7
     sta $5d7
     LDA $9d8
     sta $5d8
     LDA $9d9
     sta $5d9
     LDA $9da
     sta $5da
     LDA $9db
     sta $5db
     LDA $9dc
     sta $5dc
     LDA $9dd
     sta $5dd
     LDA $9de
     sta $5de
     LDA $9df
     sta $5df
     LDA $9e0
     sta $5e0
     LDA $9e1
     sta $5e1
     LDA $9e2
     sta $5e2
     LDA $9e3
     sta $5e3
     LDA $9e4
     sta $5e4
     LDA $9e5
     sta $5e5
     LDA $9e6
     sta $5e6
     LDA $9e7
     sta $5e7
     LDA $9e8
     sta $5e8
     LDA $9e9
     sta $5e9
     LDA $9ea
     sta $5ea
     LDA $9eb
     sta $5eb
     LDA $9ec
     sta $5ec
     LDA $9ed
     sta $5ed
     LDA $9ee
     sta $5ee
     LDA $9ef
     sta $5ef
     LDA $9f0
     sta $5f0
     LDA $9f1
     sta $5f1
     LDA $9f2
     sta $5f2
     LDA $9f3
     sta $5f3
     LDA $9f4
     sta $5f4
     LDA $9f5
     sta $5f5
     LDA $9f6
     sta $5f6
     LDA $9f7
     sta $5f7
     LDA $a50
     sta $650
     LDA $a51
     sta $651
     LDA $a52
     sta $652
     LDA $a53
     sta $653
     LDA $a54
     sta $654
     LDA $a55
     sta $655
     LDA $a56
     sta $656
     LDA $a57
     sta $657
     LDA $a58
     sta $658
     LDA $a59
     sta $659
     LDA $a5a
     sta $65a
     LDA $a5b
     sta $65b
     LDA $a5c
     sta $65c
     LDA $a5d
     sta $65d
     LDA $a5e
     sta $65e
     LDA $a5f
     sta $65f
     LDA $a60
     sta $660
     LDA $a61
     sta $661
     LDA $a62
     sta $662
     LDA $a63
     sta $663
     LDA $a64
     sta $664
     LDA $a65
     sta $665
     LDA $a66
     sta $666
     LDA $a67
     sta $667
     LDA $a68
     sta $668
     LDA $a69
     sta $669
     LDA $a6a
     sta $66a
     LDA $a6b
     sta $66b
     LDA $a6c
     sta $66c
     LDA $a6d
     sta $66d
     LDA $a6e
     sta $66e
     LDA $a6f
     sta $66f
     LDA $a70
     sta $670
     LDA $a71
     sta $671
     LDA $a72
     sta $672
     LDA $a73
     sta $673
     LDA $a74
     sta $674
     LDA $a75
     sta $675
     LDA $a76
     sta $676
     LDA $a77
     sta $677
     LDA $ad0
     sta $6d0
     LDA $ad1
     sta $6d1
     LDA $ad2
     sta $6d2
     LDA $ad3
     sta $6d3
     LDA $ad4
     sta $6d4
     LDA $ad5
     sta $6d5
     LDA $ad6
     sta $6d6
     LDA $ad7
     sta $6d7
     LDA $ad8
     sta $6d8
     LDA $ad9
     sta $6d9
     LDA $ada
     sta $6da
     LDA $adb
     sta $6db
     LDA $adc
     sta $6dc
     LDA $add
     sta $6dd
     LDA $ade
     sta $6de
     LDA $adf
     sta $6df
     LDA $ae0
     sta $6e0
     LDA $ae1
     sta $6e1
     LDA $ae2
     sta $6e2
     LDA $ae3
     sta $6e3
     LDA $ae4
     sta $6e4
     LDA $ae5
     sta $6e5
     LDA $ae6
     sta $6e6
     LDA $ae7
     sta $6e7
     LDA $ae8
     sta $6e8
     LDA $ae9
     sta $6e9
     LDA $aea
     sta $6ea
     LDA $aeb
     sta $6eb
     LDA $aec
     sta $6ec
     LDA $aed
     sta $6ed
     LDA $aee
     sta $6ee
     LDA $aef
     sta $6ef
     LDA $af0
     sta $6f0
     LDA $af1
     sta $6f1
     LDA $af2
     sta $6f2
     LDA $af3
     sta $6f3
     LDA $af4
     sta $6f4
     LDA $af5
     sta $6f5
     LDA $af6
     sta $6f6
     LDA $af7
     sta $6f7
     LDA $b50
     sta $750
     LDA $b51
     sta $751
     LDA $b52
     sta $752
     LDA $b53
     sta $753
     LDA $b54
     sta $754
     LDA $b55
     sta $755
     LDA $b56
     sta $756
     LDA $b57
     sta $757
     LDA $b58
     sta $758
     LDA $b59
     sta $759
     LDA $b5a
     sta $75a
     LDA $b5b
     sta $75b
     LDA $b5c
     sta $75c
     LDA $b5d
     sta $75d
     LDA $b5e
     sta $75e
     LDA $b5f
     sta $75f
     LDA $b60
     sta $760
     LDA $b61
     sta $761
     LDA $b62
     sta $762
     LDA $b63
     sta $763
     LDA $b64
     sta $764
     LDA $b65
     sta $765
     LDA $b66
     sta $766
     LDA $b67
     sta $767
     LDA $b68
     sta $768
     LDA $b69
     sta $769
     LDA $b6a
     sta $76a
     LDA $b6b
     sta $76b
     LDA $b6c
     sta $76c
     LDA $b6d
     sta $76d
     LDA $b6e
     sta $76e
     LDA $b6f
     sta $76f
     LDA $b70
     sta $770
     LDA $b71
     sta $771
     LDA $b72
     sta $772
     LDA $b73
     sta $773
     LDA $b74
     sta $774
     LDA $b75
     sta $775
     LDA $b76
     sta $776
     LDA $b77
     sta $777
     LDA $bd0
     sta $7d0
     LDA $bd1
     sta $7d1
     LDA $bd2
     sta $7d2
     LDA $bd3
     sta $7d3
     LDA $bd4
     sta $7d4
     LDA $bd5
     sta $7d5
     LDA $bd6
     sta $7d6
     LDA $bd7
     sta $7d7
     LDA $bd8
     sta $7d8
     LDA $bd9
     sta $7d9
     LDA $bda
     sta $7da
     LDA $bdb
     sta $7db
     LDA $bdc
     sta $7dc
     LDA $bdd
     sta $7dd
     LDA $bde
     sta $7de
     LDA $bdf
     sta $7df
     LDA $be0
     sta $7e0
     LDA $be1
     sta $7e1
     LDA $be2
     sta $7e2
     LDA $be3
     sta $7e3
     LDA $be4
     sta $7e4
     LDA $be5
     sta $7e5
     LDA $be6
     sta $7e6
     LDA $be7
     sta $7e7
     LDA $be8
     sta $7e8
     LDA $be9
     sta $7e9
     LDA $bea
     sta $7ea
     LDA $beb
     sta $7eb
     LDA $bec
     sta $7ec
     LDA $bed
     sta $7ed
     LDA $bee
     sta $7ee
     LDA $bef
     sta $7ef
     LDA $bf0
     sta $7f0
     LDA $bf1
     sta $7f1
     LDA $bf2
     sta $7f2
     LDA $bf3
     sta $7f3
     LDA $bf4
     sta $7f4
     LDA $bf5
     sta $7f5
     LDA $bf6
     sta $7f6
     LDA $bf7
     sta $7f7
     RTS
; =============================================================================

