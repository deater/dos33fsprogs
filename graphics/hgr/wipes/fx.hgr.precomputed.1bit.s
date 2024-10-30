;license:MIT
;(c) 2019-2024 by 4am
;

;------------------------------------------------------------------------------
; YE OLDE GRAND UNIFIED MEMORY MAP
;
; 0201..02C0 - hgrlo
; 02C1..02E8 - mirror_cols
; 02E9..0300
; 0301..03C0 - hgrhi
; 03C1..03EE
; 6000..61FF - module-specific code ($200 max)
; 6200..     - shared FX code (loaded once by module-specific code)
; 85FE..B880 - Coordinates1Bit (8600 but dither variants clobber Coordinates1Bit-2)
; B881..BB00
; BB01..BBC0 - hgrlomirror
; BBC1..BC00
; BC01..BCC0 - hgr1himirror
; BCC1..BDA7
; BDA8..BDFF - dithermasks
; BE00..BEFF - copymasks1bit
; BF00..BFFF - ProRWTS glue
;

;         !source "src/fx/macros.a"
	.include "macros.s"

;!macro FX_INITONCE_1BIT .CoordinatesFile, .Start {
.macro FX_INITONCE_1_BIT CoordinatesFile, Start
InitOnce:
	bit   Start
	lda   #$4C
	sta   InitOnce

	LDADDR CoordinatesFile
	ldx   #>Coordinates1Bit
	jsr   iLoadFXDATA

	sec
	ror   EndCoordinates1Bit
;}
.endmacro

; same but also loading an FXCode file
;!macro FX_INITONCE_1BIT .FXCodeFile, .CoordinatesFile, .Start {
.macro FX_INITONCE_1BIT FXCodeFile, CoordinatesFile, Start

InitOnce:
	bit   Start
	lda   #$4C
	sta   InitOnce

	LDADDR FXCodeFile
	ldx   #>FXCode
	jsr   iLoadFXCODE

	LDADDR CoordinatesFile
	ldx   #>Coordinates1Bit
	jsr   iLoadFXDATA

	sec
	ror   EndCoordinates1Bit
;}
.endmacro
