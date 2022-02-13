	; shimmery blue pattern
	; X=48 here, can't count on others

staggered:
	stx	FRAME				; set FRAME to 48

	ldx	#$00				; init X to 0
	; we can count on INDEXL (COUNT) being 0 from the orb code
;	stx	INDEXL				; set INDEXL to 0

	; pulse loop horizontal
outer_loop:
	lda	#$40				; reset INDEXH to begin page2
	sta	INDEXH

inner_loop:
	lda	even_lookup,X			; get even color
	sta	(INDEXL),Y			; store it to memory
	iny

	lda	odd_lookup,X			; get odd color
	sta	(INDEXL),Y			; store it to memory
	iny

	bne	inner_loop			; repeat for 256

	inc	INDEXH				; point to next page

	inx					; point to next lookup

	txa					; wrap to 0..7
	and	#$7
	tax

	lda	#$60				; see if done
	cmp	INDEXH
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
