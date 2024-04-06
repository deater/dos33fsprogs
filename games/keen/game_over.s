; GAME OVER MAN

game_over:
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

	lda	#<game_over_text
	sta	OUTL
	lda	#>game_over_text
	sta	OUTH
	jsr	move_and_print_list

	jsr	page_flip

	ldy	#SFX_GAMEOVERSND
	jsr	play_sfx

query_game_over:
	lda     KEYPRESS
	bpl	query_game_over
	bit	KEYRESET

really_game_over:
	lda	#GAME_OVER
	sta	LEVEL_OVER

	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts

game_over_text:
.byte 15,10,"GAME OVER",0
.byte 255
