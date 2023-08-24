;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - DrawCondensedString
;


string_ptr                = $FC      ; word (used by DrawLargeString)
tmpx                      = $FE      ; byte (used by DrawLargeCharacter, FindValidMove)
tmpy                      = $FF      ; byte (used by DrawLargeCharacter, FindValidMove)


CondensedHGRTops:
         .byte 7,18,29,40,51,62,73,84,95,106,117,128,139,150,161,172

;------------------------------------------------------------------------------
; DrawCondensedString
;
; in:    A/Y points to length-prefixed string (Pascal style)
;        X contains column number (0x00..0x27)
;        $25 (VTAB) contains logical line number (0x00..0x0F)
;        pointer is hidden
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
DrawCondensedString:
;         +ST16 string_ptr	; macro
	sta	string_ptr
	sty	string_ptr+1



         stx   HTAB
         ldy   #0
         lda   (string_ptr), y
         tax
         inc   string_ptr
         bne   dcs1
         inc   string_ptr+1
dcs1:
;         +LD16 string_ptr
	lda	string_ptr
	ldy	string_ptr+1

         ; /!\ execution falls through here to DrawCondensedBuffer

;------------------------------------------------------------------------------
; DrawCondensedBuffer
;
; in:    A/Y contains address of character buffer (characters 0x19+ only)
;        X contains buffer length (0x01..0x28)
;        $24 (HTAB) contains starting column (0x00..0x27)
;        $25 (VTAB) contains logical line number (0x00..0x0F)
;        all characters are drawn on the same line
;        HTAB is incremented for each character
;        VTAB is NOT incremented
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
;DrawCondensedBuffer
;         +ST16 @loop+1

	sta   @loop+1
	sty   @loop+2

         dex
         ldy   VTAB
         lda   CondensedHGRTops, y
         tay
         lda   hposn_low, y
         clc
         adc   HTAB
         sta   @row0+1
         lda   hposn_high, y
         sta   @row0+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row1+1
         lda   hposn_high, y
         sta   @row1+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row2+1
         lda   hposn_high, y
         sta   @row2+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row3+1
         lda   hposn_high, y
         sta   @row3+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row4+1
         lda   hposn_high, y
         sta   @row4+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row5+1
         lda   hposn_high, y
         sta   @row5+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row6+1
         lda   hposn_high, y
         sta   @row6+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row7+1
         lda   hposn_high, y
         sta   @row7+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row8+1
         lda   hposn_high, y
         sta   @row8+2
         iny
         lda   hposn_low, y
         adc   HTAB
         sta   @row9+1
         lda   hposn_high, y
         sta   @row9+2
@loop:    ldy   $FDFD, x
         lda   CondensedRow0-$19, y
@row0:    sta   $FDFD, x
         lda   CondensedRow1-$19, y
@row1:    sta   $FDFD, x
         lda   CondensedRow2-$19, y
@row2:    sta   $FDFD, x
         lda   CondensedRow3-$19, y
@row3:    sta   $FDFD, x
         lda   CondensedRow4-$19, y
@row4:    sta   $FDFD, x
         lda   CondensedRow5-$19, y
@row5:    sta   $FDFD, x
         lda   CondensedRow6-$19, y
@row6:    sta   $FDFD, x
         lda   CondensedRow7-$19, y
@row7:    sta   $FDFD, x
         lda   CondensedRow8-$19, y
@row8:    sta   $FDFD, x
         lda   CondensedRow9-$19, y
@row9:    sta   $FDFD, x
         inc   HTAB
         dex
         bpl   @loop
         rts

