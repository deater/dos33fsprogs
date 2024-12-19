;license:MIT
;(c) 2019-2020 by 4am/qkumba
;
;!cpu 6502
;!to "build/FX.INDEXED/STAR.RIPPLE",plain
;*=$6000

 ;        !source "src/fx/fx.hgr.precomputed.2bit.a"

	.include "fx.hgr.precomputed.2bit.s"

;         +FX_INITONCE_2BIT FXCodeFile, CoordinatesFile, Start

InitOnce:
	bit	Start
	lda	#$4c
	sta	InitOnce

	lda	#0
	sta	EndCoordinates2Bit

	jsr	RippleCoordinates2Bit
Start:

	.include "code.hgr.precomputed.2bit.s"

;         jmp   FXCode

;FXCodeFile
;         +PSTRING "HGR2"
;CoordinatesFile
;         +PSTRING "STAR.DATA"
