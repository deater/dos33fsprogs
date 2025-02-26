PLOT	= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)

SETCOL	= $F864		; COLOR=A
SETGR	= $FB40

FULLGR	= $C052

FRAME	= $F0
YPOS	= $F1
XPOS	= $F2
D	= $F3
C	= $F4
AL	= $F5
AH	= $F6
PRODLO	= $F7
FACTOR2	= $F8
YPL	= $F9
YPH	= $FA
XPL	= $FB
XPH	= $FC
Q	= $FD

	;=============================
	;=============================
	; star path
	;=============================
	;=============================

starpath:
	;=============================
	; setup graphics
	;=============================

	jsr	SETGR			; set graphics
	bit	$C052			; set full-screen graphics

	;=============================
	; initialize
	;=============================

	lda	#0
	sta	FRAME

big_loop:
	lda	#0		; start with YPOS=0
	sta	YPOS
yloop:
	lda	#0		; start with XPOS=0
	sta	XPOS
xloop:
	lda	#14
	sta	D		; start D at 14

loop3:
	lda	YPOS		; YP=Y*4*D
	asl
	asl			; YPOS*4

	tay			; multiply Y*4*D
	lda	D
	jsr	mul8		; definitely 8-bit mul in original

	sta	YPH		; store out to YPH:YPL
	lda	PRODLO
	sta	YPL

	lda	XPOS		; XP=(X*6)-D	curve X by depth
	asl
	sta	XPL
	asl
	clc
	adc	XPL
	sta	XPL		; XPL=X*6

	sta	AL		; AL also is X*6

	sec			; XPL=X*6-D
	sbc	D
	sta	XPL

	bcs	loop4		; IF XP<0 THEN  if left then draw  sky

	lda	#31		; C=31
	sta	C

	clc
	lda	AL
	adc	YPL		; A=X*6+YP
	sta	AL

	lda	#0		; AH
	adc	YPH
	sta	AH

	jmp	loop7	; GOTO7

loop4:
				; Q=XP*D/256  multiply X by current depth
				; want high part
				; definitely 8-bit mul
	ldy	XPL
	lda	D
	jsr	mul8
	ora	YPH		; R=YP/256
	sta	Q		; Q=ora Q,R
				; or for texture pattern
	clc
	lda	D		; add depth plus frame  D+F
	adc	FRAME

	and	Q		; mask geometry by time shifted depth

	sta	C
	inc	D		; D=D+1
	cmp	#16		; IF C<16 THEN 3
	bcc	loop3
loop6:
	jmp	loop9
loop7:
	lda	AL
	cmp	#6
	bcc	loop9
			; 8IF(A&0xff)>6THENC=Y/4+32
	lda	YPOS
	lsr
	lsr
	clc
	adc	#32
	sta	C
loop9:
	lda	C
	lsr
	sec
	sbc	#8
	tax
	lda	color_lookup,X
	jsr	SETCOL			;COLOR=CL(C/2-8)

	ldy	XPOS
	lda	YPOS
	jsr	PLOT			; PLOT AT Y,A (Y preserved)

	inc	XPOS
	lda	XPOS
	cmp	#40
;	bne	xloop
	beq	xloop_done
	jmp	xloop
xloop_done:
	inc	YPOS
	lda	YPOS
	cmp	#48
	;bne	yloop
	beq	yloop_done
	jmp	yloop
yloop_done:
	inc	FRAME

	jmp	big_loop

color_lookup:
.byte	0,5,10,5,10,7,15,15,2,1,3,9,13,12,4,4


; Russian Peasant multiply by Thwaite
; https://www.nesdev.org/wiki/8-bit_Multiply
;
; Multiplies two 8-bit factors to produce a 16-bit product
; in about 153 cycles.
; @param A one factor
; @param Y another factor
; @return high 8 bits in A; low 8 bits in PRODLO
;         Y and FACTOR2 are trashed; X is untouched

mul8:
	; Factor 1 is stored in the lower bits of prodlo; the low byte of
	; the product is stored in the upper bits.

	lsr			; prime the carry bit for the loop
	sta	PRODLO
	sty	FACTOR2
	lda	#0
	ldy	#8
mul8_loop:
	; At the start of the loop, one bit of prodlo has already been
	; shifted out into the carry.
	bcc	mul8_noadd
	clc
	adc	FACTOR2
mul8_noadd:
	ror
	ror	PRODLO		; pull another bit out for the next iteration
	dey		; inc/dec don't modify carry; only shifts and adds do
	bne	mul8_loop
	rts

