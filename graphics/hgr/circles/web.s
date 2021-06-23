; web -- Apple II Hires



; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

BLAH		= $F5
COUNT		= $F6



XX		= $F7
MINUSXX		= $F8
YY		= $F9
MINUSYY		= $FA

D		= $FB
R		= $FC
CX		= $FD
CY		= $FE
FRAME		= $FF

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
COLORTBL	= $F6F6
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
BELL2		= $FBE4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

web:

	jsr	HGR2

	ldx	#90

draw_next:

	stx	R

	; center

;	lda	#128
;	sta	CX
;	lda	#96
;	sta	CY

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

;	lda	R
	stx	YY

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
	adc	#10
	jmp	store_D

else:
	; ELSE D=D+4*X+6
	lda	XX
	asl
	asl
	clc
	adc	#6
store_D:
	adc	D
	sta	D

do_plots:
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
;	lda	CX
	lda	#128
	clc
	adc	XX,Y
	tax

	; calc y co-ord

	lda	COUNT
	lsr
	eor	#$2
	tay

;	lda	CY
	lda	#96
	clc
	adc	XX,Y

	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

	dec	COUNT
	bpl	pos_loop


	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	circle_loop

done:
	ldx	R
;	sec
;	sbc	#3

	dex
	dex
	dex

	bpl	draw_next

stop:
	jsr	WAIT
	txa
	jsr	WAIT

	; for once we get this for free, even though we don't need it

	jmp	web
