; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

div7_table     = $b800
mod7_table     = $b900
hposn_high     = $ba00
hposn_low      = $bb00



.if 0
R		= $FC
RR		= $F5
D		= $FB
CX		= $FD
CY		= $FE
COUNT		= $F6
MINUSXX		= $F8
MINUSYY		= $FA
.endif

tunnel:

	;=====================
	; initializations
	;=====================

setup_graphics:

	sei

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen

	jsr	hgr_make_tables


	; from R=12 to R=256 or so

tunnel_again:
	lda	#0
	sta	RR

draw_next:

	ldx	RR
	lda	star_z,X
	tax
	lda	radii,X
	sta	R


	lda	#128
	sta	CX
	lda	#96
	sta	CY


	;===============================
	; draw circle
	;===============================
	; draw circle at (CX,CY) of radius R
	; signed 8-bit math so problems if R > 64?


	; XX=0 YY=R
	; D=3-2*R
	; GOTO6

	lda	#0
	sta	XX

	lda	R
	sta	YY

	lda	#3
	sec
	sbc	R
	sbc	R
	sta	D

	jmp	do_plots

circle_loop:
	; X=X+1

	inc	XX

	; IF D>0 THEN Y=Y-1:D=D+4*(X-Y)+10
	lda	D
	bmi	else

	dec	YY

	lda	XX
	sec
	sbc	YY
	asl
	asl
	clc
	adc	D
	adc	#10
	jmp	store_D

else:
	; ELSE D=D+4*X+6
	lda	XX
	asl
	asl
	clc
	adc	D
	adc	#6
store_D:
	sta	D

do_plots:
	lda	XX
	and	#$3
	bne	done2


	; setup constants

	lda	XX
	eor	#$FF
	sta	MINUSXX
	inc	MINUSXX

	lda	YY
	eor	#$FF
	sta	MINUSYY
	inc	MINUSYY

	; HPLOT CX+X,CY+Y
	; HPLOT CX-X,CY+Y
	; HPLOT CX+X,CY-Y
	; HPLOT CX-X,CY-Y
	; HPLOT CX+Y,CY+X
	; HPLOT CX-Y,CY+X
	; HPLOT CX+Y,CY-X
	; HPLOT CX-Y,CY-X

	; calc X co-ord

	lda	#7
	sta	COUNT
pos_loop:
	lda	COUNT
	and	#$4
	lsr
	tay

	lda	COUNT
	lsr
	bcc	xnoc
	iny
xnoc:
	lda	CX
	clc
	adc	XX,Y
	tax

	; calc y co-ord

	lda	COUNT
	lsr
	eor	#$2
	tay

	lda	CY
	clc
	adc	XX,Y		; A has Y-coord

	ldy	#0

	; want X/7 into X
	; want A looked up into OUTL

	jsr	hplot		; plot at (Y,X), (A)

	dec	COUNT
	bpl	pos_loop


done2:
	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	circle_loop

done:
	lda	RR
	clc
	adc	#1
	sta	RR

	cmp	#19
	beq	done_frame

	; GOTO1
	jmp	draw_next

done_frame:
	lda	#0
	jsr	hgr_page1_clearscreen

	ldx	#19
move_circles:
	dec	star_z,X
	dex
	bpl	move_circles

	jmp	tunnel_again

radii:
	.byte <4000, <3200, <1600, <1066, <800, <640, <533, <457
	.byte <400, <355, <320, <290, <266, 246, 228, 213
	.byte 200, 188, 177, 168, 160, 152, 145, 139
	.byte 133, 128, 123, 118, 114, 110, 106, 103
	.byte 100, 96, 94, 91, 88, 86, 84, 82
	.byte  80, 78, 76, 74, 72, 71, 69, 68
	.byte  66, 65, 64, 62, 61, 60, 59, 58
	.byte  57, 56, 55, 54, 53, 52, 51, 50
	.byte  50, 49, 48, 47, 47, 46, 45, 45
	.byte  44, 43, 43, 42, 42, 41, 41, 40
	.byte  40, 39, 39, 38, 38, 37, 37, 36
	.byte  36, 35, 35, 35, 34, 34, 34, 33
	.byte  33, 32, 32, 32, 32, 31, 31, 31
	.byte  30, 30, 30, 29, 29, 29, 29, 28
	.byte  28, 28, 28, 27, 27, 27, 27, 26
	.byte  26, 26, 26, 26, 25, 25, 25, 25
	.byte  25, 24, 24, 24, 24, 24, 23, 23
	.byte  23, 23, 23, 23, 22, 22, 22, 22
	.byte  22, 22, 21, 21, 21, 21, 21, 21
	.byte  21, 20, 20, 20, 20, 20, 20, 20
	.byte  20, 19, 19, 19, 19, 19, 19, 19
	.byte  19, 18, 18, 18, 18, 18, 18, 18
	.byte  18, 18, 17, 17, 17, 17, 17, 17
	.byte  17, 17, 17, 17, 17, 16, 16, 16
	.byte  16, 16, 16, 16, 16, 16, 16, 16
	.byte  16, 15, 15, 15, 15, 15, 15, 15
	.byte  15, 15, 15, 15, 15, 15, 14, 14
	.byte  14, 14, 14, 14, 14, 14, 14, 14
	.byte  14, 14, 14, 14, 14, 13, 13, 13
	.byte  13, 13, 13, 13, 13, 13, 13, 13
	.byte  13, 13, 13, 13, 13, 13, 13, 12
	.byte  12, 12, 12, 12, 12, 12, 12, 12

; num-stars = 20

star_z:
	.byte 15,26,38,50,63,75,78,100,112,125,137
	.byte 150,162,175,187,200,212,224,237





	.include	"../wait_keypress.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"


	; A is Ycoord value
	; X is Xcoord value
hplot:
	tay
	lda	hposn_low,Y
	sta	OUTL
	lda	hposn_high,Y
	sta	OUTH

	ldy	div7_table,X

	lda	mod7_table,X

	sta	(OUTL),Y

	rts
