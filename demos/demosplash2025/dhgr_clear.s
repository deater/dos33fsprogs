
	;===================================
	; clear dhgr screens
	;===================================
clear_dhgr_screens:
	jsr	hgr_clear_screen
	sta	WRAUX
	jsr	hgr_clear_screen
	sta	WRMAIN
	jsr	hgr_page_flip

	jsr	hgr_clear_screen
	sta	WRAUX
	jsr	hgr_clear_screen
	sta	WRMAIN
	jsr	hgr_page_flip

	rts

