	;==============================
	; Take Blue Page
	;==============================
	; A should be page to take (i.e. MECHE_PAGE or similar)

take_blue_page:
	pha
	jsr	drop_current_page
	pla

	pha
	eor	BLUE_PAGES_TAKEN	; toggle the taken flag
	sta	BLUE_PAGES_TAKEN
	pla

	ora	#HOLDING_BLUE_PAGE	; put it in hand
	sta	HOLDING_PAGE
	rts


	;==============================
	; Take Red Page
	;==============================
	; A should be page to take (i.e. MECHE_PAGE or similar)

take_red_page:
	pha
	jsr	drop_current_page
	pla

	pha
	eor	RED_PAGES_TAKEN
	sta	RED_PAGES_TAKEN
	pla

	ora	#HOLDING_RED_PAGE
	sta	HOLDING_PAGE
	rts

	;==============================
	; Take White Page
	;==============================

take_white_page:
	pha
	jsr	drop_current_page
	pla

	pha
	lda	#1
	sta	WHITE_PAGE_TAKEN
	pla

	ora	#HOLDING_WHITE_PAGE
	sta	HOLDING_PAGE
	rts

	;==============================
	; Drop current page
	;==============================
	; clicked on a page while holding another
drop_current_page:
	lda	HOLDING_PAGE
	and	#$c0

	cmp	#HOLDING_RED_PAGE
	beq	drop_red_page
	cmp	#HOLDING_BLUE_PAGE
	beq	drop_blue_page
	cmp	#HOLDING_WHITE_PAGE
	beq	drop_white_page

	; there was no page?
	rts

drop_white_page:
	lda	#0
	sta	WHITE_PAGE_TAKEN
	rts

drop_red_page:
	lda	HOLDING_PAGE
	and	#$3f
	eor	RED_PAGES_TAKEN
	sta	RED_PAGES_TAKEN
	rts

drop_blue_page:
	lda	HOLDING_PAGE
	and	#$3f
	eor	BLUE_PAGES_TAKEN
	sta	BLUE_PAGES_TAKEN
	rts


