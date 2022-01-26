; Tiny Cool - 32B demo

; makes a pretty neat spinning pattern
; not necessarily repeatable, it's walking through each memory page
;	and grabbing offset 32 or so as a shape table
;	what you get depends on contents of RAM

; zero page locations
HGR_SHAPE	=	$1A
A5H		=	$45
XREG		=	$46
YREG		=	$47
HGR_SCALE	=	$E7
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

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

	iny
	sty	HGR_SCALE

tiny_loop:
	; setup X and Y co-ords for center of screen
	ldy	#0		; Y always 0
	ldx	#140
	lda	#96
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	#<shape_table	; point to our shape
rot_smc:
	lda	#0		; ROT=0
	tay			; ldy	#>shape_table

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

				; increment rotation
	inc	rot_smc+1	; oops also increments high byte of shape table
	jmp	tiny_loop

shape_table:
	.byte 18,0	; shape data
