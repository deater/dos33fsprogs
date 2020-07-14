	; this is a painful one
	; mostly because the tree puzzle is sort of obscure in the original

	; in original you get a match, then light it
	;	also the match will burn out eventually

	;===================================
	; update backgrounds based on state
	;===================================
cabin_update_state:

	rts


	;====================
	; safe was clicked
	;====================
goto_safe:
	lda	#CABIN_SAFE
	sta	LOCATION
	jmp	change_location

	;====================
	; safe was touched
	;====================
touch_safe:

	lda	CURSOR_Y

	; check if buttons
	cmp	#26		; blt
	bcc	safe_buttons

	; check if handle
	cmp	#34
	bcs	pull_handle	; bge

	; else do nothing
	rts


pull_handle:

	lda	SAFE_HUNDREDS
	cmp	#7
	bne	wrong_combination
	lda	SAFE_TENS
	cmp	#2
	bne	wrong_combination
	lda	SAFE_ONES
	cmp	#4
	bne	wrong_combination

	lda	#CABIN_OPEN_SAFE
	sta	LOCATION

	jmp	change_location

wrong_combination:
	rts

safe_buttons:
	lda	CURSOR_X
	cmp	#13		; not a button
	bcc	no_button
	cmp	#19
	bcc	hundreds_inc
	cmp	#25
	bcc	tens_inc
	bcs	ones_inc

no_button:
	rts

hundreds_inc:
	sed
	lda	SAFE_HUNDREDS
	clc
	adc	#$1
	cld
	and	#$f
	sta	SAFE_HUNDREDS

	rts

tens_inc:
	sed
	lda	SAFE_TENS
	clc
	adc	#$1
	cld
	and	#$f
	sta	SAFE_TENS

	rts

ones_inc:
	sed
	lda	SAFE_ONES
	clc
	adc	#$1
	cld
	and	#$f
	sta	SAFE_ONES

	rts



	;==============================
	; draw the numbers on the safe
	;==============================
draw_safe_combination:

	; hundreds digit

	lda	SAFE_HUNDREDS
	and	#$f
	asl
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#15
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	; tens digit

	lda	SAFE_TENS
	and	#$f
	asl
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#21
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	; ones digit

	lda	SAFE_ONES
	and	#$f
	asl
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#27
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	rts

