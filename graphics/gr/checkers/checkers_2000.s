; Checkers

; loading from LOGO so random stuff we got to do

; vaguely based on a scene in Hellmood's Memories

; 32 bytes, for Lovebyte 2021

; by deater (Vince Weaver) <vince@deater.net>

; 42 -- original
; 39 -- not fullscreen
; 36 -- now marches oddly
; 32 -- colors now rainbow

; Zero Page
BASL		= $28
BASH		= $29
H2		= $2C
COLOR		= $30

X1		= $F0
X2		= $F1
Y1		= $F2
Y2		= $F3

TEMP		= $FA
TEMPY		= $FB
FRAME		= $FC
TEMPX		= $FD


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


;.zeropage

checkers:

	;===================
	; init screen

	lda	$C082			; Disable language card

;	jsr	SETGR				; 3
;	bit	FULLGR				; 3

checkers_forever:

	inc	FRAME				; 2

	ldx	#39				; 2
yloop:
	ldy	#39				; 2
xloop:

	; calculate color

	; color = (XX-FRAME)^(A)   | DB+1

;	sec			; subtract frame from Y
	tya
	sbc	FRAME
	sta	X2

	txa
;	sbc	#0

	eor	X2

;	ora	#$DB	; needed for solid colors
;	adc	#1

	jsr	SETCOL

	txa		; A==Y1			; 1
	jsr	PLOT	; plots in (Y,A)	; 3

	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	checkers_forever		; 2

