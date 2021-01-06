	; print menu selection, draw to draw page

	; use arrow keys to scroll
	; return/space selects

	; X = num entries
	; Y = start Y?
	; OUTL/OUTH points to list to draw

	; return number of response in A
	; $FF = nothing
	; 0..# is number of selection chosen

draw_menu:

	; clear bottom

	jsr	clear_bottom

	; make normal?

	; draw list

	jsr	move_and_print_list

	; draw arrow

	lda	menu_y
	asl
	tay
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH
	clc
	lda	gr_offsets,Y
	adc	menu_x
	sta	OUTL

	ldy	#0
	lda	#'-'
	sta	(OUTL),Y
	iny
	sta	(OUTL),Y
	iny
	lda	#'>'
	sta	(OUTL),Y

	; check keypress

	lda	#$ff
	sta	MENU_RESULT

	rts


menu_x:	.byte	12
menu_y: .byte	21
