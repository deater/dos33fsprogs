; PLASMAGORIA code from French Touch
; version 0.09

;	!convtab "a2txt.bin" ;
;	!sl "mainlabel.a"

; INCLUDE

;	*= $F100 ; ORG = $F100 (RAM Langage Card)

; PSEUDO CATALOG Track/SectorDebut-Track/SectorFin (inclus)

; T00/S00 		: BOOT0	($800) x1
; T00/S01-S09 		: MAIN	($F100) x8
; T00/S0A-S0F		: FLOAD ($FA00) x6

; T01/S00 - T03/Sxx	: ROUTINES ($4000) x??

; T04/S00 - T04/S06	: ZIC ($8000) x07


; CONSTANTES SYSTEME ===================
VERTBLANK	 		= $C019	;

; CONSTANTES PROGRAMME =================
DATADECOMP			= $200		; AUX

; SOUS-ROUTINES BOOT0
EXECFROMBOOT2  		= $857 	; sous routine de détection type APPLE II (utilise ROM)

; SOUS-ROUTINES PROGRAMMES EXTERNES
HYPLOD				= $FA00	; routine Fast Load

PLASMA_DEBUT		= $4009

;======PARAMETRES DU FAST LOAD
                        ;-PARAMETRES D'ENTREE
PISDEP   =   $300       ;PISTE DE DEPART
SECDEP   =   $301       ;SECTEUR DE DEPART
BUFFER   =   $302       ;ADRESSE OU L'ON CHARGE
TOTSEC   =   $304       ;TOTAL DES SECTEURS A CHARGER

DRVNUM   =   $305       ;1 OU 2
ERRMAX   =   $306       ;MAXIMUM D'ERREURS TOLEREES SUR UN SECTEUR AVANT DE RENDRE LA MAIN
DLFLAG   =   $307       ;1=DELAI AVANT DE LIRE ;0=NON

                        ;-PARAMETRES ENTREE/SORTIE
ICURTRK1 =   $310       ;2*PISTE INITIALE DU DRIVE1 A GARNIR POUR LE 1ER APPEL
ICURTRK2 =   $311       ;2*PISTE INITIALE DU DRIVE2    "

bAFFICHE = 	 $312
BUFFERAFFH=	 $313         ; adresse du buffer d'affichage
BUFFERAFFL=	 $314		  ; haut et bas
CARAFF	 =	 $315		  ; caractère à afficher

; PAGE ZERO ===========================
; adresses fixes
;
; system
bMocking	= $08	; Mockingboard (00 - NOP / 01 - OK)
bIIc		= $09	; byte IIc	(00 = //c | other = pas //c !)
bMachine 	= $0A	; byte MACHINE ($7F/IIE | $FF/GS)
bRefresh	= $0B	; byte type NTSC/60Hz - PAL/50Hz (00 = 50HZ | 01 = 60 HZ)

bitsixset	= $0C	; utiliser pour un SLV (set overflow) = $60
vblflag		= $0D	; utilisée par interruption VBL sur //c

; general

;
OUT1			= $20 ; +$21
OUT2			= $22 ; +$23
; -------------------------------------
; adresses réutilisées suivant les parties
;
; decompression LZ4
Tmp			= $F6
token		= $F7
dest		= $F8	; + $F9
src1		= $FA	; + $FB
src2 		= $FC  	; + $FD
lenL		= $FE
lenH		= $FF
;

; player YM
TempP			= $F8

Beat			= $FA
Mark			= $FB
Marker			= $FC	; +$FD
Mem				= $FE 	; +$FF

; -------------------------------------
;	======== DEBUT PROGRAMME =========
START:
 		JMP EXECFROMBOOT2

VBLANK:
		JMP VBLANK_GSE

DEBUT2:
;!zone
		; ========= DETECT REFRESH ===========
DETECTREFRESH:
;!zone

		LDA bIIc
 		BEQ DR_LOAD	; si c'est un IIc, on passe à la suite (chargement), le DETECT REFRESH ne marchera de toute façon pas.

		; detection refresh rate (PAL/NTSC)
		LDA	 bMachine 	;
DR_lp1:
		CMP VERTBLANK
		Bpl   DR_lp1		; on attend la fin du VBL courant

		LDA  bMachine	; 3
DR_lp2:
		CMP VERTBLANK	; 4
		Bmi   DR_lp2	 	; 2 => on attend la fin du display courant/début du VBL

		; début VBL

DR_BP:
			INC COUNTREF	; 6 ; on incrémente le compteur

		LDX #$09		; 							
DR_WL1:
	 	DEX				; 					
		BNE DR_WL1 		; = 46 cycles
						; + 6 + 3 + 3 + 4 + 3 = 65 !

		LDA bMachine	; 3

		LDA bMachine	; 3
		CMP VERTBLANK	; 4
		Bpl   DR_BP	 	; 3 => on boucle tant qu'on est en VBL

		LDA COUNTREF
		CMP #72			; >= 72 alors 50 HZ (120*65 cycles de VBL)
		BCS DR_GO3

		LDA #01			; 60HZ (VBL = 70x65 cycles)
		JMP DR_GO4

DR_GO3:
		LDA #00			; 50HZ (VBL = 120x65 cycles)
DR_GO4:
		STA bRefresh

DR_LOAD:
 		 ; === CHARGEMENTS =====
 		 ; initialisation HyperLoad + divers !
 		LDX #00
 		STX 	ICURTRK1
 		STX 	bAFFICHE		; on désactive l'affichage lors du chargement (pour l'instant)
		STX 	SECDEP			; secteur 00
 		STX 	BUFFER			; buffer low
 		INX	; 1
 		STX 	DRVNUM
 		STX 	DLFLAG
 		STX 	OUT1

 		; chargement ROUTINES
		STX PISDEP			; piste 01
 		LDA #$40			; buffer high -> $4000
		STA BUFFER+1
		LDA #45				; nb secteurs
		STA TOTSEC
		JSR HYPLOD			; chargement !

		; chargement ZIC
		LDA #04
 		STA PISDEP			; piste 04
 		LDA #$00
 		STA BUFFER
 		STA SECDEP
 		LDA #$80			; buffer high -> $8000
		STA BUFFER+1
		LDA #7				; nb secteurs
		STA TOTSEC
		JSR HYPLOD			; chargement !

 		; =============================
 		LDA bIIc
 		BNE DR_SUITE	; si c'est pas un IIc, on passe à la suite

		; ====== IIC ONLY =============
		; si c'est un IIc  mise en place de l'interruption !
		LDA #00
		STA vblflag				; initialisation vblflag pour l'interruption
		LDA #<VBLANKIIc			; on fixe la routine d'appel au VBLANK
 		STA VBLANK+1			; sur la routine
 		LDA #>VBLANKIIc			; //c
 		STA VBLANK+2

 		sei 					; disable interrupts

 		lda #<VBLI 				; on fixe le vecteur de l'interruption 
 		STA $FFFE				; du IIc (VBL)
 		lda #>VBLI				; pour pointer
 		STA $FFFF				; sur notre routine VBLI

 		; on active la première interruption pour VBL
 		sta $c079 				; enable IOU access
 		sta $c05b 				; enable VBL int (CLI)
 		sta $c078 				; disable IOU access
		JMP DR_SUITE2
		; =============================

DR_SUITE:
		LDA bMocking
 		BEQ DR_SUITE2	; s'il n'y a pas de MOCKINGBOARD détectée

		; == PREPARATION MOCKINGBOARD =

		LDA bMachine	; si IIGS
		BMI	DR_INITMB

		; mise en place vecteur IIe
		; (vecteur GS déjà mis en place dans BOOT)
		LDA #<INTPLAYERYM
		STA $FFFE
		LDA #>INTPLAYERYM
		STA $FFFF

DR_INITMB:
		; init MB (OUT1/OUT2)
		LDA   	#$FF
		LDY	  	#$03
		STA 	(OUT2),Y	; STA   $C403		; DDRA1
		LDY 	#$83
		STA 	(OUT2),Y	; STA   $C483		; DDRA2
		LDA   	#$07
		LDY 	#$02
		STA		(OUT2),Y	; STA   $C402		; DDRB1
		LDY 	#$82
		STA		(OUT2),Y	; STA   $C482		; DDRB2

		; nécessaire ?
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
		; ---
		; nettoyage TIMER

		; ---

		LDA 	OUT2+1
		STA		OUT1+1		;
		STA		OFFBIT+2	; fixe BIT $Cx04 (réinit interruption)
		; =============================

DR_SUITE2:
; =============================================================================
; AFFICHAGE TITRE

			JSR VBLANK
			LDX #39
bAffTitle:
			LDA Title01,X
			STA $580,X
			LDA Title02,X
			STA $600,X
			LDA Title03,X
			STA $680,X
			LDA Title04,X
			STA $700,X
			LDA Title05,X
			STA $780,X
			LDA Title06,X
			STA $428,X
			LDA Title07,X
			STA $4A8,X
			LDA Title08,X
			STA $528,X
			LDA Title09,X
			STA $5A8,X
			LDA Title10,X
			STA $628,X
			LDA Title11,X
			STA $6A8,X
			LDA Title12,X
			STA $728,X
			LDA Title13,X
			STA $7A8,X
			LDA Title14,X
			STA $450,X
			LDA Title15,X
			STA $4D0,X
			LDA Title16,X
			STA $550,X
			LDA Title17,X
			STA $5D0,X
			DEX
			BPL bAffTitle

; --------------------------------------------------------
; effacement PAGE1 HGR
			; X = $FF
			INX			; => x =0
			TXA			; A = 00 (noir en HGR)
			LDY #32
bCleanHGR:
offHGR:
			STA $2000,X
			DEX
			BNE bCleanHGR
			INC offHGR+2
			DEY
			BNE bCleanHGR

; copie P1->P2
			LDX #00
bMoveP1_P2:
			LDA $400,X
			STA $800,X
			LDA $500,X
			STA $900,X
			LDA $600,X
			STA $A00,X
			LDA $700,X
			STA $B00,X
			DEX
			BNE bMoveP1_P2
; =============================================================================
; DECOMPRESSION
; =============================================================================	

			JSR DECOMP
			STA $C004			; restore write MAIN Memory


; =============================================================================
; INIT INTERRUPTION + DATA
; =============================================================================	
		; mise en place de l'interruption
		SEI					; inhib

		; préparation interruption - TIMER 1 6522
		LDA #%01000000		; continuous interrupt / PB7 disabled
		LDY #$0B
		STA (OUT2),Y		; STA $C40B			; Auxiliary Control Register

		LDA #%11000000		;
		LDY #$0D
		STA (OUT2),Y		;	STA $C40D			; interrupt flag register	(Time Out of Timer 1/Int)
		INY
		STA (OUT2),Y		; STA $C40E			; interrupt Enable register (Timer 1 + Set)

		; TIMER : 50 Hz = 20 ms = 20 000 microsecond = 20 000 tick environ (1 Mhz d'holorge) = $4E20
		; calcul fin :
		; 50 Hz = 20 ms
		; 1.0205 Mhz = 1020500 cycles par seconde soit 1020.5 cycles par ms
		; pour 20ms, il faut donc 1020.5*20 = 20410 cycles soit : $4FBA
		LDA	#$BA
		LDY #04
		STA (OUT2),Y		; STA $C404			; T1C-Lower
		LDA #$4F
		INY
		STA (OUT2),Y		; STA $C405			; T1C-High


		; --- initialisation Tables Offsets Data Registres, Offsets Loop, et Table Compression (MAIN)
		LDX #13					; registers (0-13)

		; initialisation offset Registre (AUX) + Marker

		STA $C003 	 			; READ AUX MEMORY
		; Offsets Registres
		LDX #14					; registers [0-13 + marker (14)]

b2:
		LDA TableOffsetDataB,X
		STA Mem
		CLC
		ADC #02
		STA TableOffsetDataB,X
		LDA TableOffsetDataH,X
		STA Mem+1
		ADC #00
		STA TableOffsetDataH,X
		LDY #00
		LDA (Mem),Y
		STA TableCompteur,X
		INY
		LDA (Mem),Y
		STA TableData,X
g2:
		DEX
		BPL b2
		; ----------------------

		STA $C002				; READ MAIN MEMORY
		; ---

; =============================================================================
; BOUCLE PRINCIPALE PLAYING
; =============================================================================	

		JMP PLASMA_DEBUT

; =============================================================================

; =============================================================================
; SOUS ROUTINES
; =============================================================================
; -------------------------------------
DECOMP:

; routine de décompression LZ4
; code: XXL and FOX (from Atari Scene)
; modified: FT
;
; dans A - partie haute adresse data compressées

; init

		LDA #$80
		STA src2+1
		LDA #$00					; commence en $00
		STA src2
		LDA #<DATADECOMP
		STA dest
		LDA #>DATADECOMP
		STA dest+1

		LDY #0
		STY lenH
		STY lenL

; init mémoire

		STA $C000			; 80STOREOFF
		STA $C002			; read MAIN Memory
		STA $C005 			; write AUX Memory
		STA $C008			; zero Page = Main

; -------------------------------------
; décomp LZ4 routine
; -------------------------------------
BP:
             		jsr   	GET_BYTE
                  	sta    	token
               		lsr
               		lsr
               		lsr
               		lsr
                  	beq    	read_offset                     ; there is no literal
                  	cmp    	#$0f
                  	jsr    	getLength

b_literals:
		        jsr    	GET_BYTE
                  	jsr    	store
                  	bne    	b_literals

read_offset:
		       	jsr    	GET_BYTE		; offset L
                  	tax
                  	sec
                  	eor    	#$ff
                  	adc    	dest
                  	sta    	src1
                  	txa
                  	php
                  	jsr    	GET_BYTE		; offset H
                  	plp
                  	bne    	not_done
                  	tax
                  	beq    	unlz4_done	; sortie routine !
not_done:
	          	eor    	#$ff
                  	adc    	dest+1				; calcul offset H (absolu)
                  	STA		src1+1				; sauvegarde de l'offset après correction hors page $C0 : $C0->$D0 / $D0->$E0
                  	LDY 	#00					; remise à 0 de Y
                  	; c=1
		            lda    	token
                  	and    	#$0f
                  	adc    	#$03        ; 3+1=4
                  	cmp    	#$13
                  	jsr    	getLength

b1:
	                STA 	$C003			; read AUX Memory
			lda    	(src1),Y
                  	STA 	$C002			; read MAIN Memory
                  	INC 	src1
                  	BNE 	s1
       			TAX
                  	INC 	src1+1
                  	LDA		src1+1
                  	CMP 	#$C0
                  	BEQ	sss1
ss1:
	                TXA
s1:
	                jsr    	store
                  	bne    	b1
                  	jmp	BP
sss1:
			LDA  	#$D0
			STA 	src1+1
			JMP	ss1

store:
	             	sta    	(dest),Y
                  	INC	dest
                  	BEQ 	s2

		        dec    	lenL
                  	beq    	s2b
unlz4_done:
			rts
s2b:
			dec    	lenH
		       	rts
s2:
			INC 	dest+1
			LDA	dest+1
			CMP	#$C0
			BEQ 	sss2
ss2:
			dec    	lenL
                  	beq    	s2b
		        rts
sss2:
			LDA 	#$D0
			STA 	dest+1
			JMP 	ss2


getLength_next:
		   	jsr    	GET_BYTE
                  	tax
                  	clc
	                adc    	lenL
                  	bcc    	s3
                  	inc    	lenH
s3:
	   	       	inx

getLength:
	         	sta    	lenL
                  	beq    	getLength_next
                  	tax
                  	beq    	s4
                  	inc    	lenH
s4:
			rts

GET_BYTE:
			LDA	(src2),Y
			INC 	src2
			BEQ 	s5
			RTS

s5:
			INC 	src2+1
			RTS

; =============================================================================
; =============================================================================
INTPLAYERYM:			; interruption toutes les 20ms (50Hz)

		;
		PHP					; on sauve les flags
		PHA					; on sauve A
		TXA					; on sauve 
		PHA					; X
		TYA					; on sauve
		PHA					; Y


		LDA OUT1			; permutation g/d
		EOR #$80
		STA OUT1
		LDA OUT2
		EOR #$80
		STA OUT2

		STA $C003			; read AUX Memory
		LDY #00

		; remplissage REGISTRES (les 13 premiers)
		LDX #00

YM_br1:
		TXA
		STA (OUT1),Y		; ORA1 (data)
		LDA #$07			; Set fct "Set PSG Reg #"
		STA (OUT2),Y		; ORB1 (fct)
		LDA #$04			; Set fct "Inactive"
		STA (OUT2),Y		; ORB1 (fct)

		LDA TableData,X
		STA (OUT1),Y		; ORA1 (data)
		LDA #$06			; Set fct "Write DATA"
		STA (OUT2),Y		; ORB1 (fct)
		LDA #$04			; Set fct "Inactive"
		STA (OUT2),Y		; ORB1 (fct)
		INX
		CPX #13
		BNE YM_br1

		; Registre R13
		; x = 13
		LDA TableData,X
		CMP #$FF			; spécification YM format / shunte si = $FF
		BEQ YM_shunteR13
		STA TempP

		TXA
		STA (OUT1),Y		; ORA1 (data)
		LDA #$07			; Set fct "Set PSG Reg #"
		STA (OUT2),Y		; ORB1 (fct)
		LDA #$04			; Set fct "Inactive"
		STA (OUT2),Y		; ORB1 (fct)

		LDA TempP
		STA (OUT1),Y		; ORA1 (data)
		LDA #$06			; Set fct "Write DATA"
		STA (OUT2),Y		; ORB1 (fct)
		LDA #$04			; Set fct "Inactive"
		STA (OUT2),Y		; ORB1 (fct)

YM_shunteR13:
		; lecture info MARKER Tempo
		INX
		; x = 14
		LDA TableData,X
		BEQ YM_suite
		BPL YM_setMark		; si 0x01
		INC Beat			; si 0x80 (ou 0x81)
		LSR
		BCC YM_suite			; si pas 0x81
YM_setMark:
		INC Mark			; si 0x01 (ou 0x81)

YM_suite:
		;
		LDX #14
YM_b2:
		DEC TableCompteur,X
		BEQ YM_g1
YM_g2:
		DEX
		BPL YM_b2

OFFBIT:
		BIT $C404           ; Clears interrupt (T1CL) pour pouvoir être de nouveau réutilisé! 

YM_finInterrupt:
		PLA
		TAY					; on récup Y
		PLA
		TAX					; on récup X
		PLA					; on récup A
		PLP
		STA $C002			; read MAIN Memory
		RTI					; sortie 1

YM_g1:
		LDA TableOffsetDataB,X
		STA Mem
		CLC
		ADC #02
		STA TableOffsetDataB,X
		LDA TableOffsetDataH,X
		STA Mem+1
		ADC #00
		STA TableOffsetDataH,X
		LDY #00
		LDA (Mem),Y
		BEQ YM_endframes
		STA TableCompteur,X
		INY
		LDA (Mem),Y
		STA TableData,X
		JMP YM_g2

YM_endframes:
		; on coupe le son

		LDA #01				; FIN !
		STA Mark


		JMP YM_finInterrupt

; ==============================================================================
; SOUS ROUTINES
; ==============================================================================
VBLI:		; routine executé lors de l'interruption VBL de la Mouse Rom d'un IIc

 		; on réactive l'interruption
 		sta $c079 		; enable IOU access
 		sta $c05b 		; enable VBL int
 		sta $c078 		; disable IOU access
		; on fixe le flag
 		LDA #$80
 		STA vblflag 	; set hibit
		RTI
; =============================================================================
VBLANKIIc:				; code from Prince Of Persia Source (Jordan Mechner - 1989)

 		cli 			; enable interrupts

VB_l1:
	 	bit vblflag
		bpl VB_l1 		; wait for vblflag = 1
		lsr vblflag 	;...&  set vblflag = 0

 		sei
 		rts
; =============================================================================
VBLANK_GSE:

 		LDA bMachine
VG_LVBL1:
		CMP VERTBLANK
		BPL VG_LVBL1 			; attend fin vbl courant

        ;LDA bMachine
VG_LVBL2:
	 	CMP VERTBLANK
		BMI VG_LVBL2 			; attend fin display
		; début VBL
		RTS
; ============================================================================
; offset début data 14 registres + marker
TableOffsetDataB: 		.byte $00,$F3,$F8,$4F,$98,$7B,$A4,$97,$B0,$C3,$34,$CB,$0E,$37,$A4 ; <- marker
TableOffsetDataH: 		.byte $02,$1F,$24,$33,$33,$54,$54,$58,$5C,$63,$6B,$71,$72,$72,$72

TableCompteur:
 	;!fill 15,00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00

TableData:
 	;!fill 15,00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
COUNTREF:				.byte 0
; ============================================================================
; attention à l'alignement
;..............0000000000111111111122222222223333333333
;..............0123456789012345678901234567890123456789
Title01: .byte " _____ ____    ___ ____     __ __ __    "
Title02: .byte "|     |    \  /  _|    \   /  |  |  |   "
Title03: .byte "|   __|  D  )/  <_|  _  | /  /|  |  |   "
;!align 255,0
.align 256
Title04: .byte "|  |_ |    /|    _|  |  |/  / |  _  |   "
Title05: .byte "|   _>|    \|   <_|  |  /   \_|  |  |   "
Title06: .byte "|  |  |  .  \     |  |  \     |  |  |   "
Title07: .byte "|__|  |__|\_|_____|__|__|\____|__|__|   "
Title08: .byte "       __  __  ___ _____   ____ __      "
Title09: .byte "      /__)/__)(_  ( (_  /| )/  (        "
.align 256
;!align 255,0
Title10: .byte "     /   / (  (____)(__/ |/(  __)       "
Title11: .byte "         ______  ___  __ __    __ __ __ "      
Title12: .byte "        |      |/   \|  |  |  /  |  |  |"     
Title13: .byte "        |      |     |  |  | /  /|  |  |"     
Title14: .byte "        |_|  |_|  O  |  |  |/  / |  _  |"     
Title15: .byte "          |  | |     |  :  /   \_|  |  |"     
.align 256
;!align 255,0
Title16: .byte "          |  | |     |     \     |  |  |"
Title17: .byte "          |__|  \___/ \__,_|\____|__|__|"
