; FIXME
; handle dropping pages
; handle white page


	;==============================
	; Take Blue Page
	;==============================
	; A should be page to take (i.e. MECHE_PAGE or similar)

take_blue_page:
	jsr	drop_current_page

	eor	BLUE_PAGES_TAKEN	; toggle the taken flag
	sta	BLUE_PAGES_TAKEN

	lda	#HOLDING_BLUE_PAGE	; put it in hand
	sta	HOLDING_PAGE
	rts

take_red_page:

	jsr	drop_current_page

	eor	RED_PAGES_TAKEN
	sta	RED_PAGES_TAKEN

	lda	#HOLDING_RED_PAGE
	sta	HOLDING_PAGE
	rts

take_white_page:

	jsr	drop_current_page

;	lda	#1
;	sta	WHITE_PAGE_TAKEN

	lda	#HOLDING_WHITE_PAGE
	sta	HOLDING_PAGE
	rts

drop_current_page:
	; FIXME

	rts

