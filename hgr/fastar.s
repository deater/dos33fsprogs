DRAW_PAGE = $E6
ZL	= $06
ZH	= $07
SEEDLO	= $4E
SEEDHI	= $4F

NUM1	=	$F0
NUM1L	=	$F1
NUM2	=	$F2
NUM2L	=	$F3
RESULT	=	$F4
RESULT2	=	$F5
RESULT3	=	$F6
RESULT4	=	$F7
XL	=	$F8
XH	=	$F9
YL	=	$FA
YH	=	$FB
MINUS	=	$FC
Z	=	$FD

HGR2	=	$F3D8
HPLOT0	=	$F457	; plot (Y,X), (A)
HGLIN	=	$F53A	; plot to (A,X), (Y)
HCLEAR0 =	$F3F2	; clear current hgr page to blackh
HCOLOR	=	$F6F0	; color in X (must be 0..7)


	lda	#$ff
	sta	XH

	ldx	#0

	jmp	check_bounds
populate_loop:
				; Z   = XXYY YYYY
; C=Z*.125
; A=A+(A-64)*C
; B=B+(B-64)*C



				; X is in NUM1 for this

	lda	#0
	sta	MINUS

	sec
	lda	XH
	sbc	#64
	bpl	no_minus
set_minus:
	inc	MINUS

	sec
	lda	#0
	sbc	XL
	sta	NUM1
	lda	#0
	sbc	XH
	sta	NUM1+1
	jmp	do_mult

no_minus:
	sta	NUM1+1
	lda	XL
	sta	NUM1

do_mult:
	lda	#0
	sta	NUM2+1
	lda	Z
	sta	NUM2

	txa
	pha

	jsr	mult16

	pla
	tax

	; result has result but due to our fixed point
	; we want to shift the whole thing left by 2
	; then grab RESULT+2 as high and RESULT+1 as low

	rol	RESULT+1
	rol	RESULT+2
	ror	RESULT+1
	lda	RESULT+2

	lda	RESULT+1	; low
	sta	NUM1
	lda	RESULT+2	; hight
	sta	NUM1+1

	; add to X; subtract if minus
	lda	MINUS
	beq	not_minus

	sec
	lda	#00
	sbc	NUM1
	sta	NUM1
	lda	#00
	sbc	NUM1+1
	sta	NUM1+1

not_minus:
	clc
	lda	XL
	adc	NUM1
	sta	XL
	lda	XH
	adc	NUM1+1
	sta	XH

	; Z=Z+.125

	clc
	lda	Z
	adc	#$8
	sta	Z


	; check to see if out of bounds
check_bounds:
	lda	XH
	bmi	redo_point
	lda	YH
	bpl	all_good

redo_point:
	; store a break in the lines
	lda	#0
	sta	$1000,X
	sta	$1100,X
	sta	Z	; needed?
	inx

	jsr	rand16
	sta	XH
	jsr	rand16
	sta	YH

all_good:


	; write out

	lda	XH
	sta	$1000,X
	lda	YH
	sta	$1100,X

	inx
	beq	done_pop
	jmp	populate_loop
done_pop:
	;=========================
	;=========================
	;=========================

	jsr	HGR2
	ldx	#3
	jsr	HCOLOR

	ldx	#0
star_loop:
	txa
	and	#$1
	beq	page2
page1:			; draw page1, show page2
	bit	$C055
	lda	#$20
	bne	adjust_page
page2:
	bit	$C054
	lda	#$40
adjust_page:
	sta	DRAW_PAGE

	; clear background
	jsr	HCLEAR0

	txa
	pha

	lda	$1100,X		; ycoord
	beq	skip_draw
	pha
	ldy	$1000,X		; xcoord
	tya
	tax
	ldy	#0
	pla

	jsr	HPLOT0		; plot (Y,X), (A)

skip_draw:

	pla
	tax

	inx
	jmp	star_loop


	; make sure seed isn't 0000
rand16:
	; batari rand16
	lda	SEEDHI
	lsr
	rol	SEEDLO
	bcc	noeor
	eor	#$B4
noeor:
	sta	SEEDHI
	eor	SEEDLO

	; we only want 127 bits
	and	#$7f

	rts


	;=====================
	;=====================
	; 16x16 -> 32 multiply
	;=====================
	;=====================
	; destroys NUM2
mult16:
	lda	#0		; Initialize RESULT to 0
	sta	RESULT+2
	ldx	#16		; There are 16 bits in NUM2
L1:
	lsr	NUM2+1		; top part of 16 bit shift right
	ror	NUM2
	bcc	L2		; 0 or 1?
	tay			; If 1, add NUM1 (hi byte of RESULT is in A)
	clc
	lda	NUM1
	adc	RESULT+2
	sta	RESULT+2
	tya
	adc	NUM1+1
L2:
	ror			; "Stairstep" shift
	ror	RESULT+2
	ror	RESULT+1
	ror	RESULT
	dex
	bne	L1
	sta	RESULT+3

	rts
