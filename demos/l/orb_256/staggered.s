

staggered:

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

	dec	FRAME

	bne	outer_loop


;even_lookup:
;.byte	$D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
;odd_lookup:
;.byte	$AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA

