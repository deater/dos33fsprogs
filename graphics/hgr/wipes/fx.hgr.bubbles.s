;license:MIT
;(c) 2019-2020 by 4am/qkumba
;
;!cpu 6502
;!to "build/FX.INDEXED/BUBBLES",plain
;*=$6000

;        !source "src/fx/fx.hgr.precomputed.1bit.a"
	.include "fx.hgr.precomputed.1bit.s"


;         FX_INITONCE_1BIT FXCodeFile, CoordinatesFile, Start
Start:
;         jmp   FXCode

FXCodeFile:
         PSTRING  "HGR1"
CoordinatesFile:
         PSTRING "BUBBLES.DATA"
