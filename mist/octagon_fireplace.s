
; button closes/opens fireplace
; code is erased if wrong

; press it when right code, rotates to books

; atrus writing, looks up says something, back down to writing



open_fireplace:

	lda	#OCTAGON_IN_FIREPLACE
	sta	LOCATION

	jmp	change_location

close_fireplace:

	lda	#OCTAGON_IN_FIREPLACE_CLOSED
	sta	LOCATION

	jmp	change_location


fireplace_shelf_action:

	; see if button
fireplace_check_button:
	lda	CURSOR_X
	cmp	#9
	bcs	fireplace_check_book

	lda	CURSOR_Y
	cmp	#32
	bcs	fireplace_nil
	cmp	#20
	bcc	fireplace_nil
	bcs	return_fireplace

	; see if green book
fireplace_check_book:
	lda	CURSOR_Y
	cmp	#26
	bcs	fireplace_check_blue_page
	lda	CURSOR_X
	cmp	#17
	bcc	fireplace_nil
	bcs	open_green_book

	; see if blue page
fireplace_check_blue_page:
	lda	CURSOR_X
	cmp	#14
	bcc	fireplace_nil
	cmp	#20
	bcs	fireplace_check_red_page
	bcc	fireplace_grab_blue_page

	; see if red page
fireplace_check_red_page:
	jmp	fireplace_grab_red_page

	; otherwise, do nothing
fireplace_nil:
	rts

return_fireplace:
	lda	#OCTAGON_IN_FIREPLACE
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION

	jmp	change_location

open_green_book:
	lda	#OCTAGON_GREEN_BOOK
	sta	LOCATION
	jmp	change_location

fireplace_grab_red_page:
	lda	RED_PAGES_TAKEN
	and	#FINAL_PAGE
	bne	missing_page

	lda	#FINAL_PAGE
	jmp	take_red_page

missing_page:
        rts

fireplace_grab_blue_page:
	lda	BLUE_PAGES_TAKEN
	and	#FINAL_PAGE
	bne	missing_page

	lda	#FINAL_PAGE
	jmp	take_blue_page


goto_dni:
	lda	#OCTAGON_DNI
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jmp	change_location
