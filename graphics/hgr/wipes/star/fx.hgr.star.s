;license:MIT
;(c) 2019-2020 by 4am/qkumba
;
;!cpu 6502
;!to "build/FX.INDEXED/STAR",plain
;*=$6000

;        !source "src/fx/fx.hgr.precomputed.2bit.a"

	.include "fx.hgr.precomputed.2bit.s"

;         +FX_INITONCE_2BIT FXCodeFile, CoordinatesFile, Start


InitOnce:
	bit	Start
	lda	#$4C		; jmp
	sta	InitOnce

;	Load fxcode to $6200

;	LDADDR FXCodeFile
;	ldx   #>FXCode
;	jsr   iLoadFXCODE

;	Load co-ordinates file

;	LDADDR CoordinatesFile
;	ldx   #>Coordinates2Bit
;	jsr   iLoadFXDATA

	; ???

         lda   #$00
         sta   EndCoordinates2Bit


Start:
;         jmp   FXCode

	.include "code.hgr.precomputed.2bit.s"

;FXCodeFile
;         +PSTRING "HGR2"
;CoordinatesFile
;         +PSTRING "STAR.DATA"