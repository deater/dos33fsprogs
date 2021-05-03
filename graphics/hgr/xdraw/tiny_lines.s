; Tiny Tiny

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
HGR_BITS	=	$1C
GBASL		=	$26
GBASH		=	$27
A5H		=	$45
XREG		=	$46
YREG		=	$47
			; C0-CF should be clear
			; D0-DF?? D0-D5 = HGR scratch?
HGR_DX		=	$D0	; HGLIN
HGR_DX2		=	$D1	; HGLIN
HGR_DY		=	$D2	; HGLIN
HGR_QUADRANT	=	$D3
HGR_E		=	$D4
HGR_E2		=	$D5
HGR_X		=	$E0
HGR_X2		=	$E1
HGR_Y		=	$E2
HGR_COLOR	=	$E4
HGR_HORIZ	=	$E5
HGR_SCALE	=	$E7
HGR_SHAPE_TABLE	=	$E8
HGR_SHAPE_TABLE2=	$E9
HGR_COLLISIONS	=	$EA
HGR_ROTATION	=	$F9
FRAME		=	$FC
XPOS		=	$FD
YPOS		=	$FF

; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
RESTORE		=	$FF3F

.zeropage
.globalzp	rot_smc

tiny_tiny:

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

;	lda	#$10
;	stx	HGR_SCALE	; loading so JSR ($20) is at scale ($E7)

;	ldy	#0		; Y already 0
;	ldx	#140
;	lda	#96
	txa
	jsr	HPOSN		; X= (y,x) Y=(a)

;	sta	GBASL
;	sta	GBASH

;	lda	#40
;	sta	HGR_SCALE

;	lda	#$46
;	sta	GBASH
;	lda	#$A8
;	sta	GBASL

	; setup X and Y co-ords
;	ldy	#0		; Y always 0
;	ldx	#140
;	lda	#96
;	jsr	HPOSN		; X= (y,x) Y=(a)
				; saves Y/X/A to HGR_Y, HGR_X, HGR_X+1

				; after, Y = X/7
				; after, y = $14 = 20, always
				; A=FF, X=F9

				; GBASL = 46A8

tiny_loop:
	inc	rot_smc+1

	ldx	#<shape_table	; point to our shape
shape_table:
	ldy	#0
rot_smc:
	lda	#0		; ROT=0
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

;shape_table:
;	.byte $A8,0	; shape data

	; 22 00 = $D

		; 30 would work

		; NUP=0 UP=4
		; NRT=1 RT=5
		; NDN=2 DN=6
		; NLT=3 LT=7

		; INVALID  00 000 000 = 00
		; NRT NUP  00 000 001 = 01
		; NDN NUP  00 000 010 = 02
		; NLT NUP  00 000 011 = 03
		; UP NUP   00 000 100 = 04
		; LT NUP   00 000 111 = 07
		; NDN NRT  00 001 010 = 0A
		; RT NRT   00 001 101 = 0D
		; NUP NLT  00 011 000 = 18
		; LT NLT   00 011 111 = 1F
		; NUP UP   00 100 000 = 20
		; UP NDN   00 100 010 = 22 ****
		; NUP RT   00 101 000 = 28
		; UP RT    00 101 100 = 2C
		; RT RT is 00 101 101 = 2D
		; LT RT is 00 101 111 = 2F   ****
		; NUP DN   00 110 000 = 30   ****
		; DN DN    00 110 110 = 36
		; NUP LT   00 111 000 = 38




		;       is 10 100 000 = UP NUP
