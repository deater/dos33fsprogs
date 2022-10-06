; Cool Pattern

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


tiny_xdraw:

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	lda	#10
	sta	HGR_SCALE

	; A and Y are 0 here.
	; X is left behind by the boot process?

;	sty	FRAME
;	sty	FRAMEH

	sty	HGR_COLLISIONS

	tya
	tax

;	ldy	#0
;	ldx	#100
;	lda	#100
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
tiny_loop:

	; values for shape table
	;	Y	X
	;	00	E7 = neat
	;	00	EB = OK
	;	00	EF = good
	;	F0	01 = cool, let's go with it

	ldx	#<shape_table	; point to bottom byte of shape address
	ldy	#>shape_table	; point to top byte of shape address

	; ROT in A

	; this will be 0 2nd time through loop, arbitrary otherwise
	lda	#1		; ROT=0
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies


;	inc	FRAME
;	bne	skip_frameh_inc
;	inc	FRAMEH
;skip_frameh_inc:
;	lda	FRAMEH
;	cmp	#13
;	bne	tiny_loop	; bra

;	lda	FRAME
;	cmp	#32

	lda	HGR_COLLISIONS
	bne	tiny_loop

blah:
	beq	blah

shape_table:
;	.byte	 $01,$00,
	.byte	$04,$00 ;,$25,$35,$00


