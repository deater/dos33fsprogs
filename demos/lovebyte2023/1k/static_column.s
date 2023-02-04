	; shimmery blue pattern


even_lookup=$f000
odd_lookup=$f100


staggered:
;	jsr	HGR2				; after, A=0, Y=0

;	tax					; init X to 0

; set earlier
;	ldx	#0
;	stx	INDEXL				; set INDEXL to 0

	; pulse loop horizontal
outer_loop:
	lda	#$20				; reset INDEXH to begin page1
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

	lda	#$40				; see if done
	cmp	INDEXH
	bne	inner_loop

;	lda	#100				; A is $40 here
	jsr	WAIT				; pause a bit

	; A is 0 here

	inx					; offset next FRAME

	; if FRAMEH is 4 then done

	lda	FRAMEH
	cmp	#4

	bne	outer_loop
