; blackhole_64

; by Vince `deater` Weaver / dSr

; For Lovebyte 2025

; zero page locations
HGR_COLOR	=	$E4
HGR_SCALE	=	$E7
HGR_ROTATION	=	$E8
FRAME		=	$E9

; ROM locations
HGR2		=	$F3D8
HPOSN		=	$F411
DRAW0		=	$F601
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0          =       $F457
SET_GR          =       $C050
SET_TEXT        =       $C051
FULLGR          =       $C052
TEXTGR          =       $C053
PAGE0           =       $C054
PAGE1           =       $C055
LORES           =       $C056   ; Enable LORES graphics
HIRES           =       $C057   ; Enable HIRES graphics
AN3             =       $C05E   ; Annunciator 3




black_hole:


	jsr	HGR2		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	bit	LORES

;	lda	#$04	; can't do this, drawing code assumes $40/$60
;	sta	$E6	; or least some cases assumes wraps at $20 boundary

	lda	#$20
	sta	$E7


restart:
	sty	HGR_COLOR	; set color to black for DRAW0 later

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
	jsr	copy_lores


	lda	#$6		; ROT=$6

	; point to our shape at $E2E3
	ldy	#$E2		; Y=$E2
	ldx	#$E3		; X=$E3

	jsr	XDRAW0		; XDRAW, A =ROTATE, Y:X = point to shape
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	; check for end
	; frame start at $F3, $F3+$36 = $29
	inc	FRAME
	lda	FRAME
	cmp	#$29
	bne	tiny_loop


	;========================
	; do the black hole

	; A is $29, X is 0

effect2:
	inx
	stx	HGR_SCALE		; set SCALE to 1

tiny_loop2:


	jsr	copy_lores



	lda	#0

	ldy	HGR_SCALE
	cpy	#$1C
done:
;	beq	done
	beq	restart

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

	bit	$C030		; click the speaker

	jsr	DRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop2	; bra



copy_lores:
;	lda	#$40
;	sta	cl1_smc+2

	lda	cl1_smc+2
	cmp	#$60
	bne	ook
	lda	#$40
ook:
	sta	cl1_smc+2

	lda	#$8
	sta	cl2_smc+2

	ldy	#0
copy_lores_loop:

cl1_smc:
	lda	$4000,Y
cl2_smc:
	sta	$800,Y
	dey
	bne	copy_lores_loop
	inc	cl1_smc+2
	inc	cl2_smc+2
	lda	cl2_smc+2
	cmp	#$c
	bne	copy_lores_loop

	rts

our_shape = $E2E0
