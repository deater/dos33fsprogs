; parallax hgr

; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL		= $26
GBASH		= $27
H2		= $2C
COLOR		= $30

HGR_X           = $E0
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_HORIZ       = $E5
HGR_PAGE	= $E6

X2		= $FB
FRAME		= $FC


; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE1	= $C054 ; Page1
PAGE2	= $C055 ; Page2
LORES	= $C056	; Enable LORES graphics

; ROM routines

HGR     = $F3E2
HGR2    = $F3D8
HCLR    = $F3F2
HPLOT0  = $F457                 ;; plot at (Y,X), (A)
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us
HPOSN          = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)



boxes:

	;===================
	; init screen

	jsr	HGR2

boxes_forever:

	inc	FRAME

	; flip page

	lda	HGR_PAGE		; $40 or $20
	pha
	asl
	asl
	rol
	tay
	lda	PAGE1,Y
	pla

	eor	#$60			; flip draw_page
	sta	HGR_PAGE

	ldx	#191			; init Y

yloop:
	txa

	pha
	jsr	HPOSN
	pla

	tax

	ldy	#39				; 2
xloop:

	; calculate color

	; color = (XX-FRAME)^(YY)
	lda	#$00
	sta	COLOR

	sec			; subtract frame from Y
	tya
	sbc	FRAME
	sta	X2

	txa
	lsr
	lsr

	eor	X2

	and	#$04
	beq	no_color
	lda	#$ff
	sta	COLOR

no_color:
	lda	COLOR
	sta	(GBASL),Y

	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	cpx	#$ff

	bne	yloop				; 2

	beq	boxes_forever			; 2


; for bot
;	jmp	boxes
