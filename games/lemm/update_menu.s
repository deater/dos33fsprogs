;

update_menu:
	lda	#7
	jsr	set_hcolor

	; two hlins

	ldx	#144
	lda	#168
	ldy	#15
	jsr	hgr_hlin	; (x,a) to (x+y,a)

	ldx	#144
	lda	#191
	ldy	#15
	jsr	hgr_hlin	; (x,a) to (x+y,a)

	; two vlins

	ldx	#144
	lda	#168
	ldy	#47
	jsr	hgr_vlin	; (x,a) to (x,a+y)

	ldx	#159
	lda	#168
	ldy	#47
	jsr	hgr_vlin	; (x,a) to (x,a+y)

	rts
