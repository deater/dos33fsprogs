	;======================================
	;======================================
	; special case leaving-level borders
	;======================================
	;======================================

check_borders:

check_south:

	;=====================
	; check going east
	;	puddle -> brothers
	; can end up in trees if near top of screen
check_east:
	lda	MAP_LOCATION
	cmp	#LOCATION_ARCHERY
	bne	check_west

	lda	PEASANT_Y
	cmp	#62
	bcs	check_west		; bge

	lda	#62
	sta	PEASANT_Y

check_west:

check_north:

check_done:


