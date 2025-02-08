; 17B interesting XDRAW pattern

; This one looks vaguely like a circuit board

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

circuit17:

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


	; aa = (orange)tiger stripes
	; 55 = purple
	; 2a = green
;	lda	#$2a
;	jsr	$F3F4

tiny_loop:

	; e2/e3
	; 0.. 63?
	; 0 = maze
	; 1 = scaly
	; 2 = ??
	; 3 = tower plates
	; 4 = bubbles
	; 5 = strings
	; 6 = circuit board	*
	; 7 = noodles
	; 8 = pickup sticks
	; 9 = meh
	; 10 = interesting
	; 11 = meh
	; 12 = static
	; 13 = weave
	; 14 = core
	; 15 = masts		*
	; 16 = maze again
	; 17 = spots		*
	; 18 = bamboo		*
	; 19 = mesh
	; 20 = coils
	; 21 = sunspots
	; 22 = gridy
	; 23 = dominos
	; 24 = chevron		**
	; 25 = borg
	; 26 = grid
	; 27 = plants
	; 28 = spaces
	; 29 = ridges
	; 30 = net
	; 31 = odd
	; 32 = maze again

	; e2/e5
	; e3 looks best?
	; a0 interesting, green train

;	inc	rot_smc+1	; broken glass

;	bit	$C030

rot_smc:
	lda	#$6		; $6

				; ROT=$C6

	ldy	#$E2		;
	ldx	#$E3		; Y=$E2
				; X=$E3

	jsr	XDRAW0		; XDRAW, A =ROTATE, X/Y = point to shape
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

