;

update_menu:
	lda	#7
	jsr	set_hcolor

	lda	#168
	ldx	#144
	ldy	#15
	jsr	hgr_hlin	; (x,a) to (x+y,a)

	lda	#191
	ldx	#144
	ldy	#15
	jsr	hgr_hlin	; (x,a) to (x+y,a)

	rts
