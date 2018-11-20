
	;==========================================================
	; set_gr_page0
	;==========================================================
	;
set_gr_page0:
	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	TEXTGR			; mixed gr/text mode
	bit	SET_GR			; set graphics
	rts

