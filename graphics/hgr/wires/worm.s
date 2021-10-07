; wires -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

COUNT		= $FE
FRAME		= $FF

; soft-switches

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
COLORTBL	= $F6F6
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
BELL2		= $FBE4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

wires:

	jsr	HGR2

	lda	#$00
	sta	GBASL
	lda	#$40
	sta	GBASH


	lda	#$81
vert_loop:

smc:
	sta	$4000
	eor	#$1

	inc	smc+1
	bne	noflo
	inc	smc+2
noflo:
	ldy	smc+2
	cpy	#$60
	bne	vert_loop


	; pulse loop horizontal

	ldy	#0
	ldx	#0

	lda	#$00
	sta	GBASL
outer_loop:
	lda	#$40
	sta	GBASH
inner_loop:

	lda	even_lookup,X
	sta	(GBASL),Y
	iny

	lda	odd_lookup,X
	sta	(GBASL),Y

	iny
	bne	noflo2
	inc	GBASH
noflo2:

	lda	#$44
	cmp	GBASH
	bne	inner_loop





	; pulse loop vertical
	lda	#0
	sta	GBASL

	lda	addr_lookup,X
	sta	GBASH

	ldy	#0
	sty	COUNT
vouter:


vinner:
	lda	(GBASL),Y
	eor	#$1
	sta	(GBASL),Y

	iny
	iny

	bne	vinner

blargh:
	inc	GBASH
	inc	COUNT
	lda	COUNT
	cmp	#4
	bne	vouter



	inx
	txa
	and	#$7
	tax

	lda	#100
	jsr	WAIT

	jmp	outer_loop



even_lookup:
.byte	$D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA
addr_lookup:
.byte	$44,$48,$4C,$50, $54,$58,$5C,$20
