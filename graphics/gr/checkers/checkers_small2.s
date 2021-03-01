; Checkers, based on the code in Hellmood's Memories

; 42 bytes
; could be shorter if you're not picky about colors

; by deater (Vince Weaver) <vince@deater.net>

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


.zeropage

; orig = 42
; make 32x32

checkers:

	;===================
	; init screen
	jsr	SETGR				; 3
;	bit	FULLGR				; 3
						;====
						; 6
checkers_forever:

	inc	FRAME				; 2

	ldx	#39				; 2
yloop:
	ldy	#39				; 2
xloop:
	sec					; 1
	tya					; 1
	sbc	FRAME				; 2
	sta	X2				; 2
	txa					; 1
	sbc	#0				; 2

	eor	X2				; 2
	ora	#$DB				; 2
	adc	#1				; 2

	sta	COLOR

;	jsr	SETCOL				; 3

	txa		; A==Y1			; 1
	jsr	PLOT	; (X2,Y1)		; 3

	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	checkers_forever		; 2

