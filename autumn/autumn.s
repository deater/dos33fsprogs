; Autumn, based on the code in Hellmood's Autumn

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
BASL		= $28
BASH		= $29
H2		= $2C
;COLOR		= $30

XCOORDL		= $F0
XCOORDH		= $F1
YCOORDL		= $F2
YCOORDH		= $F3
EBP1		= $F4
EBP2		= $F5
EBP3		= $F6
EBP4		= $F7
COLORL		= $F8
COLORH		= $F9

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

HGR2	= $F3D8
HPLOT0	= $F457		; (Y,X) = Horizontal, (A=Vertical)
HCOLOR  = $F6EC		; color in x, must be 0..7

autumn:

	;===================
	; init screen
	jsr	HGR2				; 3
	ldx	#0
	stx	XCOORDL
	stx	YCOORDL
	stx	XCOORDH
	stx	YCOORDH
	stx	EBP1
	stx	EBP2
	stx	EBP3
	stx	EBP4
	stx	COLORH

	lda	#$4f
	sta	COLORL

autumn_forever:

	clc
	rol	COLORL		; shl %ax
	rol	COLORH

	ldx	XCOORDL
	ldy	XCOORDH		; save old X

	sec
	lda	XCOORDL
	sbc	YCOORDL		; X=X-Y
	sta	XCOORDL
	lda	XCOORDH
	sbc	YCOORDH
	sta	XCOORDH

	cmp	#$80
	ror	XCOORDH		; asr X
	ror	XCOORDL

	clc
	txa
	adc	YCOORDL		; y=y+oldx
	sta	YCOORDL
	tya
	adc	YCOORDH
	sta	YCOORDH

	cmp	#$80
	ror	YCOORDH		; asr Y
	ror	YCOORDL

	; 32 bit rotate of low bit of Y
	ror	EBP1
	ror	EBP2
	ror	EBP3
	ror	EBP4		; ror bottom bit of Y through 32 bits

	bcs	label_11f

	clc
	lda	COLORL
	adc	#1
	sta	COLORL
	lda	COLORH
	adc	#0
	sta	COLORH

	clc
	lda	XCOORDL
	adc	#$80
	sta	XCOORDL		; X+=0x80
	lda	XCOORDH
	adc	#$0
	sta	XCOORDH

	sec
	lda	YCOORDL
	eor	#$FF
	adc	#$0		; Y=-Y
	sta	YCOORDL
	lda	YCOORDH
	eor	#$FF
	adc	#$0
	sta	YCOORDH

label_11f:

;	lda	COLOR
;	and	#$fc
;	eor	#$12
;	sta	COLOR

	lda	YCOORDH
	bmi	autumn_forever		; if negative, loop

	lda	XCOORDH
	and	#$f0
	bne	autumn_forever

put_pixel:
	lda	COLORL
	and	#$7
	beq	black1
	cmp	#$4
	bne	not_black2
	lda	#$5
	bne	not_black2
black1:
	lda	#$1

not_black2:
	tax
	jsr	HCOLOR

	ldx	XCOORDL
	ldy	XCOORDH
	lda	YCOORDL
	jsr	HPLOT0

	jmp	autumn_forever			; 3

