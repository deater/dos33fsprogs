
H2		= $2C
V2		= $2D
COLOR		= $30
P		= $F9
Q		= $FA
J		= $FB
Z		= $FC
COUNTMAX	= $FD
COUNT		= $FE
NEWCOLOR	= $FF

FULLGR		= $C052

HLINE   = $F819                 ;; HLINE Y,$2C at A
VLINE   = $F828                 ;; VLINE A,$2D at Y
SETCOL	= $F864		; COLOR=A
SETGR	= $FB40
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

tunnel:
	; 1 GR:N=23

	jsr	SETGR
;	bit	FULLGR

	lda	#23
	sta	NEWCOLOR

forq:

	lda	#6
	sta	Q

qloop:
	; 2 FOR Q=6 TO 0 STEP -1:P=0

	lda	#0
	sta	P

	; 3 FOR I=0 TO 19:IF 20-I>A(P,Q) THEN 7
fori:
	ldx	#0
iloop:
	lda	Q
	asl
	asl
	asl
	ora	P
	tay

	txa
	eor	#$FF
	sec
	adc	#20
	cmp	lookup,Y
	bcs	skip

	; 4 P=P+1:Z=39-I:J=I+1:W=Z-1

	inc	P

	txa
	eor	#$ff
	sec
	adc	#39
	sta	Z
	sta	H2
	sta	V2
	dec	H2
	dec	V2

	txa
	clc
	adc	#1
	sta	J

	; 6 COLOR=N+P:HLIN J,W AT I:HLIN J,W AT Z:VLIN J,W AT I:VLIN J,W AT Z

	lda	P
	clc
	adc	NEWCOLOR
	jsr	SETCOL

	; HLIN J,W AT I	; HLINE Y,$2C at A

	ldy	J
	txa
	jsr	HLINE

	; HLIN J,W AT Z	; HLINE Y,$2C at A

	ldy	J
	lda	Z
	jsr	HLINE

	; VLIN J,W AT I	; VLINE A,$2D at Y
	txa
	tay
	lda	J
	jsr	VLINE

	; VLIN J,W AT Z	; VLINE A,$2D at Y
	ldy	Z
	lda	J
	jsr	VLINE


skip:

;	lda	#150
;	jsr	WAIT


	; 7 NEXTI,Q:N=N+1:IF N=32 THEN N=16

	inx
	cpx	#19
	bne	iloop

	dec	Q
	bpl	qloop

	inc	NEWCOLOR

	lda	NEWCOLOR
	cmp	#32
	bne	blah

	lda	#16
	sta	NEWCOLOR
blah:

end:
	; 8 GOTO 2

	jmp	forq


; 0 DIM A(9,9):FOR I=0 TO 8:FOR J=0 TO 8:A(I,J)=40/(2+I+J/7):NEXTJ,I
lookup:
	.byte 20,13,10,8,6,5,5,4
	.byte 18,12, 9,7,6,5,4,4
	.byte 17,12, 9,7,6,5,4,4
	.byte 16,11, 9,7,6,5,4,4
	.byte 15,11, 8,7,6,5,4,4
	.byte 14,10, 8,7,5,5,4,4
	.byte 14,10, 8,6,5,5,4,4
	.byte 13,10, 8,6,5,5,4,4

	; need for bot

	jmp	tunnel
