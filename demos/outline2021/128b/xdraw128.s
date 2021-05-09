; XDRAW128
;	128b intro for outline 2021
;
; by Vince `deater` Weaver <vince@deater.net>
;	dSr


; things to try
;	clear to "other" black would mean blue/orange instead of green/purple
;	offset starting point by one to change color
; would love a DSR logo in the middle of the circle but that would
;	cost ~20 bytes


; goal is 128
; 142: first round
; 141: massive re-write for common XDRAW
; 137: shave a few bytes off on first half (no clc, note X is 0 after xdraw)
; 131: last part using common XDRAW
; 130: add center_y0

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
HGR_BITS	=	$1C
GBASL		=	$26
GBASH		=	$27
A5H		=	$45
XREG		=	$46
YREG		=	$47
HGR_SCALE	=	$E7
HGR_ROT		=	$F9
FRAME		=	$FC
XPOS		=	$FD
YPOS		=	$FF

; ROM calls
HGR2		=	$F3D8
HCLR		=	$F3F2	; clear to 0
HCLR2		=	$F3F4	; clear to A
BKGND		=	$F3F6	; clear to HGR_BITS
HPOSN		=	$F411
XDRAW0		=	$F65D	; shape table in Y:X
RESTORE		=	$FF3F

xdraw128:

	;=====================
	; setup graphics mode
	;=====================


	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call


	sta	FRAME		; set frame to 0
	sta	HGR_ROT		; rotation 0

	;======================
	; do circle intro
	;	put dSr logo in it?
	;	that would be like 16 more bytes :(
	;======================

circle:

	lda	#40
	sta	HGR_SCALE

circle_loop:
	inc	HGR_ROT

	jsr	center

	ldx	#<shape_table	; point to our shape
	ldy	#>shape_table

	jsr	common_xdraw

	bne	circle_loop	; we dec frame in common_xdraw



	;===================================
	; Lightning
	;===================================



lightning:

	; in theory X is 0 here?

;	lda	#1
;	sta	HGR_SCALE

	inx
	stx	HGR_SCALE


lightning_loop:

	jsr	center

	ldx	#$4		; we use $D004 - $F004 as shape tables

	inc	HGR_ROT		; rotate

	lda	HGR_ROT		; ROT value
	ora	#$d0		; set to either $DX or $FX ???
	tay


;	lda	HGR_ROT		; ROT value
;	and	#$1f		; wrap to 32
;;	clc
;	adc	#208		; $D0
;	ora	#$d0
;	tay			; set high shape table to (ROT%32)+208

	jsr	common_xdraw

	bne	lightning_loop


	;===================================
	; Tiny Xdraw
	;===================================

tiny_xdraw:



	lda	#$20
	sta	HGR_SCALE	; can get rid of if load in zero page

	; in theory X=0 on entry

;	ldx	#0
	txa
;	tay
	jsr	center_y0	; start at co-ords 0,0




tiny_loop:
	;	F0	01 = cool, let's go with it
	ldx	#$01	; point to bottom byte of shape address
	ldy	#$f0	; point to top byte of shape address

	; ROT should be 0?

	jsr	common_xdraw
	bne	tiny_loop



	;===================================
	; More Xdraw
	;===================================

more_xdraw:


outer_more_loop:

	lda	#64
	sta	FRAME

color_smc:
	lda	#$80
	jsr	HCLR2

more_loop:

more_smc:
	ldx	#$4d	; point to bottom byte of shape address
	ldy	#$d3	; point to top byte of shape address

	jsr	common_xdraw
	bne	more_loop

	lda	color_smc+1		; 3+2+3
	eor	#$80			; if zp =2+2+2+2
	sta	color_smc+1

	inc	more_smc+1		; move to next pattern
	lda	more_smc+1
	cmp	#$60
	bcc	outer_more_loop

	inc	HGR_ROT			; increase rotation

	lda	#$4d			; reset shapetable pointer
	sta	more_smc+1

	bne	outer_more_loop		; bra



	; 9 + 9 if inlined (18)
	; 3 + 3 + 10 as function (16)
center:
	; setup X and Y co-ords
	ldx	#140
	lda	#96
center_y0:
	ldy	#0		; Y always 0
	jsr	HPOSN		; X= (y,x) Y=(a)
	rts


common_xdraw:

	lda	HGR_ROT		; rotation
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit

	dec	FRAME

	rts

shape_table:
	.byte $3A,$DB,$0	; shape data accidentally found at addr $0004

