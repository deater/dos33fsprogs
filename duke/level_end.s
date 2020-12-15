; Print bonuses

level_end:
	bit	KEYRESET		; clear keyboard
	bit	SET_TEXT

	lda     #' '|$80
        sta     clear_all_color+1
	jsr	clear_all

	lda	#12
	sta	drawbox_x1
	lda	#26
	sta	drawbox_x2
	lda	#8
	sta	drawbox_y1
	lda	#12
	sta	drawbox_y2
	jsr	drawbox

	jsr	normal_text

	lda	#<bonus_text
	sta	OUTL
	lda	#>bonus_text
	sta	OUTH
	jsr	move_and_print_list

	jsr	page_flip

level_end_wait:
	lda     KEYPRESS
	bpl	level_end_wait
	bit	KEYRESET

really_end_level:
	lda	#NEXT_LEVEL
	sta	LEVEL_OVER

	; FIXME: point to next level
	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts

bonus_text:
.byte 14,10,"BONUS: NONE",0
.byte 255
