	;==============
	; hgr_page_flip
	;==============

hgr_page_flip:
	lda	DISP_PAGE						;
	beq	hgr_page_flip_show_1					;
hgr_page_flip_show_0:
        bit	PAGE0							;
	lda	#$40							;
	sta	HGR_PAGE	; HGR_PAGE=$40				;
	lda	#0							;
	sta	DISP_PAGE	; DISP_PAGE=0				;
	rts								;
hgr_page_flip_show_1:
	bit	PAGE1							;
	lda	#$20
	sta	HGR_PAGE	; DRAW_PAGE=$20				;
	lda	#1							;
	sta	DISP_PAGE	; DISP_PAGE=1				;
	rts								;
