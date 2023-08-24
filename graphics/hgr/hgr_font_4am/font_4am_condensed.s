;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - DrawCondensedString
;

; VMW: commented, reformatted, minor changes, ca65 assembly

string_ptr                = $FC      ; word (used by DrawLargeString)
tmpx                      = $FE      ; byte (used by DrawLargeCharacter, FindValidMove)
tmpy                      = $FF      ; byte (used by DrawLargeCharacter, FindValidMove)

; Y location of the 16 supported lines
CondensedHGRTops:
         .byte 7,18,29,40,51,62,73,84,95,106,117,128,139,150,161,172

;------------------------------------------------------------------------------
; DrawCondensedString
;
; in:    A/Y points to length-prefixed string (Pascal style)
;        X contains column number (0x00..0x27)
;        $25 (CV) contains logical line number (0x00..0x0F)
;        pointer is hidden
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
DrawCondensedString:

	; store the string location

	sta	string_ptr
	sty	string_ptr+1



	stx	CH			; save the X column offset

	ldy	#0
	lda	(string_ptr), Y		; get string length
	tax				; store it in X

	; 16 bit increment of string_ptr

	inc	string_ptr		; increment past the length
	bne	dcs_noflo
	inc	string_ptr+1
dcs_noflo:

	; Load updated string pointer back into Y/A
	lda	string_ptr
	ldy	string_ptr+1

         ; /!\ execution falls through here to DrawCondensedBuffer

;------------------------------------------------------------------------------
; DrawCondensedBuffer
;
; in:    A/Y contains address of character buffer (characters 0x19+ only)
;        X contains buffer length (0x01..0x28)
;        $24 (CH) contains starting column (0x00..0x27)
;        $25 (CV) contains logical line number (0x00..0x0F)
;        all characters are drawn on the same line
;        CH is incremented for each character
;        CV is NOT incremented
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
DrawCondensedBuffer:

	sta	dcb_loop_smc+1			; save string address
	sty	dcb_loop_smc+2			; to smc location

	dex					; ?

	ldy	CV				; lookup y-coord location
	lda	CondensedHGRTops, Y		; using lookup table
	tay					;

	; row0

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_row0+4
	lda	hposn_high, Y			; get high memory offset
	sta	dcb_row0+5			; save it out
	iny					; go to next row

	; row1

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row1+4
	lda	hposn_high, Y
	sta	dcb_row1+5
	iny

	; row2

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row2+4
	lda	hposn_high, Y
	sta	dcb_row2+5
	iny

	; row3

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row3+4
	lda	hposn_high, Y
	sta	dcb_row3+5
	iny

	; row4

	lda   hposn_low, Y
	adc   CH
	sta   dcb_row4+4
	lda   hposn_high, Y
	sta   dcb_row4+5
	iny

	; row5

	lda   hposn_low, Y
	adc   CH
	sta   dcb_row5+4
	lda   hposn_high, Y
	sta   dcb_row5+5
	iny

	; row6

	lda   hposn_low, Y
	adc   CH
	sta   dcb_row6+4
	lda   hposn_high, Y
	sta   dcb_row6+5
	iny

	; row7

	lda   hposn_low, Y
	adc   CH
	sta   dcb_row7+4
	lda   hposn_high, Y
	sta   dcb_row7+5
	iny

	; row8

	lda   hposn_low, Y
	adc   CH
	sta   dcb_row8+4
	lda   hposn_high, Y
	sta   dcb_row8+5
	iny

	; row9

	lda   hposn_low, Y
	adc   CH
	sta   dcb_row9+4
	lda   hposn_high, Y
	sta   dcb_row9+5

dcb_loop:
dcb_loop_smc:
	ldy	$FDFD, X		; load next char into Y
					; note we are going backward

	; unrolled loop to write out each line

dcb_row0:
	lda   CondensedRow0-$19, Y		; get 1-byte font row
	sta   $FDFD, X				; write out to graphics mem
dcb_row1:
	lda   CondensedRow1-$19, Y
	sta   $FDFD, X
dcb_row2:
	lda   CondensedRow2-$19, Y
	sta   $FDFD, X
dcb_row3:
	lda   CondensedRow3-$19, Y
	sta   $FDFD, X
dcb_row4:
	lda   CondensedRow4-$19, Y
	sta   $FDFD, X
dcb_row5:
	lda   CondensedRow5-$19, Y
	sta   $FDFD, X
dcb_row6:
	lda   CondensedRow6-$19, Y
	sta   $FDFD, X
dcb_row7:
	lda   CondensedRow7-$19, Y
	sta   $FDFD, X
dcb_row8:
	lda   CondensedRow8-$19, Y
	sta   $FDFD, X
dcb_row9:
	lda   CondensedRow9-$19, Y
	sta   $FDFD, X


	; increment to next char
	inc	CH			; not-needed for the routine
					; I guess auto-points to next string

	; decrement number of characters
	dex				; we're traversing backward
	bpl   dcb_loop

	rts

