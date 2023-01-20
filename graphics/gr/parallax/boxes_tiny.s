; scrolling boxes (62 bytes)

; by deater (Vince Weaver) <vince@deater.net>

; Lovebyte 2023

; Zero Page
GBASL		= $26
GBASH		= $27

X2		= $FB
FRAME		= $FC
PAGE		= $FD

; Soft Switches
FULLGR	= $C052	; Full screen, no text
PAGE1	= $C054 ; Page1
;PAGE2	= $C055 ; Page2
LORES	= $C056	; Enable LORES graphics

; ROM routines

HGR2	= $F3D8
GBASCALC= $F847         ;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

SETGR	= $FB40

.zeropage
.globalzp	page_smc

boxes:

	;===================
	; init screen

	jsr	HGR2				; set hires graphics
						; full screen, page2
						; A=0, Y=0

	bit	LORES				; switch to lores

boxes_forever:

	inc	FRAME				; increment frame

	ldx	#23				; YPos in X (0..48)

	; flip page

	lda	page_smc+1
	pha

	lsr
	lsr
	tay
	lda	PAGE1,Y

	pla

	eor	#$4
	sta	page_smc+1

yloop:
	txa
	jsr	GBASCALC			; get graphics line in GBASL/H
						; YPOS/2 in A, C clear after

	lda	GBASH				; adjust for page flip
page_smc:
	adc	#0				; start at page0
	sta	GBASH

	ldy	#39				; Xpos: 0..39
xloop:

	; calculate color for each X

	; color = (XX-FRAME)^(A)

	sec			; subtract frame from Xpos in Y
	tya
	sbc	FRAME
	sta	X2

	txa

	and	#$FC		; add border?

	eor	X2		; color in A

	sta	(GBASL),Y	; plot pixel

	dey			; count down Xpos
	bpl	xloop		; loop until done

	dex			; count down YPos
	bpl	yloop		; loop until done

	bmi	boxes_forever	; continue

