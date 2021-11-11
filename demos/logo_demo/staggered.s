; staggered pattern -- Apple II Hires


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

	; pulse loop horizontal

	lda	#$00
	tay
	tax
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
	bne	inner_loop

	inc	GBASH

	inx
	txa
	and	#$7
	tax


	lda	#$60
	cmp	GBASH
	bne	inner_loop

;	lda	#100
	jsr	WAIT

	inx

	jmp	outer_loop



even_lookup:
.byte	$D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA

