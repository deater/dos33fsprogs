
open_fireplace:

	lda	#OCTAGON_IN_FIREPLACE
	sta	LOCATION

	jmp	change_location

close_fireplace:

	lda	#OCTAGON_IN_FIREPLACE_CLOSED
	sta	LOCATION

	jmp	change_location

