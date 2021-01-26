; silly c64

; 147 initial, top line
; 145 beq instead of jmp, 0 is already in Y
; 141 inline draw
; 146 add READY
; 136 optimize addr calculation
; 150 printing READY and skipping line
; 147 get FF by decrementing 0
; 146 move increment before the draw
; 144 have XPOS in A at beginning of loop
; 142 realize shapes don't have to be aligned at 5

; needs to be 144 bytes or less

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

	sty	WHICH		; = 0

	dey			; $ff = white2
	sty	HGR_COLOR

	lda	#2
	sta	HGR_SCALE

	;=========================
	; draw letters
	;=========================

	lda	#8
	sta	YPOS
	lda	#23
;	sta	XPOS

	; XPOS in A coming in

first_loop:


draw:
	; to call draw
	; need to have co-ords set up with HPOSN
	; rotate should be in A

;	lda	XPOS
	clc
	adc	#8
	sta	XPOS
	tax

	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
;	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldy	WHICH
	lda	string,Y
	clc
	adc	#<shape_table
	tax

;	ldx	#<shape_table	; point to our shape (low)
	ldy	#>shape_table	; code fits in one page, same always

	lda	#0		; set rotation

	jsr	DRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit


	inc	WHICH
	ldy	WHICH

	lda	XPOS

	cpy	#28
	bne	no_adjust

	sty	YPOS	; want 32, 28 is close
	lda	#$ff
	sta	XPOS

no_adjust:
	cpy	#33
	bne	first_loop

end:
	beq	end


shape_table:

.byte	$3f,$24,$2d,$05,$00	; C		0
.byte	$3f,$24,$2d,$36,$00	; O		1
.byte	$24,$37,$3c,$36,$00	; M		2
.byte	$3b,$24,$ad,$06,$00	; D		3
.byte	$1f,$24,$35,$07,$00	; R		4
.byte	$3f,$2c,$27,$2d,$00	; E		5
.byte	$23,$24,$00		; I		6
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
.byte	10,10,10,10,33,0, 5,10,10, 5,15, 5,20,25,33
;	6  4     B  A  S  I  C   *  *  *  *
.byte 	15,10,33,15,10,15,30,0, 33,10,10,10,10

; 28

;        R  E  A  D  Y
.byte	20,25,10,15,30

; 5

