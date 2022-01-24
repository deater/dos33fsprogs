; Xdraw Wave

; repeatedly draws an image from an Apple II shape table
; this time we rotate a bit
; we also go for a bit of sound

; loads at $E7 which sets the HGR_SCALE zero-page value for free

; zero page locations


; ROM calls
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D

.zeropage
.globalzp	rot_smc

xdraw_wave:

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
	;	00	E7 = neat
	;	00	EB = OK
	;	00	EF = good
	;	F0	01 = cool, let's go with it

;	ldx	#$01	; point to bottom byte of shape address
	ldy	#$f0	; point to top byte of shape address

	; ROT in A

	; this will be 0 2nd time through loop, arbitrary otherwise
	lda	#5		; ROT=0
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra
