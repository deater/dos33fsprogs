	;==========
	; page_flip
	;==========

page_flip:
	lda	DRAW_PAGE
	eor	#4
	sta	DRAW_PAGE
	beq	page_flip_show_2	; if draw page now 0, disp page 2
page_flip_show_1:
        bit	PAGE1
	rts								; 6
page_flip_show_2:
	bit	PAGE2							; 4
	rts								; 6

