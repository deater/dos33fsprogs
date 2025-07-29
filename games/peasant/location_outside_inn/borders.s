	;======================================
	; special case leaving-level borders


check_borders:

	;=====================
	; check going south
	;	outsideinn->burninated

	; if too far to right can get stuck in cliff

check_south:

	lda	MAP_LOCATION
	cmp	#LOCATION_BURN_TREES
	bne	not_burninated

	; be sure we're in range
	lda	PEASANT_X
	cmp	#33
	bcc	check_done			; blt

	lda	#33
	sta	PEASANT_X

not_burninated:

check_east:
check_west:
check_north:

check_done:


