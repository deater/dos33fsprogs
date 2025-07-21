	;==========================
	; unpost note
	;==========================
	; default is yes note
	; if kerrek gone then unpost it
unpost_note:

	jsr	check_kerrek_dead
	bcc	done_unpost_note	; if not gone, skip ahead

undraw_note:
	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<note_sprite
	sta	INL
	lda	#>note_sprite
	sta     INH

	lda	#31			; 217/7 = 31
	sta	CURSOR_X
	lda	#105
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

done_unpost_note:

	rts
