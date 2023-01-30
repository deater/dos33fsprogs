; 17B weird line pattern

; by Vince `deater` Weaver / dSr

; Really wanted this to be 16B :(

; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_SCALE	=	$E7
HGR_COLLISIONS	=	$EA

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661


agony17:

	; we load at zero page $E7 which is HGR_SCALE
	; this means the scale is $20 (JSR)

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?

	; set GBASL/GBASH
	; we really have to call this, otherwise it won't run
	; on some real hardware depending on setup of zero page at boot

	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
tiny_loop:

	ldy	#$e8		; point to shape table value of $04,$00
	ldx	#$0e		; in ROM


	lda	#2		; ROT=2
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

