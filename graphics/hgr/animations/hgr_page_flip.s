
hgr_page_flip:
	lda	DRAW_PAGE
	beq	flip_to_page1

flip_to_page2:
	bit	PAGE2
	lda	#0
	beq	done_hgr_page_flip		; bra

flip_to_page1:
	bit	PAGE1
	lda	#$20

done_hgr_page_flip:
        sta     DRAW_PAGE

	rts
