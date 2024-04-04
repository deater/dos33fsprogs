; Quit?  Are you sure?

print_quit:
	bit	KEYRESET		; clear keyboard
	bit	SET_TEXT

	lda     #' '|$80
        sta     clear_all_color+1
	jsr	clear_all

	lda	#6
	sta	drawbox_x1
	lda	#33
	sta	drawbox_x2
	lda	#8
	sta	drawbox_y1
	lda	#13
	sta	drawbox_y2
	jsr	drawbox

	jsr	normal_text

	lda	#<quit_text
	sta	OUTL
	lda	#>quit_text
	sta	OUTH
	jsr	move_and_print_list

	jsr	page_flip

query_quit:
	lda     KEYPRESS
	bpl	query_quit
	bit	KEYRESET

	cmp	#'Y'|$80
	beq	really_quit
	cmp	#'y'|$80
	beq	really_quit

	bit	SET_GR
	rts

really_quit:
	lda	#GAME_OVER
	sta	LEVEL_OVER

	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts

quit_text:
.byte 8,10,"ARE YOU SURE YOU WANT TO",0
.byte 14,11,"QUIT? (Y/N)",0
.byte 255
