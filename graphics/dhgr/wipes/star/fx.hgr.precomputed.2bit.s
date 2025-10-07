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
; 80FE..BD00 - Coordinates2Bit (8100 but dither variants clobber Coordinates2Bit-2)
; BD01..BDA7
; BDA8..BDFF - dithermasks
; BE00..BEFF - copymasks2bit
; BF00..BFFF - ProRWTS glue
;

;         !source "src/fx/macros.a"

;	.include "../macros.s"

;!macro FX_INITONCE_2BIT .FXCodeFile, .CoordinatesFile, .Start {

.macro FX_INITONCE_2BIT FXCodeFile, CoordinatesFile, Start

InitOnce:
         bit   Start
         lda   #$4C
         sta   InitOnce

         LDADDR FXCodeFile
         ldx   #>FXCode
         jsr   iLoadFXCODE

         LDADDR CoordinatesFile
         ldx   #>Coordinates2Bit
         jsr   iLoadFXDATA

         lda   #$00
         sta   EndCoordinates2Bit
;}
.endmacro
