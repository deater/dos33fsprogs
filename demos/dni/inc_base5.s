
	; four-digit base 5 increment
inc_base5:

	inc	NUMBER_LOW
	lda	NUMBER_LOW
	and	#$f
	cmp	#5
	bne	inc_base5_done

	clc
	lda	NUMBER_LOW
	adc	#$b
	sta	NUMBER_LOW

	lda	NUMBER_LOW
	cmp	#$50
	bne	inc_base5_done

	; if here, overflow to top byte
	lda	#0
	sta	NUMBER_LOW

	inc	NUMBER_HIGH
	lda	NUMBER_HIGH
	and	#$f
	cmp	#5
	bne	inc_base5_done

	clc
	lda	NUMBER_HIGH
	adc	#$b
	sta	NUMBER_HIGH

	lda	NUMBER_HIGH
	cmp	#$50
	bne	inc_base5_done

	lda	#$0
	sta	NUMBER_HIGH

inc_base5_done:
	rts
