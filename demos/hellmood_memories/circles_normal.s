; Zooming Circles, based on the code in Hellmood's Memories

; for use *not* in zero page (for appleii bot)

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
BASL		= $28
BASH		= $29
H2		= $2C
COLOR		= $30

X1		= $F8
X2		= $F9
Y1		= $FA
Y2		= $FB

TEMP		= $FC
TEMPY		= $FD
FRAME		= $FE
TEMPX		= $FF


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
BASCALC	= $FBC1
SETGR	= $FB40
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us
HLINE	= $F819

; 103 bytes

; attempted HLINE, not much help (122 bytes, slow)

; quad plot, also 122


;.globalzp squares_table_y
;.globalzp color_lookup
;.globalzp smc1,smc2,smc3,smc4

;.zeropage

zooming_circles:

	;===================
	; init screen
;	jsr	SETGR				; 3
	bit	FULLGR				; 3
						;====
						; 6
circle_forever:

	inc	FRAME				; 2

	ldx	#24				; 2
	stx	Y2				; 2
	dex					; 1

yloop:
	ldy	#20				; 2
	sty	X2				; 2
	dey					; 1

xloop:

	clc					; 1
	lda	squares_table_y+4,y		; 3
	asl					; 1
	asl					; 1
	adc	squares_table_y,x		; 2

	lsr					; 1
	adc	FRAME				; 2
	and	#$1f				; 2

; and	#$18
; 00, 10 = black
; 01  = grey 55 or aa
; 11  = light blue 77

	lsr					; 1
	lsr					; 1
	lsr					; 1
	sty	TEMPY				; 2
	tay					; 1
	lda	color_lookup,Y			; 3
	sta	COLOR				; 2

	ldy	X2	; Y==X2			; 2
	txa		; A==Y1			; 1
	jsr	PLOT	; (X2,Y1)		; 3
	lda	Y2	; A==Y2			; 2
	jsr	PLOT	; (X2,Y2)		; 3

	ldy	TEMPY	; Y==X1			; 2
	txa		; A==Y1			; 1
	jsr	PLOT	; (X1,Y1)		; 3
	lda	Y2	; A==Y2			; 2
	jsr	PLOT	; (X1,Y2)		; 3

	inc	X2				; 2

	dey					; 1
	bpl	xloop				; 2

	inc	Y2				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	circle_forever			; 2




; 24 bytes
squares_table_y:
.byte $24,$21,$1e,$1b,$19,$16,$14,$12
.byte $10,$0e,$0c,$0a,$09,$07,$06,$05
.byte $04,$03,$02,$01,$01,$00,$00

color_lookup:
.byte	$00 ; also last byte of squares table
.byte	$55,$00,$77



;.byte $00,$00,$00,$00,$01,$01,$02,$03
;.byte $04,$05,$06,$07,$09,$0a,$0c,$0e
;.byte $10,$12,$14,$16,$19,$1b,$1e,$21




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
