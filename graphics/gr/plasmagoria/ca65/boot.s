;@com.wudsn.ide.asm.hardware=APPLE2 
; ACME 0.90
; PLASMAGORIA
; boot0 (T0/S0)
; version 0.3

; + interruption spécial GS (réactive language card + jmp to player)
; #SLOT variable pour MB
; - bug IIGS (=> fixe pas IIc)

!convtab "a2txt.bin" 	; incorporation table caractère APPLE II (normal) générale
!sl "bootlabel.a"

		*= $800 ; ORG = $800

; CONSTANTE
	DEBUT2 		= $F106
	RoutINTGS	= $4000
	
; variable PAGE ZERO
	bMocking	= $08	; Mockingboard (00 - NOP / 01 - OK)
	bIIc		= $09	; byte IIc	(00 = //c | other = pas //c !)
	bMachine 	= $0A	; byte MACHINE ($7F/IIE | $FF/GS)

	OUT2		= $22 ; +$21

	Temp		= $FF
; variables

		OffMin = $F0

!byte 01 					; premier octet réservé : nb de secteur à charger lors du boot 0

START
!zone

; quand on arrive là, le drive tourne, x = 60 (si slot 6)

		JMP .Init			
                
        DEC OffHi			;                                                             
.boucle
		LDA OffHi
		CMP #OffMin			; on est au bout ? 
		BEQ .FIN
		STA $27
		LDY nbSector		; nb Secteur
		LDA TableInter,Y
		STA $3D
		JMP $C65C			; lecture par la routine en ROM carte Disk II (slot 6 only)
							; le retour se fait par le JMP $801 en sortie de cette routine
.FIN	
		JMP $F100			; saut Boot 2 (MAIN). Voilà c'est fini !                                        

.Init	JSR $FC58			; HOME
		LDA $C051			; Text   
		LDA $C054			; page 1
		LDA $C052			; Mixed Off
		LDA $C057			; hires

		LDA $C083
		LDA $C083			; write/read to RAM bank2 (Langage Card)

		LDA #$CE			; on écrit DEC nbSector en $801 
		STA $801			; pour que le JMP $801 en fin de routine
		LDA #<nbSector		; (en $C605)
		STA $802			; fasse une boucle avec le code en $801
		LDA #>nbSector		;
		STA $803
		JMP .boucle

TableInter					; interleaving
!byte 	0x00,0x0D,0x0B,0x09,0x07,0x05,0x03,0x01,0x0E,0x0C,0x0A,0x08,0x06,0x04,0x02,0x0F
OffHi
!byte	0xFF				; offset pour lecture secteur  
nbSector
!byte	0x0F				; nb de sector à lire

; code executé APRES le saut au BOOT 2 (depuis main)
; (routine devant être exécutée en dehors de MAIN car utilisation de la ROM A2)
EXECFROMBOOT2

		; détection APPLE II GS/IIE/IIc
		LDA $C082		; ROM utilisable entre $D000/$FFFF
		
		; IIc ?
		LDX $FBC0		; détection IIc
		BNE .tgs		; 0 = IIc / Other = pas IIc
		; si IIc , on continue mais pas de son Mockingboard
		STX bIIc		; 0 = IIc / Other = pas IIc
		JMP .end		; boucle = FIN !
		
		; IIgs ou IIe ?	
.tgs	STX bIIc		; pas IIc
		SEC
 		JSR $FE1F 		; TEST GS 
 		BCS .tIIe		; si Carry, IIE
		
		; IIGS
		; on prépare bordure,fond,speed et INT !
 		LDA #$FF
		STA bMachine	; positionnement type Machine GS
 		
 		LDA $C036
 		AND #$7F
 		STA $C036 		; VITESSE LENTE
 	
 		LDA $C034 		;
		AND #$F0
 		STA $C034 		; BORDURE NOIRE

		LDA $C022
		AND #$F0		; bit 0-3 à 0 = background noir
		ORA #$F0		; bit 7-4 à 1 = text blanc
		STA $C022		; background noir/text blanc
	
		; mise en place vecteur interruption GS
		LDA #<RoutINTGS
		STA $3FE
		LDA #>RoutINTGS
		STA $3FF		

		JMP .tmb

.tIIe	; IIE
		LDA #$7F		; Apple IIe
		sta bMachine	; positionnement type Machine IIe 
				
		; test MB
.tmb 	
		; MB / SLOT #?
		LDA #00
		STA OUT2
.bdet	LDA #$07				; on commence en $C7 jusqu'en $C1
		ORA #$C0				; -> $Cx
		STA OUT2+1
		LDY #04					; $CX04
		LDX #02					; 2 vérifs

.bt		LDA (OUT2),Y			; timer 6522 (Low Order Counter) - attention compte à rebour !
		STA Temp				; 3 cycles
		LDA (OUT2),Y			; + 5 cycles = 8 cycles entre les deux accès au timer
		SEC						; 
		SBC Temp				; 
		CMP #$F8				; -8 (compte à rebour) ?
		BNE .Ko
		DEX
		BNE .bt					; boucle détection
		INX						; Mocking OK (X=1)
	
.end	; GOOD GUY final !	
		STX bMocking			; save Mockingboard Info (note : si IIc, X = 0)
		LDA $C083				;
		LDA $C083				; RAM utilisable entre $D000/$FFFF (bank2)
		JMP DEBUT2				; retour dans main

		; bad guy slot #
.Ko		DEC .bdet+1				; on décrémente le "slot"
		BNE	.bdet				; on boucle de 7 à 1
		LDX #00		
		JMP .end				; on continue !