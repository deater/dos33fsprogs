; Tiny Tiny

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
HGR_BITS	=	$1C
GBASL		=	$27
GBASH		=	$28
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
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
RESTORE		=	$FF3F

.zeropage
.globalzp rot_smc

tiny_tiny:

	jsr	HGR2		; Hi-res, full screen		; E7/E8/E9
				; Y=0, A=0 after this call	; scale/shape

	lda	#40						; EA/EB collision
	sta	HGR_SCALE					; EC ED

tiny_loop:
	inc	rot_smc+1					; EE EF

	; setup X and Y co-ords
	ldy	#0		; Y always 0			; F0 F1
	ldx	#140						; F2 F3
	lda	#96						; F4
	jsr	HPOSN		; X= (y,x) Y=(a)		; F5 F6 F7
				; saves Y/X/A to HGR_Y, HGR_X, HGR_X+1

				; after, Y = X/7
				; after, y = $14 = 20, always
				; A=FF, X=F9

	ldx	#<shape_table	; point to our shape		; F8 F9
	ldy	#0						; FA FB
rot_smc:
	lda	#0		; ROT=0				; FC FD
	jsr	XDRAW0		; XDRAW 1 AT X,Y		; FE FF 100
				; Both A and X are 0 at exit
				; Z flag set on exit

	beq	tiny_loop	; bra

shape_table:
;	.byte $2D,0	; shape data
	.byte $3A,$DB,$0	; accidentally found at addr $0004
		; RT RT is 00 101 101 = 2D
