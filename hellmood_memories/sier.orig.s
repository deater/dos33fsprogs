; Sierpinski, based on the code in Hellmood's Memories

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
BASL		= $28
BASH		= $29
H2		= $2C
COLOR		= $30

BH		= $EF
Y1		= $F0
Y2		= $F1

NUM1L		= $F2
NUM1H		= $F3
NUM2L		= $F4
NUM2H		= $F5
RESULT0		= $F6
RESULT1		= $F7
RESULT2		= $F8
RESULT3		= $F9


TEMP		= $FA
TEMPY		= $FB
FRAMEL		= $FC
FRAMEH		= $FD
TEMPX		= $FE
SCALED		= $FF


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



sierpinksi:

	;===================
	; init screen
	jsr	SETGR				; 3
	bit	FULLGR				; 3

;	lda	#>(2048)
	lda	#0
	sta	FRAMEH
	lda	#0
	sta	FRAMEL

	jsr	init_multiply_tables

sierpinski_forever:

	ldx	#47		; yy		; 2

	inc	FRAMEL				; 2
	bne	yloop
	inc	FRAMEH

yloop:
	ldy	#39		; xx		; 2
xloop:

	; t=frame-2048 (assuming we are effect #4?)

	lda	FRAMEL
	sta	NUM1L

;	sec
	lda	FRAMEH
;	sbc	#>(2048)

	rol	NUM1L		; time<<=3, speed up by factor of 8
	rol
	rol	NUM1L
	rol
	rol	NUM1L
	rol
	sta	NUM1H

	txa			; yy*=4
	asl
	asl
	sta	NUM2L
	sta	Y1
	lda	#0
	sta	NUM2H

	jsr	multiply_u16x16		; result = Y*T

	tya
	asl
	asl
	sta	NUM2L
	lda	#0
	rol	NUM2L
	rol
	sta	NUM2H			; NUM2 = X*8

	; sign extend X

    ;    xsext=xprime*8;   // get X into DL
     ;   if (xsext&0x80*8) xsext|=0xff00*8;
      ;  else xsext&=0x00ff*8;

	clc
	lda	RESULT1
	adc	NUM2L
	sta	BH			; bh=((y*t)/256)+X

	jsr	multiply_u16x16_same_num1		; result = X*T
					; dh=RESULT1

    ;    dh=(temp>>8)&0xff;              // dh=(X*T/256)

     ;   color=(yy-dh)&bh;               // color=(Y-(X*T/256))&(Y*T/256+X)


	sec
	txa
	lda	Y1
	sbc	RESULT1
	and	BH

	and	#$f8			; thicker sierpinksi

	; if zero, color=9.  Otherwise, 0

	bne	color_black		;  leave black if not sierpinksi
	lda	#$99			; otherwise: a nice orange
	bne	color_done
color_black:
	lda	#$00
color_done:

	sta	COLOR

	txa		; A==Y1			; 1
	jsr	PLOT	; (X2,Y1)		; 3

	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	sierpinski_forever		; 2


.include "multiply_tables.s"
;.include "multiply_s16x16.s"
.include "multiply_u16x16_mod.s"

; plot is 57 cycles, so 109440 to draw screen
; 169 to cal
; 433k to draw screen (2fps?)


