; this is a pretty effect during sierpinski zoom
; accidentally discovered when loading at the wrong address
; so TL/TH was on text page1 and full of $a0 (space characters) in TL/TH

; sierpinski-like demo
; based on the code from Hellmood's Memories demo

; by Vince `deater` Weaver <vince@deater.net>

; zero page

HGR_BITS	= $1C
GBASH		= $27
MASK		= $2E
COLOR		= $30
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4

;XX	=	$F7
XX_TH	=	$F8
XX_TL	=	$F9
;YY	=	$FA
YY_TH	=	$FB
YY_TL	=	$FC
FRAME	=	$FD
SAVED	=	$FF

; Soft switches
FULLGR	= $C052
PAGE1	= $C054
PAGE2	= $C055
LORES	= $C056		; Enable LORES graphics

; ROM routines
HGR	= $F3E2
HGR2	= $F3D8
HPLOT0  = $F457
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETGR   = $FB40
WAIT    = $FCA8                 ; delay 1/2(26+27A+5A^2) us

	;================================
	; Clear screen and setup graphics
	;================================
rainbow_squares:
	jsr	HGR		; set FULLGR, sets A=0,Y=0
	sta	FRAME		; init frame

rainbow_outer:
	; Y=0 from both paths

;	ldy	#0		; YY starts at 0

	sty	YY_TL
	sty	YY_TH

rainbow_yloop:

	; calc YY_T (8.8 fixed point add)
	; save space by skipping clc as it's only a slight variation w/o
;	clc
	lda	YY_TL
	adc	T_L
	sta	YY_TL
	lda	YY_TH
	adc	#$A0		; T_H
	sta	YY_TH

	; reset XX to 0

	ldx	#0		; XX
	stx	XX_TL
	stx	XX_TH

rainbow_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
;	clc
	txa		; XX
	adc	YY_TH
	sta	SAVED


	; calc XX*T
;	clc
	lda	XX_TL
	adc	T_L
	sta	XX_TL
	lda	XX_TH
	adc	#$A0		; T_H
	sta	XX_TH


	; calc (YY-X_T)
	tya	; lda YY
	sec
	sbc	XX_TH

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED

	and	#$f0

	beq	white
black:
	bit	$C030
	lda	#00	; black
	.byte	$2C	; bit trick
white:
	lda	#$ff	; green
	sta	HGR_COLOR


	tya			; YY in A
	ldy	#0
				; XX in X

	jsr	HPLOT0		; plot at (Y,X), (A)
                                ; at begin, stores A to HGR_Y
                                ;           X to HGR_X and Y to HGR_X+1
                                ; destroys X,Y,A
                                ; Y is XX/7


	ldy	HGR_Y
	ldx	HGR_X

	inx		; XX
	cpx	#255
	bne	rainbow_xloop

	iny		; YY
	cpy	#192
	bne	rainbow_yloop

	; inc T
	inc	T_L

;	clc
;	lda	T_L
;blah_smc:
;	adc	#1
;	sta	T_L
;	bcc	no_carry
;	inc	T_H
;no_carry:

	; done frame



	inc	FRAME
	lda	FRAME
	cmp	#2
	beq	really_done

	jsr	HGR2
	; A/Y=0

	beq	rainbow_outer	; what can we branch on?

really_done:

	bit	PAGE1

	lda	#200
	jsr	WAIT

	bit	PAGE2

	lda	#200
	jsr	WAIT

	beq	really_done	; bra



T_L:	.byte $A0


