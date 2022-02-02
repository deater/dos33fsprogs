	; shimmery blue pattern
	; X=48 here, can't count on others

staggered:
	stx	FRAME				; set FRAME to 48

	ldx	#$00				; init X to 0
	stx	GBASL				; set GBASL to 0

	; pulse loop horizontal
outer_loop:
	lda	#$40				; reset GBASH to begin page2
	sta	GBASH

inner_loop:
	lda	even_lookup,X			; get even color
	sta	(GBASL),Y			; store it to memory
	iny

	lda	odd_lookup,X			; get odd color
	sta	(GBASL),Y			; store it to memory
	iny

	bne	inner_loop			; repeat for 256

	inc	GBASH				; point to next page

	inx					; wrap lookup at 8
	txa
	and	#$7
	tax

	lda	#$60				; see if done
	cmp	GBASH
	bne	inner_loop

;	lda	#100				; A is $60 here
	jsr	WAIT				; pause a bit

	; A is 0 here

	inx					; offset next FRAME

	dec	FRAME				; exit after so many frames

	bne	outer_loop


;even_lookup:
;.byte	$D7,$DD,$F5,$D5, $D5,$D5,$D5,$D5
;odd_lookup:
;.byte	$AA,$AA,$AA,$AB, $AB,$AE,$BA,$EA
