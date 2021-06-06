; based roughly on 5 REM BY @hisham_hm Mar 7 @AppleIIBot

; this one was an accident due to bug trying to get tunnel code working
; very striking, but *warning flashing lights*


H2		= $2C
V2		= $2D
COLOR		= $30
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
	; 10 GR:N=7

	jsr	SETGR
;	bit	FULLGR

	lda	#$7
	sta	NEWCOLOR

outer:
	; 20 FOR X=0 TO 4

	lda	#0
	sta	COUNT

cycle:

	; 30 FOR I=X TO 15+X STEP 5:COLOR=0

	lda	COUNT
	tax

	clc
	adc	#16
	sta	COUNTMAX

iloop:
	lda	#0
	sta	COLOR

	; 40 Z=39-I:J=I+1:W=Z-1

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

	; COLOR=N
	lda	NEWCOLOR
	jsr	SETCOL

	; HLIN J,W AT J ; HLINE Y,$2C at A

	ldy	J
	lda	J
	jsr	HLINE

	; HLIN J,W AT W ; HLINE Y,$2C at A
	ldy	J
	lda	H2
	jsr	HLINE

	; VLIN J,W AT J ; VLINE A,$2D at Y
	ldy	J
	lda	J
	jsr	VLINE

	; VLIN J,W AT W ; VLINE A,$2D at Y
	ldy	V2
	lda	J
	jsr	VLINE


	lda	#150
	jsr	WAIT

	; N=N+1

	inc	NEWCOLOR

	; 50 NEXT:N=N-4

	txa
	clc
	adc	#5
	tax

	cpx	COUNTMAX
	bcc	iloop

	sec
	lda	NEWCOLOR
	sbc	#4
	sta	NEWCOLOR

	; 60 NEXT:N=N-1:IF N=0 THEN N=12

	inc	COUNT
	lda	COUNT
	cmp	#5
	bne	cycle

	dec	NEWCOLOR
	bne	end

	lda	#12
	sta	NEWCOLOR

end:
	; 70 GOTO 20

	jmp	outer
