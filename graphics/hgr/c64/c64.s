; silly c64

; needs to be 146 bytes or less

; zero page locations
WHICH		=	$00
HGR_SHAPE	=	$1A
SEEDL		=	$4E
FRAME		=	$A4
OUR_ROT		=	$A5
RND_EXP		=	$C9
HGR_COLOR	=	$E4
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
SCALE		=	$FC
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
DRAW0		=	$F601
XDRAW0		=	$F65D
TEXT		=	$FB36	; Set text mode
WAIT		=	$FCA8	; delay 1/2(26+27A+5A^2) us


dsr_demo:

	;=========================================
	; SETUP
	;=========================================

	jsr	HGR2			; set/clear HGR page1 to black
					; Hi-res graphics, no text at bottom
					; Y=0, A=$60 after this call


	lda	#$D5			; color blue
	jsr	HCLR_COLOR

	lda	#2
	sta	HGR_SCALE

	lda	#0
	sta	WHICH

	;=========================
	; draw letters
	;=========================


	; LDA COLORTBL,X    GET COLOR PATTERN
	lda	#$ff
	sta	HGR_COLOR


	lda	#8
	sta	YPOS
	lda	#23
	sta	XPOS

first_loop:
	lda	WHICH
	tay
	lda	string,Y
	clc
	adc	#<shape_table
	sta	shape_smc+1
	lda	#>shape_table
	sta	shape2_smc+1

	jsr	draw

	inc	WHICH

	lda	XPOS
	clc
	adc	#8
	sta	XPOS
	cmp	#(28*8)+23
	bne	first_loop

end:
	jmp	end


draw:
	; to call draw
	; need to have co-ords set up with HPOSN
	; rotate should be in A


	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

shape_smc:
	ldx	#<shape_table	; point to our shape
shape2_smc:
	ldy	#>shape_table	; code fits in one page so this doesn't change

rot_smc:
	lda	#0		; set rotation

	jmp	DRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit



shape_table:

.byte	$3f,$24,$2d,$05,$00	; C		0
.byte	$3f,$24,$2d,$36,$00	; O		1
.byte	$24,$37,$3c,$36,$00	; M		2
.byte	$3b,$24,$ad,$06,$00	; D		3
.byte	$1f,$24,$35,$07,$00	; R		4
.byte	$3f,$2c,$27,$2d,$00	; E		5
.byte	$23,$24,$00,$00,$00	; I		6
.byte	$02,$00			; space		7

;.byte	$3b,$24,$ad,$06,$00	; 4		8
;.byte	$3f,$24,$2d,$05,$00	; B		9
;.byte	$3f,$24,$2d,$36,$00	; A		10
;.byte	$24,$37,$3c,$36,$00	; S		11
;.byte	$3b,$24,$ad,$06,$00	; I		12
;.byte	$3f,$24,$2d,$05,$00	; Y		13
;.byte	$3f,$24,$2d,$36,$00	; *		14
;.byte	$24,$37,$3c,$36,$00	; *		15



string:
;       *  *  *  *     C  O  M  M  O  D  O  R  E
.byte	10,10,10,10,35,0, 5,10,10, 5,15, 5,20,25,35
;	6  4     B  A  S  I  C   *  *  *  *
.byte 	15,10,35,15,10,15,30,0, 35,10,10,10,10

;$3c,$2c,$3c,$3f,$36,$06,$00
;$3f,$27,$2c,$27,$2d,$05,$00




