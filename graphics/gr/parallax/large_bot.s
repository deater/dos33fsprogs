
; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL		= $26
GBASH		= $27
H2		= $2C
COLOR		= $30


X2		= $FB
COLORS		= $FC
FRAME		= $EA		; also a nop
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

	;========================
	; update directions

	lda	FRAME

	lsr
	lsr
	lsr
	lsr
	lsr
	and	#$3

	tax
	lda	colors,X
	sta	COLORS

	lda	dir_horiz_lookup,X
	sta	horiz_smc
	lda	dir_vert_lookup,X
	sta	vert_smc


	;==========================
	; flip page

	lda	PAGE			; if disp page == 0 (page1)
	pha				;	make draw_page1, disp_page2
					; if displ_page == 4 (page2)
	lsr				;	make draw_page2, disp_page1
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

	; calculate color

	; color = (XX-FRAME)^(YY)

	sec			; subtract frame from Y
	tya

horiz_smc:
	adc	FRAME

	sta	X2

	txa

vert_smc:
	adc	FRAME

	eor	X2
	and	#$4

	beq	clear_it

	lda	COLORS
	bne	done_set_color
clear_it:
	lda	#$0
done_set_color:

	sta	(GBASL),Y

	dey					; 1
	bpl	xloop				; 2

	dex					; 1

	bpl	yloop				; 2

	bmi	boxes_forever			; 2

	; 00 = right
	; 01 = up
	; 10 = left
	; 11 = down
	; adc = $65
	; sbc = $E5
dir_horiz_lookup:
	.byte $65,$EA,$E5,$EA
dir_vert_lookup:
	.byte $EA,$E5,$EA,$65
colors:
	.byte $1B,$26,$4C,$9D

; for bot
	; 3F5 - 111 = 6F = 386

	jmp	boxes
