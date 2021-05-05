
; zero page locations
HGR_SHAPE	=	$1A
SEEDL		=	$4E
FRAME		=	$A4
OUR_ROT		=	$A5
RND_EXP		=	$C9
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
DIRECTION	=	$FC
XPOS		=	$FD
YPOS		=	$FF

; Soft Switches
KEYPRESS	=	$C000
KEYRESET	=	$C010
SPEAKER		=	$C030
PAGE0           =       $C054
PAGE1           =       $C055

; ROM calls
RND		=	$EFAE
HGR2		=	$F3D8
HCLR		=	$F3F2
HCLR_COLOR	=	$F3F4
HPOSN		=	$F411
XDRAW0		=	$F65D
TEXT		=	$FB36	; Set text mode
WAIT		=	$FCA8	; delay 1/2(26+27A+5A^2) us


shimmer:

	;=========================================
	; SETUP
	;=========================================


	jsr	HGR2

	lda	#0
	sta	FRAME

	lda	#14
	sta	YPOS

	lda	#3
	sta	HGR_SCALE

	lda	#32
	sta	DIRECTION

	lda	#22		; only set once, we wrap 
	sta	XPOS

y_loop:


x_loop:

main_loop:

	;=======================
	; xdraw
	;=======================

xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	#<shape_dsr
	ldy	#>shape_dsr

	lda	#0		; set rotation

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit


	inc	FRAME
	lda	FRAME
	and	#$7
	beq	reverse

add_x:
	lda	XPOS
	clc
	adc	DIRECTION
	sta	XPOS
	jmp	x_loop

reverse:
	lda	DIRECTION		; switch direction
	eor	#$ff
	sec
	adc	#0
	sta	DIRECTION

	lda	YPOS
	clc
	adc	#16
	sta	YPOS
	cmp	#190
	bne	y_loop


do_shimmer_y:

	ldx	#0
do_shimmer_x:

blargh:
	lda	$4000,X
	eor	#$80
blargh2:
	sta	$4000,X
	inx
	bne	do_shimmer_x


	inc	blargh+2
	inc	blargh2+2

	lda	blargh+2
	cmp	#$60
	bne	do_shimmer_y

	lda	#$40
	sta	blargh+2
	sta	blargh2+2
	jmp	do_shimmer_y

end:
	jmp	end

shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00





