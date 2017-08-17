	; Title Screen

title_screen:

	;===========================
	; Clear both bottoms

	lda	#$0
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#$4
	sta	DRAW_PAGE
	jsr     clear_bottom

	;=============================
	; Load title_rle

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen 0xc00

	lda     #>(title_rle)
        sta     GBASH
	lda     #<(title_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	lda	#20
	sta	YPOS
	lda	#20
	sta	XPOS

	;=================================
	; wait for keypress

	jsr	wait_until_keypressed

	rts
