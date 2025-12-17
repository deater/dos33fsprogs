	;==========
	; gr flip page
	;==========
gr_page_flip:
	lda	DRAW_PAGE
	beq	gr_draw_page2
gr_draw_page1:
	bit	PAGE2
	lda	#0

	beq	gr_done_flip

gr_draw_page2:
	bit	PAGE1
	lda	#$4

gr_done_flip:
	sta	DRAW_PAGE

	rts

