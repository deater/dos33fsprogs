; Xdraw test

; use to prototype small xdraw effects

; by Vince `deater` Weaver / DsR

; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

xdraw_test:

	lda	#$1
	sta	HGR_SCALE
	sta	HGR_ROTATION

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?



tiny_loop:
	ldy	#0
	ldx	#140
	lda	#96
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	#<our_shape		; load $E2 into A, X, and Y
	ldy	#>our_shape		; 	our shape table is in ROM at $E2E2
	inc	HGR_ROTATION
	lda	HGR_ROTATION
;	and	#$7f
	bne	skip
	inc	HGR_SCALE

skip:
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra


our_shape = $E2E0

;our_shape:
;.byte	$1a,$2d,$00
