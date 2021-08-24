; Move that Peasant!

move_peasant:

	; redraw peasant if moved

	lda	PEASANT_XADD
	ora	PEASANT_YADD
	beq	peasant_the_same

	; restore bg behind peasant

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_7x30

	; move peasant

	clc
	lda	PEASANT_X
	adc	PEASANT_XADD
	bmi	peasant_x_negative
	cmp	#40
	bcs	peasant_x_toobig		; bge
	bcc	done_movex

	;============================
peasant_x_toobig:

	inc	MAP_X

	jsr	new_map_location

	lda	#0		; new X location

	jmp	done_movex

	;============================
peasant_x_negative:

	dec	MAP_X

	jsr	new_map_location

	lda	#39		; new X location

	jmp	done_movex

	; check edge of screen
done_movex:
	sta	PEASANT_X


	; Move Peasant Y

	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD
	cmp	#45
	bcc	peasant_y_negative		; blt
	cmp	#150
	bcs	peasant_y_toobig		; bge
	bcc	done_movey


	;============================
peasant_y_toobig:

	inc	MAP_Y

	jsr	new_map_location

	lda	#45		; new X location

	jmp	done_movey


	;============================
peasant_y_negative:

	dec	MAP_Y

	jsr	new_map_location

	lda	#150		; new X location

	jmp	done_movey

	; check edge of screen
done_movey:
	sta	PEASANT_Y

	; if we moved off screen, don't re-draw peasant

        lda     GAME_OVER
        bne     peasant_the_same

	; save behind new position

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_7x30

	; draw peasant

	jsr	draw_peasant

peasant_the_same:

	rts

