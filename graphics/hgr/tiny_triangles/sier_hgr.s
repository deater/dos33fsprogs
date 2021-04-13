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
;	only write 1/7 of time	roughly  3s / frame
;	only draw 128 lines	roughly  2s / frame

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

SEVEN	=	$F6
NEXTCOL	=	$F7
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
	lda	#$42		; start on page2 line 32 ($4200)
	sta	GBASH

	lda	#$1		; center
	sta	GBASL

	ldx	#0		; get X 0 for later
	stx	YY		; YY starts at 0

	; create XX_T lookup table
	; note, same as YY_T lookup table?

	stx	XX_TL		; start at 0
	stx	XX_TH

	; calc XX*T
	; only really care about XX_TH
xt_table_loop:
	clc							; 2
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


	; inc T
;	clc
	lda	T_L
speed_smc:
	adc	#2
	sta	T_L
	bcc	no_carry
	inc	T_H
no_carry:

	; speed up the zoom as it goes
	inc	speed_smc+1




sier_yloop:

	ldx	YY				; 3
	stx	add_yy_smc+1			; 4
	lda	YT_LOOKUP_TABLE,X		; 4
	sta	yy_th_smc+1			; 4

	; reset XX to 0

	ldx	#0		; XX

seven_loop:
	ldy	#7

sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
	clc			; needed for colors		; 2
	txa		; XX					; 2
yy_th_smc:
	adc	#$dd						; 2
	sta	SAVED						; 3

	lda	XT_LOOKUP_TABLE,X	; ~(XX*T)		; 4
	; calc (YY-XX*T)
	sec							; 2
add_yy_smc:
	adc	#$dd						; 2

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED						; 3
							;============
							;	20

	clc							; 2
	beq	black						; 2/3
white:
	sec							; 2
black:
								;=====
								; 5/6


	ror	NEXTCOL		; rotate in next bit		; 5

	inx			; increment x			; 2

	dey			; dec seven count		; 2
	bne	sier_xloop					; 2/3

	;===========================================================


	lda	NEXTCOL	; sign extend top bit,			; 3
	cmp	#$80	; matches earlier cool colors		; 2
	ror							; 2

gb_smc:
	sta	$4000						; 4
	inc	gb_smc+1	; increase GBASL		; 6

	cpx	#248						; 2
	bcc	seven_loop					; 3/2


			;=================
			; total roughly ???
			; 49152 per inside *80 = 3,145,728
			;	apple II cyles/frame = 17,030
			; 1FPS = 1,021,800


	;==================================

	jsr	MOVE_DOWN	; X/Y left alone
				; returns with GBASH in A

;	lda	GBASH		; update output pointer
	sta	gb_smc+2

	lda	GBASL		; adjust so centered
	clc
	adc	#$1
	sta	gb_smc+1


	inc	YY		; repeat until YY=128
	bpl	sier_yloop

;flip_pages:
;	TODO if frame rate ever gets fast enough

	bmi	sier_outer	; branch always


	; $386, want to be at $3F5
	; load at $36F???

;	jmp	sier
