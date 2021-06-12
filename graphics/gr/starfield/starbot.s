; starfield tiny -- Apple II Lores

; by Vince `deater` Weaver

; actually too fast

; 189 bytes - original
; 184 bytes - move DIVIDEND to A
; 173 bytes - move variables to 0 page. limits to 16 stars but that's fine?
; 171 bytes - adjust random # generator
; 170 bytes - can do sty zp,x
; 163 bytes - lose the cool HGR intro
; 161 bytes - re-arrange RNG location

COLOR		= $30

QUOTIENT	= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF

oldx		= $80
oldy		= $90
star_x		= $A0
star_y		= $B0
star_z		= $C0

;oldx		= $1000
;oldy		= $1040
;star_x		= $2000	; should be 0, not used as we never /0
;star_y		= $2040
;star_z		= $2080


LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
HGR		= $F3E2
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

small_starfield:

	;0GR:DIMV(64,48):FORZ=1TO48:FORX=0TO64:V(X,Z)=(X*4-128)/Z+20:NEXTX,Z

	jsr	SETGR

	; init the X/Z tables

	ldy	#63	; Y==z	 for(z=1;z<64;z++) {
xloop:
	ldx	#0	; X==x
zloop:
	lda	#$ff
	sta	QUOTIENT
;	stx	DIVIDEND
	sty	DIVISOR
	txa		; DIVIDEND
div_loop:
	inc	QUOTIENT
	sec
;	lda	DIVIDEND
	sbc	DIVISOR
;	sta	DIVIDEND
	bpl	div_loop

	; write out quotient

	lda	QUOTIENT
	pha
	clc
	adc	#20
to_smc:
	sta	$5F80,X

	inx
	bpl	zloop	; loop until 128


	; reverse and write out negative parts

	ldx	#0
negative_loop:
	pla
	eor	#$ff
	sec
	adc	#20
to2_smc:
	sta	$5F00,X
	inx
	bpl	negative_loop

	dec	to_smc+2
	dec	to2_smc+2

	dey
	bne	xloop


	;===================================
	; draw the stars
	;===================================

;	bit	LORES
;	jsr	SETGR

	;===================================
	; starloop

	;2FORP=0TO5
big_loop:
	ldx	#15
star_loop:

	;==============================
	; get X/Z
	;	X=V(A(P),Z(P))

	; position Z
	lda	star_z,X
	clc
	adc	#$20		; tables in $20-$5F
	sta	xload_smc+2
	sta	xload2_smc+2

	; get XX
	ldy	star_x,X
xload_smc:
	lda	$5F00,Y
	sta	XX

	bmi	new_star	; if <0
	cmp	#40
	bcs	new_star	; bge >40

	;==============================
	; get Y/Z
	;	Y=V(B(P),Z(P))

	; get YY

	ldy	star_y,X
xload2_smc:
	lda	$5F00,Y
	sta	YY

	bmi	new_star	; if <0
	cmp	#40
	bcs	new_star	; bge >39

	;Z(P)=Z(P)-1
	dec	star_z,X
	beq	new_star	; if Z=0 new star

	; draw the star

draw_star:

	;4 COLOR=0
	lda	#$00
	sta	COLOR

	;PLOT O(P),Q(P)

	ldy	oldx,X
	lda	oldy,X
	jsr	PLOT		; PLOT AT Y,A

	; COLOR=15
	dec	COLOR

	;PLOT X,Y
	; O(P)=X:Q(P)=Y

	ldy	XX
	sty	oldx,X

	lda	YY
	sta	oldy,X
	jsr	PLOT		; PLOT AT Y,A

				; a should be F0 or 0F here?
	bne	done_star

new_star:
	;IFX<0ORX>39ORY<0ORY>39ORZ(P)<1THEN
	;	A(P)=RND(1)*64
	;	B(P)=RND(1)*64
	;	Z(P)=RND(1)*48+1:GOTO7

	ldy	FRAME
	lda	$F000,Y
	sta	star_x,X	; random XX

	lda	$F001,Y
	sta	star_y,X	; random YY

	lda	$F002,Y
	and	#$3f		; random ZZ 0..63
	ora	#$1		; avoid 0
	sta	star_z,X

	inc	FRAME


done_star:
	;7NEXT

	dex
	bpl	star_loop

	lda	#100
	jsr	WAIT		; A is 0 after

	; GOTO2
	beq	big_loop	; bra

	; for BASIC bot load

	; need this to be at $3F5

	jmp	small_starfield
