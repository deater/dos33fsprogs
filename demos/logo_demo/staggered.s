; staggered pattern -- Apple II Hires


; D0+ used by HGR routines

;HGR_COLOR	= $E4
;HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

;COUNT		= $FE
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

staggered:

;	jsr	HGR2

	lda	GBASL
	sta	save1

	lda	GBASH
	sta	save2

	lda	FRAME
	sta	save3

	; pulse loop horizontal

	lda	#$00
	tay
	tax
	sta	GBASL
	sta	FRAME

outer_loop:
	lda	#$20
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


	lda	#$40
	cmp	GBASH
	bne	inner_loop

;	lda	#100
	jsr	wait

	inx

;	jmp	outer_loop

	inc	FRAME
	lda	FRAME
	cmp	#255
	bne	outer_loop

	lda	save1
	sta	GBASL

	lda	save2
	sta	GBASH

	lda	save3
	sta	FRAME

	rts


wait:
        sec
wait2:
        pha
wait3:
        sbc     #$01
        bne     wait3
        pla
        sbc     #$01
        bne     wait2
        rts


even_lookup:
.byte	$D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA

save1:	.byte $00
save2:	.byte $00
save3:	.byte $00


