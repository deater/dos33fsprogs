	;==========
	; page_flip
	;==========

page_flip:
	lda	DISP_PAGE						; 3
	beq	page_flip_show_1					; 2nt/3
page_flip_show_0:
        bit	PAGE0							; 4
	lda	#4							; 2
	sta	DRAW_PAGE	; DRAW_PAGE=1				; 3
	lda	#0							; 2
	sta	DISP_PAGE	; DISP_PAGE=0				; 3
	rts								; 6
page_flip_show_1:
	bit	PAGE1							; 4
	sta	DRAW_PAGE	; DRAW_PAGE=0				; 3
	lda	#1							; 2
	sta	DISP_PAGE	; DISP_PAGE=1				; 3
	rts								; 6
							;====================
							; DISP_PAGE=0 	26
							; DISP_PAGE=1	24

