; Parallax

; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL		= $26
GBASH		= $27
H2		= $2C
COLOR		= $30

FRAME		= $EA
FRAME2		= $EB
FRAME4		= $EC

X2		= $FB
COLORS		= $FC

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



parallax:

	;===================
	; init screen
	jsr	SETGR				; 3
	bit	FULLGR				; 3

	lda	#$0
	sta	PAGE

parallax_forever:

	inc	FRAME				; 2
	lda	FRAME
	lsr
	sta	FRAME2
	lsr
	sta	FRAME4

	;========================
	; update color

	lda	FRAME

;	lsr
;	lsr
;	lsr
;	lsr
;	lsr
;	and	#$3

;	tax
;	lda	colors,X
;	sta	COLORS


	;==========================
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


	;========================
	; setup for 23 lines

	ldx	#23				; 2

yloop:

	;==============
	; point GBASL/GBSAH to current line

	txa
	jsr	GBASCALC
	lda	GBASH
	clc
	adc	PAGE
	sta	GBASH

	;==============
	; current column (work backwards)

	ldy	#39				; 2
xloop:

	lda	#0
	sta	COLORS

	; calculate colors
	; color = (XX-FRAME)^(YY)


	;===========================
	; SMALL

	sec			; subtract frame from Y
	tya

	sbc	FRAME4

	sta	X2

	txa

	eor	X2
	and	#$2

	beq	skip_color_small
	lda	#$4c
;	lda	#$1b
	sta	COLORS
skip_color_small:


	;===========================
	; MEDIUM

	sec			; subtract frame from Y
	tya

	sbc	FRAME2

	sta	X2

	txa
	clc
	adc	#1

	eor	X2
	and	#$4

	beq	skip_color_medium
	lda	#$26
	sta	COLORS
skip_color_medium:



	;===========================
	; LARGE

	sec			; subtract frame from Y
	tya

	sbc	FRAME

	sta	X2

	txa
	clc
	adc	#2

	eor	X2
	and	#$8

	beq	skip_color_large
	lda	#$1B
;	lda	#$4c
	sta	COLORS
skip_color_large:

	;========================
	; actually draw color


	lda	COLORS
	sta	(GBASL),Y


	dey					; 1
	bpl	xloop				; 2

	dex					; 1

	bpl	yloop				; 2

	bmi	parallax_forever		; 2

	; 00 = right
	; 01 = up
	; 10 = left
	; 11 = down
	; adc = $65
	; sbc = $E5




; for bot
	; $3F5 - 127 + 3  = $379

	jmp	parallax
