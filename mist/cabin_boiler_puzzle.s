	; this is a painful one
	; mostly because the tree puzzle is sort of obscure in the original

	; in original you get a match, then light it
	;	the match will flicker and burn out if you go outside

	; light the pilot, it will turn red
	; PSI starts at zero
	;	turn once clockwise, fire starts, nothing else?
	;	turn once counter-clockwise fire turns off
	;	turn twice CW -> ?
	;	turn 3 CW -> ?
	;	turn 4, 5, 6, 7, 8, 9, 10, 11, 12,  CW -> ? 
	;		can turn up to 25
	;	at 12 starts gradually going up
	;		(needle swings hits end, waits like 5s, goes up)
	;	0 - basement
	;	1 - down 1/2
	;	2 - down 1
	;	3 - half out
	;	4 - all out (can get on)    *
	;	5 -
	;	6 - *
	;	7 -
	;	8 - *
	;	9 -
	;	10 - *
	;	11 -
	;	12 - * (top)  (can look down at all spots)
	; button takes you down a level, but only to ground floor
	;	will actually  bump you back to Level 3 if you press on ground
	; button does nothing in basement
	; dial in basement does same as one upstairs


tree_base_backgrounds:
	.word	tree_base_n_lzsa	; 0 basement
	.word	tree_base_n_lzsa	; 1 underground
	.word	tree_base_l4_n_lzsa	; 2 ground
	.word	tree_base_l6_n_lzsa	; 3 L6
	.word	tree_base_n_lzsa	; 4 L8
	.word	tree_base_n_lzsa	; 5 L10
	.word	tree_base_n_lzsa	; 6 TOP

tree_base_up_backgrounds:
	.word	tree_base_up_lzsa	; 0 basement
	.word	tree_base_up_l2_lzsa	; 1 underground
	.word	tree_base_up_l4_lzsa	; 2 ground
	.word	tree_base_up_l6_lzsa	; 3 L6
	.word	tree_base_up_l8_lzsa	; 4 L8
	.word	tree_base_up_l10_lzsa	; 5 L10
	.word	tree_base_up_l12_lzsa	; 6 TOP

tree_elevator_backgrounds:
	.word	tree_base_n_lzsa	; 0 basement
	.word	tree_base_n_lzsa	; 1 underground
	.word	tree_base_n_lzsa	; 2 ground
	.word	tree_base_n_lzsa	; 3 L6
	.word	tree_base_n_lzsa	; 4 L8
	.word	tree_base_n_lzsa	; 5 L10
	.word	tree_base_n_lzsa	; 6 TOP



;	\ \ \ \ \ : / / / / /
;	        P S I
;        \

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
	; open safe was touched
	;====================
	; close safe or take/light match

	; how does this interact with holding a page?

touch_open_safe:

	lda	CURSOR_X
	cmp	#21
	bcc	handle_matches

	; touching door
touching_safe_door:
	lda	#CABIN_SAFE
	sta	LOCATION
	jmp	change_location

handle_matches:
	lda	CURSOR_Y
	cmp	#32
	bcc	not_matches
	cmp	#41
	bcs	not_matches

	lda	HOLDING_ITEM
	cmp	#HOLDING_LIT_MATCH
	beq	not_matches
	cmp	#HOLDING_MATCH
	beq	light_match

	; not a match yet
take_match:
	lda	#HOLDING_MATCH
	sta	HOLDING_ITEM
	bne	not_matches	; bra

light_match:
	lda	#HOLDING_LIT_MATCH
	sta	HOLDING_ITEM

not_matches:
	rts



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

	lda	#DIRECTION_W|DIRECTION_ONLY_POINT
	sta	DIRECTION

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

