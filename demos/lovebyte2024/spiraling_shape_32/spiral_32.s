; Spiraling Shape

; o/~ Down, Down, Down You Go o/~

; by Vince `deater` Weaver / DsR

; Lovebyte 2024

; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_SCALE	=	$E7
HGR_COLLISION	=	$EA

HGR_ROTATION	=	$FE		; IMPORTANT! set this right!

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

spiraling_shape:
	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?

tiny_loop:
	bit	$C030
	tay	; ldy #0		; A always 0 here
	ldx	#140
	lda	#96
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	#<our_shape		; load $E2DF
	ldy	#>our_shape		;
	inc	HGR_ROTATION

	lda	#1		; HGR_ROTATION is HERE ($FE)

	and	#$7f		; cut off before it gets too awful
	sta	HGR_SCALE

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra


our_shape = $E2DF


