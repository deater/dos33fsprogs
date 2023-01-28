; 15B Weave Pattern

; by Vince `deater` Weaver / DsR

; for Lovebyte2023

; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_SCALE	=	$E7

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

weave15:

	; we load at zero page $E7 which is HGR_SCALE
	; this means the scale is $20 (JSR)

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?

	; set GBASL/GBASH
	; we really have to call this, otherwise it won't run
	; on some real hardware depending on setup of zero page at boot

	jsr	HPLOT0		; calls HPOSN and maybe sets some
				; registers a bit better?

;	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
tiny_loop:
	lda	#$E2		; load $E2 into A, X, and Y
	tax			; 	our shape table is in ROM at $E2E2
	tay			;	ROT is in A, but mod64

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra
