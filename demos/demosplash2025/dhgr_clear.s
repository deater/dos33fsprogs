
	;===================================
	; clear dhgr screens
	;===================================
clear_dhgr_screens:

	; clear page2

	lda	#$20
	sta	DRAW_PAGE

	sta	WRAUX
	jsr	hgr_clear_screen

	sta	WRMAIN
	jsr	hgr_clear_screen

	; clear page1

	lda	#$00
	sta	DRAW_PAGE

	jsr	hgr_clear_screen
	sta	WRAUX

	jsr	hgr_clear_screen
	sta	WRMAIN

	rts

