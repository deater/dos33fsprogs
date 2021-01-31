; fake sierpinski

; 143 bytes -- sorta working


; x=0..39
;  T =0 	XX_T = 0 .. 0
;  T =1		XX_T = 0 .. 39 ($0027)
;  T =2		XX_T = 0 .. 78 ($004E)
;  T =3		XX_T = 0 .. 117 ($0075)
;  T = 128	XX_T = 0 .. 4992 ($1380)
;  T = 255	XX_T = 0 .. 9945 ($26D9)


; just plot X AND Y

;.include "zp.inc"
.include "hardware.inc"

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30
;XX	=	$F7
XX_TH	=	$F8
XX_TL	=	$F9
;YY	=	$FA
YY_TH	=	$FB
YY_TL	=	$FC
T_L	=	$FD
T_H	=	$FE
SAVED	=	$FF


	;================================
	; Clear screen and setup graphics
	;================================
sier:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

	lda	#0		; start with multiplier 0
	sta	T_L
	sta	T_H

sier_outer:

	ldx	#0		; YY
	stx	YY_TL
	stx	YY_TH

sier_yloop:

	; reset XX to 0

;	ldy	#0		; XX
;	sty	XX_TL
;	sty	XX_TH


	; calc YY_T (8.8 fixed point add)
;	clc
	lda	YY_TL
	adc	T_L
	sta	YY_TL
	lda	YY_TH
	adc	T_H
	sta	YY_TH

	txa	; YY
	lsr

	bcc	even_mask
	ldy	#$f0
	.byte	$C2	; bit hack
even_mask:
	ldy	#$0f
	sty	MASK

;	txa	;	YY
;	lsr
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	lda	GBASH


	; reset XX to 0

	ldy	#0		; XX
	sty	XX_TL
	sty	XX_TH


draw_page_smc:
	adc	#0
	sta	GBASH


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

	and	SAVED

	and	#$f0

	beq	red
black:
	lda	#00	; black
	.byte	$2C	; bit trick
red:
	lda	#$CC	; red
	sta	COLOR



;	ldy	XX

	jsr	PLOT1		; PLOT AT (GBASL),Y

	iny		;  XX
	cpy	#40
	bne	sier_xloop

	inx
	cpx	#48
	bne	sier_yloop

	; inc T
;	clc
	lda	T_L
blah_smc:
	adc	#1
	sta	T_L
	lda	T_H
	adc	#0
	sta	T_H

	; speed up the zoom
	inc	blah_smc+1

flip_pages:
	ldx	#0

	lda	draw_page_smc+1 ; DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE

	jmp	sier_outer	; just slightly too far???

	; this is at 389
	; we want to be at 3F5, so load program at 36C?
	jmp	sier		; entry point from &
