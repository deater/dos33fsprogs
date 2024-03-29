; 16B herringbone pattern

; FIXME: depends on memory init

; zero page locations
GBASL		=	$26
GBASH		=	$27

; ROM calls
HGR2		=	$F3D8
HGR		=	$F3E2
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
RESTORE		=	$FF3F


herring:

	; $E7 HGR_SCALE is $00 from memory not initialized

	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	; A and Y are 0 here.
	; X is left behind by the boot process?

	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??
tiny_loop:

	; this will be 0 2nd time through loop, arbitrary otherwise
;	lda	#1		; ROT=1
	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	inx	; X=1
	txa	; A=1
	tay	; Y=1

	bne	tiny_loop	; bra

; be sure this is at address $0101, easy to set address
shape_table:
	.byte	$04,$00
