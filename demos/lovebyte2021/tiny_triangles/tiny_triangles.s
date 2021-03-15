GBASL		= $26
GBASH		= $27
HGRPAGE		= $E6
HGR_BITS	= $1C
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4


PAGE0	= $C054
PAGE1	= $C055

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
HPLOT0  = $F457                 ;; plot at (Y,X), (A)
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

.zeropage
.globalzp xx_smc,yy_smc

tiny:
	jsr	HGR2		; clear page1
				; A is 0 after
tiny_yloop:

;	lda	#0
;	sta	XX		; XX doesn't really matter where starts
;	sta	YY		; start at top of screen

tiny_xloop:
	txa
;	lda	xx_smc+1
	and	yy_smc+1
	beq	store_color

	lda	#$7f
store_color:
	sta	HGR_COLOR

	ldy	#0
;xx_smc:
;	ldx	#0
yy_smc:
	lda	#0

	jsr	HPLOT0		; plot at (Y,X), (A)
				; at begin, stores A to HGR_Y
				;           X to HGR_X and Y to HGR_X+1
				; destroys X,Y,A
				; Y is XX/7

	ldx	HGR_X
	inx
;	inc	xx_smc+1
	bne	tiny_xloop

	inc	yy_smc+1
	bne	tiny_xloop

	; should we over-write brk handler to restart?
