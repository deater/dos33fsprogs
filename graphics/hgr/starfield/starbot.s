; starfield tiny -- Apple II Hires

; by Vince `deater` Weaver

; 139 bytes -- lores version
; 157 bytes -- initial hires
; 155 bytes -- scale to more of full screen
; 153 bytes -- blue/orange instead of purple/green
; 149 bytes -- optimize 2nd plot arg shuffling
; 148 bytes -- optimize 1st plot arg shuffling
; 140 bytes -- turn off all range checking except Z

NUMSTARS	= 27		; 27 good, 28+ not work ($1C)

; zero page locations

star_z		= $00

HGR_BITS	= $1C

; 1C-40 has some things used by hires

oldx		= $50
oldy		= $70
star_x		= $90
star_y		= $B0

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

SAVEX		= $F8
TEMP		= $F9
QUOTIENT	= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF

; soft-switches

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
BELL2		= $FBE4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

small_starfield:

	;0GR:DIMV(64,48):FORZ=1TO48:FORX=0TO64:V(X,Z)=(X*4-128)/Z+20:NEXTX,Z

	jsr	HGR2		; A is ? after

	;===================================
	; draw the stars
	;===================================

	; there are ways to skip this, but on real hardware there's
	; no guarantee star_z will be in a valid state, so waste the bytes

	ldx	#NUMSTARS
make_orig_stars:
	jsr	make_new_star
	dex
	bpl	make_orig_stars

	;===================================
	; starloop

	;2FORP=0TO15

big_loop:
	ldx	#NUMSTARS

	; really tried hard not to have to set this value
	; hard to judge best value for this

;	lda	#100
;	jsr	WAIT

	ldy	#80
	jsr	BELL2	; BEEP delays too

	; A now 0

star_loop:
	; X=FF

	;===================
	; erase old star

	;4 COLOR=0
	lda	#$00		; color to black
	sta	HGR_COLOR	; set HGR_COLOR to value in X

	;HPLOT O(P),Q(P)

	stx	SAVEX

	lda	oldy,X
	pha
	lda	oldx,X		; get X valu into Y
	tax
	pla

	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	SAVEX

	;===========================
	; position Z

;	lda	star_z,X
;	beq	new_star	; should never happen
;	sta	DIVISOR

	; DIVISOR always star_z,X so can hard code this in divide routine

	;==============================
	; get Y/Z
	;	Y=V(B(P),Z(P))

	; get YY

	lda	star_y,X	; get Y of star

	jsr	do_divide
	adc	#96

	; if off-screen then need new star

;	cmp	#192
;	bcs	new_star	; bge >39
;	cmp	#0
;	bcc	new_star	; if <0


	sta	YY		; YY
	sta	oldy,X		; ;save for next time to erase


	;==============================
	; get X/Z
	;	X=V(A(P),Z(P))

	; get XX

	lda	star_x,X	; get X of start

	jsr	do_divide
	adc	#140		; center

	tay			; put XX in Y
	sty	oldx,X		; save for next time to erase

	; if offscreen then draw new star

;	bmi	new_star	; if <0
;	cpy	#40
;	bcs	new_star	; bge >40

	;========================
	; adjust Z

	;Z(P)=Z(P)-1
	dec	star_z,X
	beq	new_star	; if Z=0 new star

	; draw the star

draw_star:

;	lda	#$7f		; white (with green/purple highlights)
;	sta	HGR_COLOR	; set HGR_COLOR to value in X

	dec	HGR_COLOR	; smaller, but blue/orange highlights


	;===========================
	; actually plot the star

	;HPLOT X,Y
	; O(P)=X:Q(P)=Y

	stx	SAVEX

	tya			; XX in Y
	tax			; XX now in X

	lda	YY		; YY

	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	SAVEX

	jmp	done_star	; bra

new_star:
	jsr	make_new_star	;

done_star:
	;7NEXT

	dex
	bpl	star_loop

	; GOTO2
	bmi	big_loop	; bra


	;===========================
	; NEW STAR
	;===========================

make_new_star:
	;IFX<0ORX>39ORY<0ORY>39ORZ(P)<1THEN
	;	A(P)=RND(1)*64
	;	B(P)=RND(1)*64
	;	Z(P)=RND(1)*48+1:GOTO7

	ldy	FRAME
	lda	$F000,Y
	sta	star_x,X	; random XX

color_lookup:
	lda	$F100,Y
	sta	star_y,X	; random YY

	lda	$F002,Y
	and	#$1f		; random ZZ 0..127 (can't go negative or stars move backward)
	ora	#$1		; avoid 0
	sta	star_z,X

	inc	FRAME

	rts

	;=============================
	; do signed divide
	;	the signed part is the pain
	;=============================
	; Z is in divisor
	; x/y is in A

do_divide:
	; A was just loaded so flags still valid
	php
	bpl	not_negative

	eor	#$ff			; make positive for division
	clc				; is this necessary?
	adc	#1

not_negative:

	ldy	#$ff		; QUOTIENT
div_loop:
	iny			;	inc	QUOTIENT
	sec
	sbc	star_z,X	; DIVIDEND=DIVIDEND-DIVISOR
	bpl	div_loop

	; write out quotient
	tya			; lda	QUOTIENT

	plp
	bpl	pos_add

	eor	#$ff
;	sec			; FIXME: made math inaccurate to save room
;	bcs	do_add

pos_add:
	clc
do_add:


early_out:
	rts


	; for BASIC bot load

	; need this to be at $3F5
	; it's at 89, so 6C
	jmp	small_starfield
