; this was a weird effect that turns out to be because we're linking
; at the wrong address so it's just the effect when
; TL/TH holds the values $A0 $A0


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

;XX	=	$F7
XX_TH	=	$F8
XX_TL	=	$F9
;YY	=	$FA
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
HPLOT0  = $F457
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETGR   = $FB40


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

;	txa	; YY			; plot call needs Y/2
;	lsr

;	php

;	bcc	even_mask
;	ldy	#$f0
;	.byte	$2C	; bit hack
;even_mask:
;	ldy	#$0f
;	sty	MASK

;	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

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
	tya	; lda YY
	sec
	sbc	XX_TH

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED

	and	#$f0

	beq	white
black:
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
	bne	sier_xloop

	iny		; YY
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

