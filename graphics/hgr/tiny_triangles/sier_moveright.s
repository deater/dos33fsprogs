; sierpinski-like demo
; based on the code from Hellmood's Memories demo

; by Vince `deater` Weaver <vince@deater.net>

; the simple sierpinski you more or less just plot
;		X AND Y

; Hellmood's you plot something more or less like
; 	COLOR = ( (Y-(X*T)) & (X+(Y*T) ) & 0xf0
; where T is an incrementing frame value

; to get speed on 6502/Apple II we change the multiplies to
; a series of 16-bit 8.8 fixed point adds

; TODO:
;	HPLOT timing
;	MOVERIGHT timing
;	MOVERIGHT MOVEDOWN timing
;	LOOKUP TABLE timing


; zero page

HGR_BITS	= $1C
GBASH		= $27
MASK		= $2E
COLOR		= $30
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4


SAVEX	=	$F7
XX_TH	=	$F8
XX_TL	=	$F9
YY	=	$FA
YY_TH	=	$FB
YY_TL	=	$FC
;T_L	=	$FD
;T_H	=	$FE
SAVED	=	$FF

; Soft switches
FULLGR	= $C052
PAGE1	= $C054
PAGE2	= $C055
LORES	= $C056		; Enable LORES graphics

; ROM routines
HGR	= $F3E2
HGR2	= $F3D8
HPOSN		= $F411
HPLOT0		= $F457
HPLOT1		= $F45A		; skip the HPOSN call
COLOR_SHIFT	= $F47E		; shift color for odd/even Y (0..7 or 7..13)
MOVE_RIGHT	= $F48A		; move next plot location one to the right

COLORTBL	= $F6F6


;.zeropage
;.globalzp T_L,T_H

	;================================
	; Clear screen and setup graphics
	;================================
sier:
	jsr	HGR2		; set FULLGR, sets A=0


;	lda	#0		; start with multiplier 0
;	sta	T_L
;	sta	T_H

sier_outer:

	ldy	#0		; YY starts at 0
	sty	YY

	sty	YY_TL
	sty	YY_TH

sier_yloop:

	; calc YY_T (8.8 fixed point add)
	; save space by skipping clc as it's only a slight variation w/o
;	clc
	lda	YY_TL
	adc	T_L
	sta	YY_TL
	lda	YY_TH
	adc	T_H
	sta	YY_TH

	; XX in X
	; YY in YY

	ldy	#0
	ldx	#0		; XX = 0
	lda	YY		; Y co-ord
	jsr	HPOSN		; set cursor position to (Y,X), (A)

;	ldy	HGR_Y

;	lda	GBASH
;draw_page_smc:
;	adc	#0
;	sta	GBASH		 ; adjust for PAGE1/PAGE2 ($400/$800)

;	plp
;	jsr	$f806		; trick to calculate MASK by jumping
				; into middle of PLOT routine

	; reset XX to 0

	ldx	#0		; XX
	stx	XX_TL
	stx	XX_TH

sier_xloop:

	stx	SAVEX

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
	adc	T_H
	sta	XX_TH


	; calc (YY-X_T)
	lda 	YY
	sec
	sbc	XX_TH

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED

	and	#$f0

	beq	white
black:
	lda	#0	; black
	.byte	$2C	; bit trick
white:
	lda	#$ff	; white

color_ready:
;	tax

;	tya
;	lsr			; check even or odd
;	php

;	lda	COLORTBL,X
	sta	HGR_BITS

;	plp
;	bcc	no_shift

;	jsr	COLOR_SHIFT	; if odd then color shift

no_shift:

	jsr	HPLOT1		; plot at current position

	jsr	MOVE_RIGHT	; move current position right (trashes A)

	ldx	SAVEX		; restore X


	;==================================
	inx			; XX
	bne	sier_xloop

	;==================================
	inc	YY		; repeat until Y=192
	ldy	YY
	cpy	#192
	bne	sier_yloop


	; inc T
;	clc
	lda	T_L
blah_smc:
	adc	#1
	sta	T_L
	bcc	no_carry
	inc	T_H
no_carry:

	; speed up the zoom as it goes
	inc	blah_smc+1


	; x is 48
;flip_pages:
;	lda	draw_page_smc+1 ; DRAW_PAGE
;	beq	done_page
;	inx
;done_page:
	; X=48 ($30)	PAGE1=$C054-$30=$C024
;	ldy	$C024,X		; set display page to PAGE1 or PAGE2

;	eor	#$4             ; flip draw page between $400/$800
;	sta	draw_page_smc+1 ; DRAW_PAGE

	jmp	sier_outer	; what can we branch on?

T_L:	.byte $00
T_H:	.byte $00

