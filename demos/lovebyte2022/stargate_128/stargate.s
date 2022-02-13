; Stargate in 121 bytes!

; a 128-byte intro for Lovebyte 2022
; by Deater / Desire

; this came about by accident while I was trying to convert
; a BASIC square tunnel effect by @hisham_hm that was on
; the @AppleIIBot on 7 March 2021

; There are at least two bugs.  COUNT (and thus X) gets the wrong
;	value and never resets, mostly due to the jmp at the end going
;	to the wrong place.  The init of COUNTMAX is wrong too

H2		= $2C
V2		= $2D
COLOR		= $30
J		= $FB
Z		= $FC
COUNTMAX	= $FD
COUNT		= $FE
NEWCOLOR	= $FF

SPEAKER		= $C030
FULLGR		= $C052



HLINE   = $F819                 ;; HLINE Y,$2C at A
VLINE   = $F828                 ;; VLINE A,$2D at Y
SETCOL	= $F864		; COLOR=A
SETGR	= $FB40
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

tunnel:
	; 10 GR:N=7

	jsr	SETGR
	bit	FULLGR

	lda	#$7
	sta	NEWCOLOR


	; 20 FOR X=0 TO 4

	lda	#0
	sta	COUNT

	clc
	adc	#16
	sta	COUNTMAX
cycle:

	; 30 FOR I=X TO 15+X STEP 5:COLOR=0

;	bit	SPEAKER

	ldx	COUNT
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
	; VLIN J,W AT Z	; VLINE A,$2D at Y


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
	; VLIN J,W AT W ; VLINE A,$2D at Y

	; N=N+1

	inc	NEWCOLOR

	lda	#75
	jsr	WAIT

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
	cmp	#4
	bne	cycle

	dec	NEWCOLOR
	bne	end

	lda	#12
	sta	NEWCOLOR

end:
	; 70 GOTO 20

	jmp	cycle

