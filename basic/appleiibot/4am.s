PLOT    = $F800 ; plot, horiz=y, vert=A (A trashed, XY Saved)
SETCOL  = $F864
TEXT    = $FB36                         ;; Set text mode
BASCALC = $FBC1
SETGR   = $FB40
HOME    = $FC58                         ;; Clear the text screen
WAIT    = $FCA8                         ;; delay 1/2(26+27A+5A^2) us
HLINE   = $F819


bitmap:
	jsr	SETGR

	ldx	#0
bitmap_loop:
	lda	bitmap_graphic,X

	jsr	PLOT
	inx
	cpx	#120
	bne	bitmap_loop

done:
	jmp	done


bitmap_graphic:
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00
.byte	$FF,$FF,$FF,$FF,$FF
.byte	$00,$00,$00,$00,$00

