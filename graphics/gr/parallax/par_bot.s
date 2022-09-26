; Parallax

; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL		= $26
GBASH		= $27

FRAME		= $EA
FRAME2		= $EB
FRAME4		= $EC

X2		= $FB
COLORS		= $FC

PAGE		= $FD

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE1	= $C054 ; Page1
PAGE2	= $C055 ; Page2
LORES	= $C056	; Enable LORES graphics

; ROM routines

GBASCALC= $F847         ; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

SETGR	= $FB40
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us


parallax:

	;===================
	; init screen
	jsr	SETGR				; lores graphics
	bit	FULLGR				; full screen

	lda	#$0				; start on page1
	sta	PAGE

parallax_forever:

	inc	FRAME				; increment frame

	lda	FRAME				; also have frame/2 and frame/4
	lsr
	sta	FRAME2
	lsr
	sta	FRAME4

	;==========================
	; flip page

	lda	PAGE				; get current page
	pha					; save for later

	lsr					; switch visible page
	lsr
	tay
	lda	PAGE1,Y

	pla					; save old draw page

	eor	#$4				; toggle to other draw page
	sta	PAGE


	;========================
	; setup for 23 lines

	ldx	#23				; 23 lines (double high)

yloop:

	;==============
	; point GBASL/GBSAH to current line

	txa					; get line addr in GBASL/H
	jsr	GBASCALC
	lda	GBASH

	clc
	adc	PAGE				; adjust for page
	sta	GBASH

	;==============
	; current column (work backwards)

	ldy	#39
xloop:

	lda	#0				; default color black
	sta	COLORS

	; calculate colors
	; color = (XX-FRAME)^(YY)


	;===========================
	; SMALL

	sec					; subtract frame from Y
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


	lda	COLORS				; store out pixel
	sta	(GBASL),Y


	dey					; loop for X-coord
	bpl	xloop				;

	dex					; loop for Y-coord

	bpl	yloop				;

	bmi	parallax_forever		; bra

; for bot
	; $3F5 - 125 + 3  = $37B

	jmp	parallax
