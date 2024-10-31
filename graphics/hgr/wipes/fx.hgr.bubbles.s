;license:MIT
;(c) 2019-2020 by 4am/qkumba
;
;!cpu 6502
;!to "build/FX.INDEXED/BUBBLES",plain
;*=$6000

;        !source "src/fx/fx.hgr.precomputed.1bit.a"
	.include "fx.hgr.precomputed.1bit.s"



;         FX_INITONCE_1BIT FXCodeFile, CoordinatesFile, Start

InitOnce:
	bit	Start		; essentially a nop?
	lda	#$4C		; JMP?
	sta	InitOnce	; convert to a jump to start after first time

;	LDADDR	FXCodeFile	; load fx effect to $6200
;	ldx	#>FXCode
;	jsr	iLoadFXCODE

;	LDADDR CoordinatesFile	; load co-ordinates file
;	ldx   #>Coordinates1Bit
;	jsr   iLoadFXDATA

	sec
	ror   EndCoordinates1Bit	; ??


Start:
;         jmp   FXCode

	.include "code.hgr.precomputed.1bit.s"


;FXCodeFile:
;        PSTRING  "HGR1"
;CoordinatesFile:
;         PSTRING "BUBBLES.DATA"
