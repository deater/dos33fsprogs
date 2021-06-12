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
; 158 bytes - ra-arrange a lot to remove need for XX
; 133 bytes -- undo opt, no lookup table, just raw divide
; 145 bytes -- init stars at beginning, so don't initially run bacward if Z=FF
; 135 bytes -- optimize divide some more
; 143 bytes -- add in different color star
; 142 bytes -- closer :(
;	trying all kinds of stuff, including using BELL for WAIT
; 139 bytes -- just made math innacurate (remove sec in sign correction)

; zero page locations

COLOR		= $30

star_z		= $60
oldx		= $70
oldy		= $80
star_x		= $90
star_y		= $A0

NEGATIVE	= $F9
QUOTIENT	= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF

; soft-switches

LORES		= $C056		; Enable LORES graphics

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

small_starfield:

	;0GR:DIMV(64,48):FORZ=1TO48:FORX=0TO64:V(X,Z)=(X*4-128)/Z+20:NEXTX,Z

	jsr	SETGR		; A is D0 after?

	;===================================
	; draw the stars
	;===================================

	; there are ways to skip this, but on real hardware there's
	; no guarantee star_z will be in a valid state, so waste the bytes

	ldx	#15
make_orig_stars:
	jsr	make_new_star
	dex
	bpl	make_orig_stars

	;===================================
	; starloop

	;2FORP=0TO15

big_loop:
	ldx	#15

	; really tried hard not to have to set this value
	; hard to judge best value for this

	lda	#80
	jsr	WAIT
;	jsr	$FBE4	; BEEP delays too

	; A now 0

star_loop:
	; X=FF

	;===================
	; erase old star

	;4 COLOR=0
	lda	#$00		; color to black
	sta	COLOR

	;PLOT O(P),Q(P)

	ldy	oldx,X
	lda	oldy,X
	jsr	PLOT		; PLOT AT Y,A

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

	; if off-screen then need new star

	bmi	new_star	; if <0
	cmp	#40
	bcs	new_star	; bge >39

	sta	YY		; YY

	;==============================
	; get X/Z
	;	X=V(A(P),Z(P))

	; get XX

	lda	star_x,X	; get X of start

	jsr	do_divide

	tay			; put XX in Y

	; if offscreen then draw new star

	bmi	new_star	; if <0
	cpy	#40
	bcs	new_star	; bge >40

	;========================
	; adjust Z

	;Z(P)=Z(P)-1
	dec	star_z,X
	beq	new_star	; if Z=0 new star

	; draw the star

draw_star:

	; COLOR=15
	dec	COLOR		; color from $00 (black) to $ff (white)

	; trouble causing code, wanted it two-tone
	; this will make it white or blue depending on if odd or even star

	; initially tried distance based color on Z, didn't look as good

	txa
	ror
	bcs	not_far
	jsr	NEXTCOL

not_far:

	;===========================
	; actually plot the star

	;PLOT X,Y
	; O(P)=X:Q(P)=Y

;	ldy	XX		; XX already in Y
	sty	oldx,X		; save for next time to erase

	lda	YY		; YY
	sta	oldy,X		; ;save for next time to erase
	jsr	PLOT		; PLOT AT Y,A

				; a should be F0/20 or 0F/02 here?
	bne	done_star	; bra

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
	and	#$3f		; random ZZ 0..63
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
	adc	#20		; pre-adjust to have star origin mid screen

early_out:
	rts


	; for BASIC bot load

	; need this to be at $3F5
	; it's at 8C, so 6D
	jmp	small_starfield
