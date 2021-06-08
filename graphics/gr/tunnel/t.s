
; 186 bytes -- original
; 178 bytes -- not using line 7 of lookup table
; 168 bytes -- color can wrap
; 167 bytes -- unnecessary clc
; 163 bytes -- no need to init color at beginning
; 154 bytes -- optimize some calculations
; 144 bytes -- compress lookup table
; 142 bytes -- convert jmp to bne/bmi
; 141 bytes -- start X at $D0

H2		= $2C
V2		= $2D
COLOR		= $30
QL		= $F5
QH		= $F6
VL		= $F7
VH		= $F8
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

lookup	=	$80

tunnel:
	; 1 GR:N=23

	jsr	SETGR

	; A is now $D0

uncompress_table:

	tax

;	ldx	#0
uncompress_loop:
	lda	lookup_compressed
	beq	uncompress_done
	pha
	and	#$7
	tay
	pla
	lsr
	lsr
	lsr
store_loop:
	sta	<(lookup-$D0),X		; horrible hack to save a byte
	inx
	dey
	bne	store_loop
	inc	uncompress_loop+1	; assume doesn't cross page boundary
	bne	uncompress_loop		; assume it was never 0


uncompress_done:

.if 0
make_table:
	lda	#$2
	sta	VH
	lda	#$0
	tay
	sta	VL
bigloop:
	lda	#0
	sta	QL
	sta	QH
	tax
qqloop:
	clc
	lda	VL
	adc	QL
	sta	QL
	lda	VH
	adc	QH
	sta	QH
	inx
	cmp	#$28
	bcc	qqloop

	txa
	sta	lookup,Y
	iny

	clc
	lda	VL
	adc	#$24
	sta	VL
	lda	#0
	adc	VH
	sta	VH

	cmp	#$A
	bne	bigloop
.endif


forq:

	; wrapping 255 to 0 is OK
	inc	NEWCOLOR	; moved from end to improve looping


	lda	#6
	sta	Q

qloop:
	; 2 FOR Q=6 TO 0 STEP -1:P=0

	lda	#0
	sta	P

	; 3 FOR I=0 TO 19:IF 20-I>A(P,Q) THEN 7
fori:
	tax		; X is 0

iloop:
	lda	P
	asl
	asl
	asl
	ora	Q
	tay

	txa
	eor	#$FF
	sec
	adc	#20
	cmp	lookup,Y
	bcs	skip

	; 4 P=P+1:Z=39-I:J=I+1:W=Z-1

	inc	P

	; A is already 20-I at this point, carry is clear
	adc	#19
	sta	Z
	tay
	dey
	sty	H2
	sty	V2

	stx	J
	inc	J

	; 6 COLOR=N+P:HLIN J,W AT I:HLIN J,W AT Z:VLIN J,W AT I:VLIN J,W AT Z

	; c always 0?

	lda	P
;	clc
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
blah:
	dec	Q
	bpl	qloop

end:
	; 8 GOTO 2

	bmi	forq




lookup_compressed:
.byte 20<<3+1,19<<3+1,18<<3+1,17<<3+1,16<<3+1,15<<3+1,14<<3+1
.byte 13<<3+2,12<<3+2,11<<3+2,10<<3+3, 9<<3+4, 8<<3+4, 7<<3+6
.byte  6<<3+7, 5<<3+7, 5<<3+5, 4<<3+7, 0


; 0 DIM A(9,9):FOR I=0 TO 8:FOR J=0 TO 8:A(I,J)=40/(2+I+J/7):NEXTJ,I
;lookup:

;.byte 20,13,10,8,7,6,5,4	; 2.0 3.0 4,0 5,0 6.0 7.0 8.0 9.0
;.byte 19,13,10,8,7,6,5,4	; 2.1 3.1 4.1 5.1 6.1 7.1 8.1 9.1
;.byte 18,12,9,8,6,5,5,4
;.byte 17,12,9,7,6,5,5,4
;.byte 16,11,9,7,6,5,5,4
;.byte 15,11,9,7,6,5,5,4
;.byte 14,10,8,7,6,5,5,4




;	(P*7)+Q
;	.byte 20,18,17,16,15,14,14
;	.byte 13,12,12,11,11,10,10
;	.byte 10, 9, 9, 9, 8, 8, 8
;	.byte  8, 7, 7, 7, 7, 7, 6
;	.byte  6, 6, 6, 6, 6, 5, 5
;	.byte  5, 4, 4, 4, 4, 4, 4
;	.byte  4, 4, 4, 4, 4, 4, 4

;	(Q<<8)|P	Q 6..0 P 0..6
;	.byte 20,13,10,8,6,5,5,4	; 0
;	.byte 18,12, 9,7,6,5,4,4	; 1
;	.byte 17,12, 9,7,6,5,4,4	; 2
;	.byte 16,11, 9,7,6,5,4,4	; 3
;	.byte 15,11, 8,7,6,5,4,4	; 4
;	.byte 14,10, 8,7,5,5,4,4	; 5
;	.byte 14,10, 8,6,5,5,4,4	; 6

	; need for bot

	; want this to live at $3F5
	; originally at 38A, so load at $36B

	jmp	tunnel

