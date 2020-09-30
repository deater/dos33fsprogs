	; Title Screen

title_screen:

	;===========================
	; Clear both bottoms

	jsr     clear_bottoms

	;=============================
	; Load title

	lda     #<(title_lzsa)
        sta     getsrc_smc+1
	lda     #>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$0c

	jsr     decompress_lzsa2_fast

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
