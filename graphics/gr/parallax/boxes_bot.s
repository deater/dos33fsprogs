
; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL		= $26
GBASH		= $27
H2		= $2C
COLOR		= $30

X2		= $FB
FRAME		= $FC
PAGE		= $FD

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE1	= $C054 ; Page1
PAGE2	= $C055 ; Page2
LORES	= $C056	; Enable LORES graphics

; ROM routines

PLOT	= $F800	; plot, horiz=y, vert=A (A trashed, XY Saved)
SETCOL	= $F864
GBASCALC= $F847         ;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

SETGR	= $FB40
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us
HLINE	= $F819



boxes:

	;===================
	; init screen
	jsr	SETGR				; 3
	bit	FULLGR				; 3

	lda	#$0
	sta	PAGE

boxes_forever:

	inc	FRAME				; 2

	ldx	#23				; 2

	; flip page

	lda	PAGE
	pha

	lsr
	lsr
	tay
	lda	PAGE1,Y

	pla

	eor	#$4
	sta	PAGE

yloop:
	txa
	jsr	GBASCALC
	lda	GBASH
	clc
	adc	PAGE
	sta	GBASH

	ldy	#39				; 2
xloop:

	; calculate color

	; color = (XX-FRAME)^(A)   | DB+1

	sec			; subtract frame from Y
	tya
	sbc	FRAME
	sta	X2

	txa

	and	#$Fc

	eor	X2


;	jsr	SETCOL

	sta	(GBASL),Y

	dey					; 1
	bpl	xloop				; 2

	dex					; 1

	bpl	yloop				; 2

	bmi	boxes_forever			; 2


; for bot
	; want this to be at 3F5-62 = 3B7???

	jmp	boxes
