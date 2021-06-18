; circles tiny -- Apple II Hires


; 229 -- first
; 228 -- remove shift
; 190 -- move hplots into two loops
; 169 -- move hplots into one loop
; 166 -- small enough we can use bcs again
; 157 -- some more math

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

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
HLINRL		= $F530		; line to (X,A), (Y)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
COLORTBL	= $F6F6
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
BELL2		= $FBE4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

circles:



	lda	#0
	sta	R

draw_next:


	jsr	HGR2



;draw_next:
.if 0
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
	clc
	adc	#$40
	sta	CX

	; CY
	lda	$F200,Y
	and	#$7f
	clc
	adc	#$20
	sta	CY

	; R
	lda	$F300,Y
	and	#$3f
	sta	R
.endif

	; A=40+RND(1)*200:B=40+RND(1)*100:Y=RND(1)*40

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




	lda	#3
	sta	COUNT
pos_loop:

	; calc left side

	; calc X co-ord

	lda	COUNT
	ora	#$1
	eor	#$2
	tay
	lda	CX
	clc
	adc	XX,Y
	tax

	; calc y co-ord

	ldy	COUNT
	lda	CY
	clc
	adc	XX,Y

	ldy	#0

	pha			; save Y value for later

	jsr	HPLOT0		; plot at (Y,X), (A)


	; calc right side
	lda	COUNT
	and	#$2
	eor	#$2
	tay
	lda	XX,Y
	asl

	ldy	#0
	ldx	#0

	jsr	HLINRL		; plot relative (X,A), (Y)
				; so in our case (0,XX*2),0



	dec	COUNT
	bpl	pos_loop


	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	circle_loop

done:


	lda	KEYPRESS
	bpl	done

	bit	KEYRESET


	inc	R
stop:
	; GOTO1
	jmp	draw_next
