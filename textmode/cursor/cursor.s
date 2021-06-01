;10 HOME
;20 REM FOR I=2048 TO 3072:POKE I,160:NEXT
;30 INVERSE
;40 ?SPC(5):?:FORX=1TO5:NORMAL:?SPC(4):?:INVERSE:?SPC(1):NEXT:?SPC(5)
;100 GOTO 100
;130 POKE 49236+P,0:P=NOT P:FOR I=1 TO 1000:NEXT:GOTO 30

.include "hardware.inc"

H2	= $2C
V2	= $2D
COLOR	= $30

cursor:
	jsr	HOME

	lda	#$20
	sta	COLOR

	lda	#8
	sta	H2
	lda	#3
	ldy	#3

	jsr	HLINE		; HLINE Y,$2C at A

	lda	#8
	sta	H2
	lda	#15
	ldy	#3

	jsr	HLINE		; HLINE Y,$2C at A


	lda	#14
	sta	V2
	lda	#2
	ldy	#8
	jsr	VLINE

	lda	#14
;	sta	V2
	lda	#2
	ldy	#7
	jsr	VLINE		; VLINE A,$2D at Y

copy2page2:
	ldx	#0
c2p2_loop:
smc1:
	lda	$400,X
smc2:
	sta	$800,X
	inx
	bne	c2p2_loop

	inc	smc1+2
	inc	smc2+2
	lda	smc2+2
	cmp	#$10
	bne	c2p2_loop

	lda	#$5
	sta	V2

yloop1:
	ldy	#12
xloop1:
	lda	V2
	jsr	PLOT	; plot at Y,A
	iny
	iny
	cpy	#17
	bcc	xloop1

	lda	yloop1+1
	eor	#$1
	sta	yloop1+1

	inc	V2
	inc	V2
	lda	V2
	cmp	#15
	bne	yloop1


;	ldy	#12
;xloop2:
;	lda	#7
;	jsr	PLOT	; plot at Y,A
;	iny
;	iny
;	cpy	#16
;	bcc	xloop2



forever:
	bit	PAGE0

	ldx	#3
lw1:
	lda	#200
	jsr	WAIT
	dex
	bne	lw1

	bit	PAGE1

	ldx	#3
lw2:
	lda	#200
	jsr	WAIT
	dex
	bne	lw2

	jmp	forever

	; want this at 3F5, $389 to start, so -6C, 36C

	jmp	cursor
