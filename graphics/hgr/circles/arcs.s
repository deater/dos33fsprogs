; circles tiny -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

D		= $F9
XX		= $FA
YY		= $FB
R		= $FC
CX		= $FD
CY		= $FE
FRAME		= $FF

; soft-switches

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

circles:

	jsr	HGR2

draw_next:
	inc	FRAME
	ldy	FRAME

	; Random Color
	; HCOLOR=1+RND(1)*7
	lda	$F000,Y
	and	#$7		; mask to 0...7
	tax
	lda	COLORTBL,X
	sta	HGR_COLOR

	; CX
	lda	$F100,Y
	and	#$7f
	sta	CX
	clc
	adc	#$40

	; CY
	lda	$F100,Y
	and	#$7f
	sta	CY
	clc
	adc	#$40

	; R
	lda	$F100,Y
	and	#$3f
	sta	R

	; A=40+RND(1)*200:B=40+RND(1)*100:Y=RND(1)*40

	; 3X=0:D=3-2*Y:GOTO6
	lda	#0
	sta	XX

	lda	R
	asl
	sta	YY
	lda	#3
	sec
	sbc	YY
	sta	D

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

	; HPLOT CX+X,CY+Y

	lda	CX
	clc
	adc	XX
	tax
	ldy	#0
	lda	CY
	clc
	adc	YY

	jsr	HPLOT0		; plot at (Y,X), (A)

	; HPLOT CX-X,CY+Y
	; HPLOT CX+X,CY-Y
	; HPLOT CX-X,CY-Y
	; HPLOT CX+Y,CY+X
	; HPLOT CX-Y,CY+X
	; HPLOT CX+Y,CY-X
	; HPLOT CX-Y,CY-X

	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	circle_loop

	; GOTO1
	bcc	draw_next
