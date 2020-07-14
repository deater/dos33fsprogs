	; this is a painful one

goto_safe:
	lda	#CABIN_SAFE
	sta	LOCATION
	jmp	change_location
