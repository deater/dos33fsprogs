; check borders when leaving


check_exit_west:
	;==========================
	; outer -> cliff_heights

	lda	MAP_LOCATION
	cmp	#LOCATION_CLIFF_HEIGHTS
	bne	check_exit_east

	lda	#32
	sta	PEASANT_X
	lda	#120
	sta	PEASANT_Y
	bne	done_borders			; bra


check_exit_east:
	;===========================
	; outer -> trogdor

	cmp	#LOCATION_TROGDOR_LAIR
	bne	done_borders

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

done_borders:



