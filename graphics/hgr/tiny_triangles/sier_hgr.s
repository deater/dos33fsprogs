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
GBASL		= $26
GBASH		= $27
MASK		= $2E
COLOR		= $30
HGR_HMASK	= $30
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGR_HORIZ	= $E5

SAVEX	=	$F7
XX_TH	=	$F8
XX_TL	=	$F9
YY	=	$FA
YY_TH	=	$FB
YY_TL	=	$FC
T_L	=	$FD
T_H	=	$FE
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
MOVE_DOWN	= $F504		; clc at f504, needed?
				; f505 is applesoft entry point but assumes c?
				; move next plot location one to the right

				; note moveright/movedown respect HGR_PAGE

COLORTBL	= $F6F6


;.zeropage
;.globalzp T_L,T_H

	;================================
	; Clear screen and setup graphics
	;================================
sier:
	jsr	HGR2		; set FULLGR, sets A=0


;	lda	#0		; start with multiplier 0
	sta	T_L
	sta	T_H

sier_outer:
	lda	#$40
	sta	GBASH

	lda	#0		; YY starts at 0
	sta	YY
	sta	GBASL

	sta	YY_TL
	sta	YY_TH

	sta	YY


sier_yloop:

	lda	#$C0		; 192
	sta	HGR_HMASK

	; calc YY_T (8.8 fixed point add)
	; save space by skipping clc as it's only a slight variation w/o
;	clc
	lda	YY_TL
	adc	T_L
	sta	YY_TL
	lda	YY_TH
	adc	T_H
	sta	YY_TH

	; reset XX to 0

	ldy	#0		; y is x/7
	ldx	#0		; XX
	stx	XX_TL
	stx	XX_TH

sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
;	clc
	txa		; XX					; 2
	adc	YY_TH						; 3
	sta	SAVED						; 3

	; calc XX*T
;	clc
	lda	XX_TL						; 3
	adc	T_L						; 3
	sta	XX_TL						; 3
	lda	XX_TH						; 3
	adc	T_H						; 3
	sta	XX_TH						; 3

	; calc (YY-X_T)
	eor	#$ff						; 2
	sec							; 2
	adc	YY						; 3


	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED						; 3
							;============
							;	36


;	and	#$f8

	beq	black						; 2/3
white:
	lda	#$ff	; white					; 2
;	.byte	$2C	; bit trick
black:
								;=====
								; 4?



color_ready:
;	sta	HGR_BITS

no_shift:

	; inline HPLOT1 (starting at $F45C)
	eor	(GBASL),Y					; 5+
	and	HGR_HMASK					; 3
	eor	(GBASL),Y					; 5+
	sta	(GBASL),Y					; 6

								;=======
								; 19
; inline MOVE_RIGHT

	lda	HGR_HMASK	; get mask			; 3
	asl			; adjust			; 2
	eor	#$80		; toggle top bit		; 2
	bmi	lr_1		; if set, done?			; 3/2
	lda	#$81		; otherwise set to $81		; 2
	iny			; and move to next mult of 7	; 2

				; no need to check for
				; right boundary
				; as we do that separately

lr_1:
	sta	HGR_HMASK					; 3
								;======
								; 16


	;==================================
	inx							; 2
	bne	sier_xloop					; 3/2


			;=================
			; total roughly 36+4+19+16+5 = 80
			; 49152 per inside *80 = 3,932,160
			;	apple II cyles/frame = 17,030
			; 1FPS = 1,021,800


	;==================================

	jsr	MOVE_DOWN	; X/Y left alone

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

;flip_pages:
;	TODO if frame rate ever gets fast enough

	jmp	sier_outer	; what can we branch on?



