GBASL		= $26
GBASH		= $27
HGRPAGE		= $E6
HGR_BITS	= $1C
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGR_HORIZ	= $E5

SAVEX		= $FD
TEMP		= $FE
OLD		= $FF

PAGE0	= $C054
PAGE1	= $C055

COLORTBL	=	$F6F6

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
HPOSN	= $F411
HPLOT0  = $F457                 ;; plot at (Y,X), (A)
HPLOT1	= $F45A
COLOR_SHIFT = $F47E

MOVE_RIGHT = $F48A

HCOLOR1	= $F6F0
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us


mod9_lookup = $1000


mod9_start:
	jsr	make_mod9_lookup

	jsr	HGR2		; clear page1
				; A is 0 after

tiny_yloop:

	ldy	#0
	ldx	#0		; XX = 0
yy_smc:
	lda	#0		; Y co-ord

	jsr	HPOSN		; plot at (Y,X), (A)

	ldx	#0

tiny_xloop:

	stx	SAVEX

;	jsr	HPLOT1

;===============here

	txa
	eor	yy_smc+1
	tax
	lda	mod9_lookup,X



blurgh:
	and	#$1


	tax

	tya
	lsr			; check even or odd
	php

;	jsr	HCOLOR1
	lda	COLORTBL,X
;	sta	HGR_COLOR
	sta	HGR_BITS

	plp
	bcc	no_shift

	jsr	COLOR_SHIFT	; if odd then color shift

no_shift:

;	beq	store_color

;	lda	#$7f
;store_color:
;	sta	HGR_COLOR


	jsr	HPLOT1
	jsr	MOVE_RIGHT	; trashes A

	ldx	SAVEX

	inx
	bne	tiny_xloop

	inc	yy_smc+1
	ldy	yy_smc+1
	cpy	#192
	bne	tiny_yloop

	inc	blurgh+1
	ldy	#0
	sty	yy_smc+1
	beq	tiny_yloop



make_mod9_lookup:
	ldy	#0
m9_xreset:
	ldx	#0
m9_loop:
	txa
	sta	mod9_lookup,Y
	iny
	beq	m9_done
	inx
	cpx	#9
	beq	m9_xreset
	bne	m9_loop
m9_done:
	rts
