; rainbow

; by Vince `deater` Weaver / dSr

; For ???

; zero page locations
H2		= $2C
V2		= $2D
COLOR		= $30
A1L		= $3C
A1H		= $3D
A2L		= $3E
A2H		= $3F
A4L		= $42
A4H		= $43

HGR_COLOR	= $E4
HGR_SCALE	= $E7
HGR_ROTATION	= $E8
FRAME		= $E9

; ROM locations
HGR2		= $F3D8
HPOSN		= $F411
DRAW0		= $F601
XDRAW0		= $F65D
XDRAW1		= $F661
HPLOT0          = $F457

HLINE		= $F819			; HLINE Y,$2C at A
VLINE		= $F828			; VLINE A,$2D at Y
TABV		= $FB5B			; go to A

SETCOL		= $F864

MOVE		= $FE2C		; move mem from A1 thru A2 to A4 (A trashed, Y start 0)

SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
TEXTGR		= $C053
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056	; Enable LORES graphics
HIRES		= $C057	; Enable HIRES graphics







rainbow:
	bit	LORES
	bit	PAGE1
	bit	SET_GR

	lda	#39
	sta	H2

	ldx	#0
rainbow_loop:
	ldy	#$0

	txa
	jsr	SETCOL

	txa
	jsr	HLINE		; draw hline from Y to H2 at A
	inx
	cpx	#48
	bne	rainbow_loop

memory_copy:
	bit	PAGE2

.if 1
	lda	#0		; 2
	tay			; 1

	sta	A1L		; 2
	sta	A2L		; 2
	sta	A4L		; 2
	lda	#$4		; 2
	sta	A1H		; 2
	asl		; $8	; 1
	sta	A2H		; 2
	sta	A4H		; 2
	jsr	MOVE	; move mem from A1 thru A2 to A4 (A trashed, Y start 0)
				; 3
				;=======
				; 21 bytes
.else

	ldy	#0		; 2
cpyloop:
src_smc:
	lda	$400,Y		; 3
dst_smc:
	sta	$800,Y		; 3
	dey			; 1
	bne	cpyloop		; 2
	inc	src_smc+2	; 3
	inc	dst_smc+2	; 3
	lda	dst_smc+2	; 3
	cmp	#$c		; 2
	bne	cpyloop		; 2
				;=====
				; 24 bytes
.endif

done:
	bit	HIRES
	bit	LORES
	jmp	done
