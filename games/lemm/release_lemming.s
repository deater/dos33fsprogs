
        ;=======================
        ; Clear Lemmings Out
        ;=======================
clear_lemmings_out:

	lda	#0
	ldy	#0
clear_lemmings_loop:
	sta	lemming_out,Y
	iny
	cpy	#MAX_LEMMINGS
	bne	clear_lemmings_loop

	rts

        ;=======================
        ; Release Lemmings
        ;=======================
	; TODO: adjust speed based on release speed
release_lemming:

	; don't release if we've released them all
	lda	LEMMINGS_TO_RELEASE
	beq	done_release_lemmings

	; don't release if door is still opening
	lda	DOOR_OPEN
	beq	done_release_lemmings

	; only release every X frames
	lda	FRAMEL
release_lemming_speed:
	and	#$f
	bne	done_release_lemmings

	ldy	NEXT_LEMMING_TO_RELEASE

	lda	#1
	sta	lemming_out,Y
	lda	#0
	sta	lemming_exploding,Y
	sta	lemming_fall_distance,Y
	lda	INIT_X
	sta	lemming_x,Y
	lda	INIT_Y
	sta	lemming_y,Y
	lda	#LEMMING_RIGHT
	sta	lemming_direction,Y
	lda	#LEMMING_FALLING
	sta	lemming_status,Y

	sed
	lda	LEMMINGS_OUT		; BCD
	clc
	adc	#1
	sta	LEMMINGS_OUT
	cld

	jsr	update_lemmings_out

	inc	NEXT_LEMMING_TO_RELEASE

	dec	LEMMINGS_TO_RELEASE

done_release_lemmings:

	rts




