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
BASL		= $28
BASH		= $29
MASK		= $2E
COLOR		= $30
HGR_HMASK	= $30
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGR_HORIZ	= $E5
HGR_SCALE	= $E7

DRAW_PAGE	= $04
FRAME		= $05
SEVEN		= $06
NEXTCOL		= $07
XX_TH		= $08
XX_TL		= $09
YY		= $0A
YY_TH		= $0B
YY_TL		= $0C
T_L		= $0D
T_H		= $0E
SAVED		= $0F

; Soft switches
FULLGR	= $C052
PAGE1	= $C054
PAGE2	= $C055

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

XDRAW0		= $F65D
COLORTBL	= $F6F6
BASCALC		= $FBC1
HOME		= $FC58
CLREOLZ		= $FC9E		; clear (BASL),Y to end of line

XT_LOOKUP_TABLE	= $1000
YT_LOOKUP_TABLE = $1100

;.zeropage
;.globalzp T_L,T_H

	;================================
	; Clear screen and setup graphics
	;================================
sier:
	jsr	HGR		; returns with A=0

	sta	T_L		; start with multiplier 0
	sta	T_H


	;=============================

sier_outer:

	ldx	#24
	jsr	xdraw_desire	; draw desire

	ldx	#216
	jsr	xdraw_desire	; draw desire


	ldx	#0		; get X 0 for later
	stx	YY		; YY starts at 0

	; create XX_T and YY_T lookup tables

	stx	XX_TL		; always start at 0
	stx	XX_TH

	; calc XX*T
	; only really care about XX_TH
xt_table_loop:
	clc							; 2
	lda	XX_TL						; 3
	adc	T_L						; 2
	sta	XX_TL						; 3

	lda	XX_TH						; 3
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

	; set initial position on screen at line 32

	lda	#$0		;
	sta	GBASL

	lda	#$20		; start on page2 line 32 ($4200)
	sta	GBASH

sier_yloop:

	; GBASH is in A here

;	lda	GBASH		; update output pointer
	sta	gb_smc+2

	lda	GBASL		; adjust so centered
	clc
	adc	#10
	sta	gb_smc+1

	; YY*T only needs to be updated once per line
	; so do it here and then self-modify into place

	ldx	YY				; 3
	stx	add_yy_smc+1			; 4
	lda	YT_LOOKUP_TABLE,X		; 4
	sta	yy_th_smc+1			; 4

	; reset XX to 0

	ldx	#0		; XX

seven_loop:
	ldy	#7		; apple ii 7 pixels per byte

sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
	clc			; needed for proper colors	; 2
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
	sta	$4000		; write to hi-res display	; 4
	inc	gb_smc+1	; increase GBASL		; 6

	cpx	#124						; 2
	bcc	seven_loop					; 3/2


			;=================
			; total roughly ???
			; full screen each inner cycle is done 256*192 = 49152
			;	apple II cyles/frame = 17,030
			; 1FPS = 1,021,800


	;==================================

	jsr	MOVE_DOWN	; ROM routine to skip the next line
				; as this is non-trivial on Apple II
				; X/Y left alone
				; returns with GBASH in A

	inc	YY		; repeat until YY=128
	bpl	sier_yloop

;flip_pages:
;	TODO if frame rate ever gets fast enough


	ldx	#24
	jsr	xdraw_desire	; erase desire

	ldx	#216
	jsr	xdraw_desire	; erase desire

	inc	FRAME



;===============
        ; clear screen

	jsr	HOME

;        ldx     #24
;clear_screen_loop:
 ;       txa
  ;      jsr     BASCALC         ; A is BASL at end
   ;     lda     BASH
    ;    clc
;        adc     DRAW_PAGE
 ;       sta     BASH

  ;      ldy     #0
   ;     jsr     CLREOLZ
    ;    dex
;	cpx	#20
;	bne     clear_screen_loop



	ldy     #39
text_loop:

        tya                     ; get YY to print at
;       clc
;       adc     FRAME
        and     #$f
        tax

        lda     cosine,X        ; get cosine value
        jsr     BASCALC         ; convert to BASL/BASH

;        lda     BASH            ; add so is proper page
 ;       clc
  ;      adc     DRAW_PAGE
   ;     sta     BASH

        tya                     ; lookup char to print
        clc
        adc     FRAME
        and     #$f
        tax

;       lda     apple,X
        lda     $FB09,X         ; 8 bytes of apple II
        cpx     #8
        bcc     blah2
;       ora     #$80
        lda     #$a0
blah2:
        sta     (BASL),Y        ; print it

        dey                     ; loop
        bpl     text_loop



	jmp	sier_outer	; branch always


cosine:
	.byte 23,23,23,22,22,21,20,20,20,20,20,21,21,22,23,23

shape_dsr:
.byte   $2d,$36,$ff,$3f
.byte   $24,$ad,$22,$24,$94,$21,$2c,$4d
.byte   $91,$3f,$36,$00


	;=======================
        ; xdraw desire
        ;=======================

xdraw_desire:


        ; setup X and Y co-ords

        ldy     #0              ; XPOSH always 0 for us
         lda     #20
        jsr     HPOSN           ; X= (y,x) Y=(a)


	lda	#3
	sta	HGR_SCALE

shape_smc:
        ldx     #<shape_dsr	  ; point to our shape
xdraw_custom_shape:
        ldy     #>shape_dsr	 ; code fits in one page so this doesn't change

rot_smc:
        lda     FRAME         ; set rotation
	and	#$f		; necessary?
	asl
	asl

	; for scale 2 only 8 positions

blah:
        jmp     XDRAW0          ; XDRAW 1 AT X,Y
                                ; Both A and X are 0 at exit

