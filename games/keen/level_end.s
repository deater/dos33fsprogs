; Print bonuses

level_end:
	bit	KEYRESET		; clear keyboard
	bit	SET_TEXT

	lda	#12
	sta	drawbox_x1
	lda	#26
	sta	drawbox_x2
	lda	#19
	sta	drawbox_y1
	lda	#23
	sta	drawbox_y2

	lda	#21
	sta	bonus_text+1

scroll_bonus_loop:
	lda     #' '|$80
        sta     clear_all_color+1
	jsr	clear_all

	jsr	drawbox

	jsr	normal_text

	lda	#<bonus_text
	sta	OUTL
	lda	#>bonus_text
	sta	OUTH
	jsr	move_and_print_list

	jsr	page_flip

	lda	#220
	jsr	WAIT
	lda	#220
	jsr	WAIT

level_end_wait:
	lda     KEYPRESS
	bmi	really_end_level

	dec	drawbox_y1
	dec	drawbox_y2
	dec	bonus_text+1

	lda	drawbox_y1
	bmi	really_end_level

	jmp	scroll_bonus_loop

really_end_level:
	bit	KEYRESET
	lda	#NEXT_LEVEL
	sta	LEVEL_OVER

	jsr	clear_all

	rts

bonus_text:
.byte 14,10,"BONUS: NONE",0
.byte 255
