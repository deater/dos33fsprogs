; Tilted Plane, based on the code in Hellmood's Memories

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
BASL		= $28
BASH		= $29
H2		= $2C
COLOR		= $30

X1		= $F0
X2		= $F1
Y1		= $F2
Y2		= $F3


M1		= $F7
M2		= $F8

TEMP		= $FA
TEMPY		= $FB
FRAME		= $FC
TEMPX		= $FD
SCALED		= $FE


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

tilted_plane:



	;===================
	; init screen
	jsr	SETGR				; 3
	bit	FULLGR				; 3

	jsr	init_multiply_tables

plane_forever:

	inc	FRAME				; 2

	ldx	#47		; yy		; 2
yloop:
	ldy	#39		; xx		; 2
xloop:

;	clc
;	adc	#$10				; adjust top of screen
	lda	division,X			; scaled=((0x3d5/yy)&0xff);
						; reverse divide AL=C/Y'

	sta	M1
	sta	SCALED

	; color=((signed char)((xprime-20)&0xff))*((signed char)(scaled&0xff));
	tya
	sec
	sbc	#20
	sta	M2

	jsr	multiply_s8x8

	lda	M1

	rol
	rol	M2
	rol
	rol	M2

	lda	M2
	sta	COLOR

;	fedcba9876543210
;	        dcba9876


;        color=(color>>6)&0xff;

	sec
	lda	SCALED
	sbc	FRAME			; scaled-=frame;
	eor	COLOR			; color^=(scaled&0xff);
	and	#$1C			; color&=0x1c;   // map colors

	jsr	SETCOL

	txa		; A==Y1			; 1
	jsr	PLOT	; (X2,Y1)		; 3

	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	plane_forever			; 2


division:
	.byte $62,$59,$51,$4B,$46,$41,$3D,$39,$36,$33
	.byte $31,$2E,$2C,$2A,$28,$27,$25,$24,$23,$21
	.byte $20,$1F,$1E,$1D,$1C,$1C,$1B,$1A,$19,$19
	.byte $18,$17,$17,$16,$16,$15,$15,$14,$14,$14
	.byte $13,$13,$12,$12,$12,$11,$11,$11

.include "multiply_tables.s"
.include "multiply_s8x8.s"
.include "multiply_u8x8.s"
