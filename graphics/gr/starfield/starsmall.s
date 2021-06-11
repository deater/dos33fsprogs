

COLOR		= $30

COUNT		= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF


oldx		= $1000
oldy		= $1040

star_x		= $2000	; should be 0, not used as we never /0
star_y		= $2040
star_z		= $2080


LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
HGR		= $F3E2
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETGR		= $FB40


small_starfield:

	;0GR:DIMV(64,48):FORZ=1TO48:FORX=0TO64:V(X,Z)=(X*4-128)/Z+20:NEXTX,Z

	jsr	HGR

	; init the X/Z tables

	ldy	#63	; Y==z	 for(z=1;z<64;z++) {
	ldx	#0	; X==x
zloop:
	lda	#$ff
	sta	COUNT
	stx	DIVIDEND
	sty	DIVISOR
div_loop:
	inc	COUNT
	sec
	lda	DIVIDEND
	sbc	DIVISOR
	sta	DIVIDEND
	bpl	div_loop

	lda	COUNT
to_smc:
	sta	$5F00,X

	inx
	bne	zloop

	dec	to_smc+2

	dey
	bne	zloop


	;===================================
	; draw the stars
	;===================================

	bit	LORES
	jsr	SETGR

	;===================================
	; starloop

	;2FORP=0TO5
big_loop:
	ldx	#15
star_loop:

	;==============================
	; get X/Z
	;	X=V(A(P),Z(P))

	lda	star_z,X
	asl
	asl
	asl
	asl
	ora	#$20
	sta	xload_smc+2
	sta	xload2_smc+2

	ldy	star_x,X

xload_smc:
	lda	$5F00,Y
	sta	XX
	bmi	new_star
	cmp	#39
	bcs	new_star

	;==============================
	; get Y/Z
	;	Y=V(B(P),Z(P))

	ldy	star_y,X

xload2_smc:
	lda	$5F00,Y
	sta	YY
	bmi	new_star
	cmp	#39
	bcs	new_star

	;Z(P)=Z(P)-1
	dec	star_z,X
	bne	draw_star

new_star:
	;IFX<0ORX>39ORY<0ORY>39ORZ(P)<1THEN
	;	A(P)=RND(1)*64
	;	B(P)=RND(1)*64
	;	Z(P)=RND(1)*48+1:GOTO7

	ldy	FRAME
	lda	$F000,Y
;	and	#$3f
	sta	star_x,X
	lda	$F001,Y
;	and	#$3f
	sta	star_y,X
	lda	$F002,Y
	and	#$3f
	ora	#$1		; avoid 0
	sta	star_z,X
	iny
	iny
	iny
	sty	FRAME

	jmp	done_star

draw_star:

	;4 COLOR=0
	lda	#$00
	sta	COLOR

	;PLOT O(P),Q(P)

	ldy	oldx,X
	lda	oldy,Y
	jsr	PLOT		; PLOT AT Y,A

	; COLOR=15
	dec	COLOR

	;PLOT X,Y

	ldy	XX
	lda	YY
	jsr	PLOT		; PLOT AT Y,A

	; O(P)=X:Q(P)=Y

	lda	XX
	sta	oldx,X
	lda	YY
	sta	oldy,X

done_star:
	;7NEXT

	dex
	bpl	star_loop

	; GOTO2
	jmp	big_loop

	; for BASIC bot load

	jmp	small_starfield
