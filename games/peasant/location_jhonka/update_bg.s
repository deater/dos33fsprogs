	;==========================
	; unpost note
	;==========================
	; default is yes note
	; if kerrek gone then unpost it
unpost_note:

	jsr	check_kerrek_dead
	bcc	done_unpost_note	; if not gone, skip ahead

undraw_note:
	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<note_sprite
	sta	INL
	lda	#>note_sprite
	sta     INH

	lda	#31			; 217/7 = 31
	sta	CURSOR_X
	lda	#105
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

done_unpost_note:

	rts


	;==========================
	; place_riches
	;==========================
	; default is no riches
	; if GAME_STATE_3 and KERREK_DEAD and !GOT_RICHES

place_riches:

	lda	GAME_STATE_3
	and	#(KERREK_DEAD|GOT_RICHES)
	cmp	#KERREK_DEAD
	bne	done_place_riches

draw_riches:
	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<riches_sprite
	sta	INL
	lda	#>riches_sprite
	sta     INH

	lda	#13			; 91/7 = 13
	sta	CURSOR_X
	lda	#100
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

done_place_riches:

	rts

	;==========================
	; haystack bg
	;==========================
	; default is haystack there
	; if GAME_STATE_1 & IN_HAY_BALE then overwrrite
haystack_bg:

	lda	GAME_STATE_1
	and	#IN_HAY_BALE

	beq	done_haystack_bg

undraw_haystack:
	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<nostack_sprite
	sta	INL
	lda	#>nostack_sprite
	sta     INH

	lda	#22			; 154/7 = 22
	sta	CURSOR_X
	lda	#37
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

done_haystack_bg:

	rts
