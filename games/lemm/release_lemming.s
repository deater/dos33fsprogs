


        ;=======================
        ; Clear Lemmings Out
        ;=======================
clear_lemmings_out:

	lda	#0
	ldy	#0
clear_lemmings_loop:
	sta	lemming_out,Y
	iny
	cpy	LEMMINGS_TO_RELEASE
	bne	clear_lemmings_loop

	rts

        ;=======================
        ; Init Lemmings
        ;=======================
release_lemming:
	ldy	#0

	lda	#1
	sta	lemming_out,Y
	lda	#0
	sta	lemming_exploding,Y
	lda	INIT_X
	sta	lemming_x,Y
	lda	INIT_Y
	sta	lemming_y,Y
	lda	#LEMMING_RIGHT
	sta	lemming_direction,Y
	lda	#LEMMING_FALLING
	sta	lemming_status,Y

	inc	LEMMINGS_OUT
	jsr	update_lemmings_out

	dec	LEMMINGS_TO_RELEASE


	rts




