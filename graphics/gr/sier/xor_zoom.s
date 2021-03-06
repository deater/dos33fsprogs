; zooming xor

; based on the zooming and (sierpinski) sier.s from lovebyte2021
; 	which was based on Hellmood's Memories demo

; by Vince `deater` Weaver <vince@deater.net>


; zero page

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30

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
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL  = $F864                 ;; COLOR=A
SETGR   = $FB40


;.zeropage
;.globalzp T_L,T_H

	;================================
	; Clear screen and setup graphics
	;================================
xor_zoom:
	jsr	HGR2		; set FULLGR, sets A=0
				; be sure to avoid code at E6 if we do this
	bit	LORES		; drop down to lo-res

;	lda	#0		; start with multiplier 0
;	sta	T_L
;	sta	T_H

sier_outer:

	ldx	#0		; YY starts at 0

	stx	YY_TL
	stx	YY_TH

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

	txa	; YY			; plot call needs Y/2
	lsr

	php

;	bcc	even_mask
;	ldy	#$f0
;	.byte	$2C	; bit hack
;even_mask:
;	ldy	#$0f
;	sty	MASK

	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	lda	GBASH
draw_page_smc:
	adc	#0
	sta	GBASH		 ; adjust for PAGE1/PAGE2 ($400/$800)

	plp
	jsr	$f806		; trick to calculate MASK by jumping
				; into middle of PLOT routine

	; reset XX to 0

	ldy	#0		; XX
	sty	XX_TL
	sty	XX_TH

sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
;	clc
	tya		; XX
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
	txa	; lda YY
	sec
	sbc	XX_TH

	; want (YY-(XX*T)) & (XX+(YY*T)


	;=================
	; magic is here

	eor	SAVED


	;=================
	; blah



;	and	#$f0

;	beq	green
;black:
;	lda	#00	; black
;	.byte	$2C	; bit trick
;green:
;	lda	#$CC	; green
;	sta	COLOR

	jsr	SETCOL

	; XX value already in Y

	jsr	PLOT1		; PLOT AT (GBASL),Y

	iny		; XX
	cpy	#40
	bne	sier_xloop

	inx		; YY
	cpx	#48
	bne	sier_yloop

	; inc T
;	clc
	lda	T_L
blah_smc:
	adc	#2
	sta	T_L
	bcc	no_carry
	inc	T_H
no_carry:

	; speed up the zoom as it goes
;	inc	blah_smc+1


	; x is 48
flip_pages:
	lda	draw_page_smc+1 ; DRAW_PAGE
	beq	done_page
	inx
done_page:
	; X=48 ($30)	PAGE1=$C054-$30=$C024
	ldy	$C024,X		; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE

	jmp	sier_outer	; what can we branch on?

T_L:	.byte $80
T_H:	.byte $00

	; this is at beginning+$79, want it to be at $3F5 so $37C?
	;   1
	; $3F5
	; - 79
	;======
	;  37C
	jmp	xor_zoom
