; Puffball

; 31 byte rotating Apple II shapetables

; for Lovebyte 2024

; by Vince `deater` Weaver / DsR

; zero page locations
GBASL		=	$26
GBASH		=	$27
HGR_HORIZ	=	$E5
HGR_SCALE	=	$E7
HGR_COLLISION	=	$E8
HGR_ROTATION	=	$00	; usually $F9 but can't here

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

.zeropage
.globalzp blip

puffball:
	; we load at $E7 so HGR_SIZE set to $20 (first byte of JSR)

	jsr	HGR2		; Hi-res, full screen		; $E7/$E8/$E9
				; Y=0, A=0 after this call

	nop			; EA HGR_COLLISION)		; $EA

	; A and Y are 0 here.
	; X is left behind by the boot process?


tiny_loop:
	; A=0 here from both cases

	; we need the following values to start at center
	;	directly would need to set 16 bytes
	;	GBASL=$28
	;	GBASH=$42
	;	HGR_HORIZ=20
	;	HMASK=$81

	tay		;	ldy	#0			; $EB
	ldx	#140						; $EC/$ED
	lda	#96						; $EE/$EF
	jsr	HPOSN	; set screen position to X= (y,x) Y=(a)	; $F0/$F1/$F2
			; saves X,Y,A to zero page
			; after Y= orig X/7
				; A and X are ??

blip:
	ldx	#<our_shape		;			; $F3/$F4
	ldy	#>our_shape		;			; $F5/$F6
	inc	HGR_ROTATION					; $F7/$F8
	lda	HGR_ROTATION					; $F9/$FA
	and	#$3f						; $FB/$FC
	bne	ee						; $FD/$FE
	dec	blip+1	;(blip+1)				; $FF/$100
ee:
	jsr	XDRAW0		; XDRAW 1 AT X,Y		; $101/$102/$103
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra				; $104/$105


our_shape=$E2E2

; values at $E2DF

;our_shape:
;.byte	$11,$f0,$03,$20,$00
