; check borders when leaving


; note, if at far left then we get stuck walking south to lake_east

	;=====================
	; check going south
	;	river->lake_east

check_south:

	lda	MAP_LOCATION
	cmp	#LOCATION_LAKE_EAST
	bne	check_east

	; be sure we're in range
	lda	PEASANT_X
	cmp	#16
	bcs	done_south

	lda	#16
	sta	PEASANT_X

done_south:



check_east:
check_west:
check_north:

check_done:


