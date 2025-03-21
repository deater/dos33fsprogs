; 30B Angle Song -- XDRAW pattern plus some "music"

; by Vince `deater` Weaver / dSr

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
HPLOT0          =       $F457

angle_song:

	; we load at zero page $E7 which is HGR_SCALE
	; this means the scale is $20 (JSR)

	; $20 $D8 $F3

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?

	; set GBASL/GBASH
	; we really have to call this, otherwise it won't run
	; on some real hardware depending on setup of zero page at boot

	jsr	HPLOT0		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

tiny_loop:

	; generate some sound

 ; try flipping X/Y

;	ldx	$26
	ldx     $D4		; HGR_E
outer_delay:
	bit	$C030		; click speaker
	ldy	$27

;	lda	$27		; for lower beeps?
;	asl
;	tay


inner_delay:
	dey
	bne	inner_delay

	dex
	bne	outer_delay



rot_smc:
	lda	#$D8		; $18, $58, $98, $D8

				; ROT=$D8

	ldy	#$E2		;
	ldx	#$E3		; Y=$E2
				; X=$E3

	jsr	XDRAW0		; XDRAW, A =ROTATE, X/Y = point to shape
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

