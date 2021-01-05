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
	clc
	adc	menu_offset
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
	jsr	get_keypress

	; keypress is in A

	cmp	#0
	beq	menu_nothing
	cmp	#'A'
	beq	dec_menu
	cmp	#'W'
	beq	dec_menu
	cmp	#'S'
	beq	inc_menu
	cmp	#'D'
	beq	inc_menu
	cmp	#' '
	beq	menu_select
	cmp	#13
	beq	menu_select
	bne	menu_nothing

inc_menu:
	lda	menu_offset
	cmp	menu_max
	bcs	menu_nothing		; don't go above max
	inc	menu_offset
	jmp	menu_nothing

dec_menu:
	lda	menu_offset
	beq	menu_nothing		; can't go below 0
	dec	menu_offset
	jmp	menu_nothing

menu_select:
	lda	menu_offset
	jmp	done_menu

menu_nothing:
	lda	#$ff
done_menu:
	sta	MENU_RESULT

	rts

menu_x:		.byte	12
menu_y:		.byte	21
menu_max:	.byte	2
menu_offset:	.byte	0
