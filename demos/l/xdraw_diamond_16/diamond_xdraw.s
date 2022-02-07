; Tiny Xdraw

; repeatedly draws an image from an Apple II shape table

; can arbitrarily point to any memory location as a source of these
;	some look amazing but depend on random machine state
;	to be deterministic you should probably stick to
;		$E7-$F0 (the program itself)
;		$D000-$FFFF (the ROMs)
;	shapetables are a bit complicated to explain here, but they are a
;		series of bytes ending with a $00
;		(note if you point to a zero, it will be interpreted as an
;		action not an end)
;	each byte specifies up to 3 actions, DRAW + UP DOWN LEFT RIGHT or
;					NODRAW + UP DOWN LEFT RIGHT
;	It is vector scaling with SCALE we hardcode to $20 and rotation
;		which gets set to 0 after the first iteration, (which is
;		why the first shape has arbitrary rotation and gets left)

;	we are xdrawing so it will XOR with the current pixels on the screen

		; NUP=0 UP=4	zz yyy xxx  , does xxx yyy zz 
		; NRT=1 RT=5
		; NDN=2 DN=6
		; NLT=3 LT=7

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

tiny_xdraw:

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; we load at $E7 which is HGR_SCALE, so HGR_SCALE gets
	;	the value of the above JSR instruction ($20)


	; A and Y are 0 here.
	; X is left behind by the boot process?

	tax
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
tiny_loop:

	; values for shape table
	;	Y	X
	;	F0	01 = xdraw16 from lovebyte 2021
	;	E726 = interesting
	;	E728 = moving bars
	;	E72A = moving lines
	;	E7E7 = sorta OK

	lda	#$e7
	tax
	tay

;	ldx	#$e7	; point to bottom byte of shape address
;	ldy	#$e7	; point to top byte of shape address

	; ROT in A

	; this will be 0 2nd time through loop, arbitrary otherwise
;	lda	#0		; ROT=0
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra




