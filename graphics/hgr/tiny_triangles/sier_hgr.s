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
;	HPLOT:			roughly 30s / frame
;	MOVERIGHT:		roughly 14s / frame
;	MOVERIGHT NO COLORSHIFT:roughly 11s / frame
;	MOVERIGHT MOVEDOWN	roughly 11s / frame
;	INLINE HPLOT		roughly  9s / frame
; 	INLINE EVERYTHING	roughly  7s / frame
;	XT/YT lookup tables	roughly  6s / frame


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

NEXTCOL	=	$F6
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

XT_LOOKUP_TABLE	= $1000
YT_LOOKUP_TABLE = $1100

;.zeropage
;.globalzp T_L,T_H

	;================================
	; Clear screen and setup graphics
	;================================
sier:
	jsr	HGR2		; set FULLGR, sets A=0

	sta	T_L		; start with multiplier 0
	sta	T_H

sier_outer:
	lda	#$40		; start on page2 ($4000)
	sta	GBASH

	ldx	#0		; get X 0 for later
	stx	YY		; YY starts at 0
	stx	GBASL		; GBASL is $00

	; create XX_T lookup table
	; note, same as YY_T lookup table?

	stx	XX_TL		; start at 0
	stx	XX_TH

	; calc XX*T
	; only really care about XX_TH
xt_table_loop:
	clc
	lda	XX_TL						; 3
tl_smc:
	adc	T_L						; 2
	sta	XX_TL						; 3
	lda	XX_TH						; 3
th_smc:
	adc	T_H						; 3
	sta	XX_TH						; 3
	sta	YT_LOOKUP_TABLE,X				; 5
	eor	#$ff		; negate, as we subtract	; 2
	sta	XT_LOOKUP_TABLE,X				; 5
	inx							; 2
	bne	xt_table_loop					; 3/2


sier_yloop:

	lda	#$C0		; 192	reset hmask at begin of line
	sta	HGR_HMASK

	ldx	YY				; 3
	lda	YT_LOOKUP_TABLE,X		; 4
	sta	yy_th_smc+1			; 4

	; reset XX to 0

	ldy	#0		; y is x/7
	ldx	#0		; XX

sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
;	clc
	txa		; XX					; 2
yy_th_smc:
	adc	#00						; 2
	sta	SAVED						; 3

	lda	XT_LOOKUP_TABLE,X	; ~(XX*T)		; 4
	; calc (YY-XX*T)
	sec							; 2
	adc	YY						; 3

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED						; 3
							;============
							;	19


;	and	#$f8
	clc							; 2
	beq	black						; 2/3
white:
	sec							; 2
black:
								;=====
								; 4?

	ror	NEXTCOL						; 5

	txa							; 2
	and	#$7						; 2
	bne	not_yet						; 2/3

	ror	NEXTCOL						; 5

	lda	NEXTCOL						; 3
	sta	(GBASL),Y					; 6
	iny							; 2

not_yet:




	;==================================
	inx							; 2
	bne	sier_xloop					; 3/2


			;=================
			; total roughly 19+4+19+16+5 = 63
			; 49152 per inside *80 = 3,145,728
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



