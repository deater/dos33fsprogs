; Pattern Logo

; by Vince `deater` Weaver

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
FRAMEH		=	$FD
XPOS		=	$FE
YPOS		=	$FF

; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
DRAW0		=	$F601
XDRAW0		=	$F65D
XDRAW1		=	$F661
RESTORE		=	$FF3F


gear:


	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	lda	#10
	sta	HGR_SCALE

	; A and Y are 0 here.
	; X is left behind by the boot process?

	sty	HGR_COLLISIONS

	tya
	tax			; load X with 0
;	ldy	#0
;	ldx	#00
;	lda	#00
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
pattern_loop:

	ldx	#<pattern_table	; point to bottom byte of shape address
	ldy	#>pattern_table	; point to top byte of shape address

	; ROT in A

	; this will be 0 2nd time through loop, arbitrary otherwise
	lda	#1		; ROT=0
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	lda	HGR_COLLISIONS
	bne	pattern_loop


blah:
	jmp	blah



pattern_table:
.byte	37,53,0

