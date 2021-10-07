; wires -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

D		= $F9
XX		= $FA
YY		= $FB
R		= $FC
CX		= $FD
CY		= $FE
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



	ldy	#0
horiz_loop:
	lda	#$D5
	sta	(GBASL),Y
	iny
	lda	#$AA
	sta	(GBASL),Y
	iny
	bne	horiz_loop

	inc	GBASH
	lda	GBASH
	cmp	#$44
	bne	horiz_loop


end:
	jmp	end
