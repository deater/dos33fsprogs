; Sawblade

; 32 bytes for Lovebyte2024

; by Vince `deater` Weaver / DsR

; zero page locations
GBASL		=	$26
GBASH		=	$27

HGR_X		=	$E0
HGR_X2		=	$E1
HGR_Y		=	$E2
HGR_SCALE	=	$E7
HGR_ROTATION	=	$E8

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

sawblade:
	ldy	#1		; this 1 must be at #$E7

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

;	iny			; Y=1
;	sty	HGR_SCALE
;	sty	HGR_ROTATION


	; A and Y are 0 here.
	; X is left behind by the boot process?

tiny_loop:
	; A is 0 both paths

	tay			; Y=0
	ldx	#140
	lda	#96
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	#<our_shape		; load shape table
	ldy	#>our_shape		;
	inc	HGR_ROTATION
	lda	HGR_ROTATION
	and	#$3f
	bne	skip
	inc	HGR_SCALE

	; rotation in A, $00b..$3F
skip:
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra


our_shape = $E2E0

; F0 03 20 00



; 9 bytes + 4 bytes :(
;	ldx	#4
;loop:
;	lda	blah,X
;	sta	zp,X
;	dex
;	bne	loop

; 9 bytes
;	iny
;	sty	HGR_SCALE
;	ldy	#0
;	ldx	#140
;	lda	#96
