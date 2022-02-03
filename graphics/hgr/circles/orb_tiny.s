; orb

; this was found accidentally when trying to draw circles
; it's doing Bresenham circle algo I think, which does weird
;	things when radius=0

; optimized for lovebyte2022


; zero page

HGR_COLOR       = $E4

COUNT           = $F6
XX              = $F7
MINUSXX         = $F8
YY              = $F9
MINUSYY         = $FA
D               = $FB
R               = $FC
DADD            = $FD


; ROM routines

HGR2            = $F3D8         ; set hires page2 and clear $4000-$5fff
HPLOT0          = $F457         ; plot at (Y,X), (A)
HLINRL          = $F530         ; line to (X,A), (Y)
HCOLOR1         = $F6F0         ; set HGR_COLOR to value in X



orb:
	jsr	HGR2

	; a=0, y=0 here (it's after HGR2)

	tax			; x=0 (set R=0)

	dey			; set init color to white
	sty	HGR_COLOR	; set init color to white

draw_next:
	; X is always R here

	stx	R

	;===============================
	; draw circle
	;===============================
	; draw circle at (CX,CY) of radius R
	; signed 8-bit math so problems if R > 64?

	lda	#0
	sta	XX			; XX = 0

	stx	YY			; YY =R (X is R here)

	lda	#3			; D=3-2*R
	sec
	sbc	R
	sbc	R

	; D is now in A

	; always odd, never zero

	bne	do_plots		; bra	skip ahead first time through

circle_loop:
	inc	XX			; XX=XX+1

	lda	XX			; XX is common both paths
	ldy	#6			; default path add 6

	; IF D>0 THEN Y=Y-1:D=D+4*(X-Y)+10
	bit	D			; check if negative w/o changing A
	bmi	d_negative

	dec	YY			; YY=YY-1

d_positive:
	; D=D+4*(XX-YY)+10

	; XX is already in A
;	sec				; saves a byte, seems to be OK?
	sbc	YY
	ldy	#10
d_negative:
	; ELSE D=D+4*(XX)+6
common_D:
	sty	DADD
	asl
	asl
	clc
	adc	DADD
	adc	D

do_plots:
	; D is always in A here

	sta	D

	; setup plus/minus XX/YY

	ldx	#2
plus_minus_loop:
	lda	XX,X
	eor	#$FF
	sta	MINUSXX,X
	inc	MINUSXX,X
	dex
	dex
	bpl	plus_minus_loop

	; HPLOT CX+X,CY+Y
	; HPLOT CX-X,CY+Y
	; HPLOT CX+X,CY-Y
	; HPLOT CX-X,CY-Y
	; HPLOT CX+Y,CY+X
	; HPLOT CX-Y,CY+X
	; HPLOT CX+Y,CY-X
	; HPLOT CX-Y,CY-X

	ldx	#3

pos_loop:
	; calc left side

	; COUNT already in X here

	stx	COUNT

	; calc y co-ord

	lda	#96			; center around y=96
	clc
	adc	XX,X			; index with COUNT
	tay				; save for later

	; calc x co-ord

	txa				; get count
	ora	#$1			; generate pattern
	eor	#$2			; ???
	tax				; offset in array

	lda	#128			; center around x=128
	clc
	adc	XX,X

	tax

	tya			; restore Y co-ordinate
	ldy	#0		; always 0

	jsr	HPLOT0		; plot at (Y,X), (A)


	; calc right side
	lda	COUNT
	and	#$2
	eor	#$2
	tax
	lda	XX,X
	asl

	ldy	#0
	ldx	#0
	jsr	HLINRL		; plot relative (X,A), (Y)
				; so in our case (0,XX*2),0

				; X/A/Y saved to zero page
				; X/Y were zero
	ldx	COUNT
	dex			; decrement count

	bpl	pos_loop


	; IF YY>=XX THEN 4
	; should be equivelant to IF XX<YY
	; but sadly appears we need IF XX<=YY for our initial effect
	lda	YY
	cmp	XX
	bcs	circle_loop

done:
	ldx	R
	inx				; increment radius
	jsr	HCOLOR1			; use as color

;	cpx	#48			; run until R=48
	jmp	draw_next		; loop	(GOTO 1)



