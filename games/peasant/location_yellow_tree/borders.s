	;======================================
	; special case leaving-level borders


check_borders:

check_south:

	;=====================
	; check going east
	;	yellow_tree->waterfall

check_east:
	lda	PEASANT_Y	; OK if at bottom of river
	cmp	#$90
	bcs	east_fine


	; possible to get caught on edge of river

	lda	PEASANT_Y
	cmp	#$54
	bcc	east_fine

	lda	#$54
	sta	PEASANT_Y

east_fine:

check_west:
check_north:

check_done:


