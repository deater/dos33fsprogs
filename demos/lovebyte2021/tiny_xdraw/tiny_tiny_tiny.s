; Tiny Tiny

; zero page locations
HGR_SHAPE	=	$1A
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
HGR_SHAPE	=	$E8
HGR_SHAPE2	=	$E9
HGR_COLLISIONS	=	$EA
HGR_ROTATION	=	$F9
FRAME		=	$FC
XPOS		=	$FD
YPOS		=	$FF

; ROM calls
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
RESTORE		=	$FF3F

.zeropage

tiny_tiny:

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

;	lda	#40
;	sta	HGR_SCALE

tiny_loop:
	; setup X and Y co-ords
	ldy	#0		; Y always 0
	ldx	#140
	lda	#96
	jsr	HPOSN		; X= (y,x) Y=(a)
				; saves Y/X/A to HGR_Y, HGR_X, HGR_X+1

;	ldx	#<shape_table	; point to our shape
;	ldy	#0
rot_smc:
	lda	#0		; ROT=0
	jsr	XDRAW1		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

	inc	rot_smc+1
	jmp	tiny_loop

shape_table:
	.byte $2D,0	; shape data

		; RT RT is 00 101 101 = 2D
