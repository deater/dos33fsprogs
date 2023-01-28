; 16B looks like columns

; zero page locations
HGR_SHAPE	=	$1A
HGR_SHAPE2	=	$1B
GBASL		=	$26
GBASH		=	$27

; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661



tiny_xdraw:

	; loads at E7 (HGR_SCALE) which is $20 (jsr instruction)

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; we really have to call this, otherwise it won't run
	; on some real hardware


	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
tiny_loop:

	ldy	#$e3
	inx			; X is 1

	lda	#2		; ROT=2
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

