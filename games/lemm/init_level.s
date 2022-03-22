	;====================
	; reset level vars
	;====================
init_level:
	lda	#0
	sta	LEVEL_OVER
	sta	DOOR_OPEN
	sta	FRAMEL
	sta	LOAD_NEXT_CHUNK
	sta	LEMMINGS_OUT
	sta	NEXT_LEMMING_TO_RELEASE
	sta	PERCENT_RESCUED_L
	sta	PERCENT_RESCUED_H

	jsr	clear_lemmings_out

	jsr	update_lemmings_out     ; update  display

	jsr	update_time

	rts
