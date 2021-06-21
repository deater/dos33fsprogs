GBASL		= $26
GBASH		= $27

HGR_BITS	= $1C
HGR_HMASK	= $30
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGR_HORIZ	= $E5
HGRPAGE		= $E6

SAVEX		= $FD
TEMP		= $FE
OLD		= $FF

PAGE0	= $C054
PAGE1	= $C055

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
HPOSN	= $F411
HPLOT0  = $F457                 ;; plot at (Y,X), (A)
HPLOT1	= $F45A

MOVE_RIGHT = $F48A

HCOLOR1	= $F6F0
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

tiny:
	jsr	HGR2		; clear page1
				; A is 0 after

	ldx	#3
	jsr	HCOLOR1

tiny_yloop:

	ldy	#0
	ldx	#0		; XX = 0
yy_smc:
	lda	#0		; Y co-ord

	jsr	HPOSN		; plot at (Y,X), (A)

tiny_xloop:


;	lda	(GBASL),Y
;	eor	HGR_BITS
;	and	HGR_HMASK
;	eor	(GBASL),Y
;	sta	(GBASL),Y

;	lda	HGR_BITS
;	eor	(GBASL),Y
;	and	HGR_HMASK
;	eor	(GBASL),Y
;	sta	(GBASL),Y

	jsr	HPLOT1

	jsr	MOVE_RIGHT	; trashes A

	cpy	#39
	bne	tiny_xloop

	inc	yy_smc+1
	jmp	tiny_yloop

