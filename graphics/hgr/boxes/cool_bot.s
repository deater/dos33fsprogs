
; zero page

HGR_X		= $E0
HGR_XH		= $E1
HGR_Y		= $E2
HGR_COLOR	= $E4

YRUN		= $F0
XRUN		= $F1
Y1		= $F2
X1		= $F3
COLOR		= $F4

COLOR1		= $F5
COLOR2		= $F6

; rom routines
HGR2		= $F3D8
HPOSN		= $F411
HLINRL		= $F530
COLORTBL	= $F6F6

myst_tiny:
	jsr	HGR2

outer_loop:

	ldy	#5
data_smc:
	lda	myst_tiny
	sta	YRUN-1,Y
	inc	data_smc+1
	dey
	bne	data_smc

rectangle_loop:
	lda	COLOR

	asl		; nibble swap by david galloway
	adc	#$80
	rol
	asl
	adc	#$80
	rol

	sta	COLOR

	and	#$f
	tax

	lda	COLORTBL,X
	sta	HGR_COLOR

	ldx	X1		; X1 into X
	lda	Y1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)


	lda	XRUN		; XRUN into A
	ldx	#0		; always 0
	ldy	#0		; relative Y is 0
	jsr	HLINRL		; (X,A),(Y)

	inc	Y1
	dec	YRUN
	bne	rectangle_loop

	beq	outer_loop


data:
.byte $33,$00,$00,$8C,$5A
.byte $33,$8C,$00,$8B,$5A
.byte $16,$00,$5A,$8C,$65
.byte $16,$8C,$5A,$8B,$65
.byte $42,$9D,$79,$33,$46
.byte $07,$8D,$74,$5A,$13
.byte $00,$B4,$11,$21,$68
.byte $70,$9C,$14,$35,$6A
.byte $07,$91,$0A,$43,$0A
.byte $07,$A2,$00,$3A,$14
.byte $50,$AC,$5B,$0F,$20
.byte $77,$A9,$1F,$16,$20
.byte $77,$A5,$27,$1D,$15
.byte $51,$00,$A3,$3F,$1C
.if 0
.byte $51,$3F,$A7,$72,$18
.byte $51,$B1,$B9,$35,$06
.byte $50,$17,$00,$10,$B2
.byte $15,$01,$0D,$62,$1F
.byte $50,$00,$00,$12,$BC
.byte $05,$42,$00,$0F,$BB
.byte $00,$B1,$20,$04,$12
.endif

	jmp	myst_tiny
