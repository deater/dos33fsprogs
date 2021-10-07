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

	; set to F0 for shorter weird intro

;	ldx	#$0

outer_loop:


	; pulse loop horizontal

	lda	#$00
	tay

	sta	GBASL

	lda	#$40
	sta	GBASH
horiz_loop:

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
	bne	horiz_loop



	lda	#$44
	sta	smc+2


vert_loop:
	txa
	clc
	adc	#2
	asl
	asl
	adc	#$40
	sbc	smc+2
	cmp	#8
	lda	#$81
	bcs	noeor
	ora	#$02
noeor:

smc:
	sta	$4400

	inc	smc+1
	inc	smc+1
	bne	noflo
	inc	smc+2
noflo:
	ldy	#$60
	cpy	smc+2
	bne	vert_loop

	inx			; wrap at 7
	cpx	#7
	bne	noreset

	ldx	#0
noreset:

	; wait

	tya			; wait $60
	jsr	WAIT

	jmp	outer_loop



even_lookup:
.byte	$D7,$DD,$F5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA, $AB,$AE,$BA,$EA

