; Zooming Circles, based on the code in Hellmood's Memories

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
COLOR		= $30
TEMP		= $FA
TEMPY		= $FB
FRAME		= $FC
XSAVE		= $FD

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE0	= $C054 ; Page0
PAGE1	= $C055 ; Page1
LORES	= $C056	; Enable LORES graphics

; ROM routines

PLOT	= $F800	; plot, horiz=y, vert=A (A trashed, XY Saved)
SETCOL	= $F864
TEXT	= $FB36				;; Set text mode
SETGR	= $FB40
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us


; 103 bytes

.globalzp squares_table_y
.globalzp color_lookup

.zeropage

zooming_circles:

	;===================
	; init screen
	jsr	SETGR				; 3
	bit	FULLGR				; 3
						;====
						; 6
circle_forever:

	inc	FRAME				; 2
	ldx	#23				; 2
						;===
						; 4
yloop:
	ldy	#19				; 2
xloop:

	clc					; 1
	lda	squares_table_y+4,y		; 3
	asl					; 1
	asl					; 1
	adc	squares_table_y,x		; 3

	lsr					; 1
	adc	FRAME				; 2
	and	#$1f				; 2

	lsr					; 1
	lsr					; 1
	lsr					; 1
	stx	XSAVE				; 2
	tax					; 1
	lda	color_lookup,X			; 3
	sta	COLOR				; 2
	ldx	XSAVE				; 2

	txa					; 1
	jsr	PLOT				; 3



	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	circle_forever			; 2



color_lookup:
	.byte $00,$55,$00,$77


; 48 bytes
squares_table_y:
;.byte $24,$21,$1e,$1b,$19,$16,$14,$12
;.byte $10,$0e,$0c,$0a,$09,$07,$06,$05
;.byte $04,$03,$02,$01,$01,$00,$00,$00

.byte $00,$00,$00,$00,$01,$01,$02,$03
.byte $04,$05,$06,$07,$09,$0a,$0c,$0e
.byte $10,$12,$14,$16,$19,$1b,$1e,$21




; 40 bytes
;squares_table_x:
;.byte $71,$6a,$64,$5d,$57,$51,$4b,$45
;.byte $40,$3a,$35,$31,
;.byte $2c,$28,$24,$20
;.byte $1c,$19,$15,$12,$10,$0d,$0b,$09
;.byte $07,$05,$04,$02,$01,$01,$00,$00
;.byte $00,$00,$00,$01,$01,$02,$04,$05
;.byte $07,$09,$0b,$0d,$10,$12,$15,$19
;.byte $1c,$20,$24,$28 ;,$2c,$31,$35,$3a
;;.byte $40,$45,$4b,$51,$57,$5d,$64,$6a
