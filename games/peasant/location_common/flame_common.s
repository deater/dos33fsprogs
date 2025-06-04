	;====================
	; increment flame
	;====================
increment_flame:
	inc	FLAME_COUNT
	lda	FLAME_COUNT
	cmp	#3
	bne	flame_good

	lda	#0
	sta	FLAME_COUNT

flame_good:
	rts

