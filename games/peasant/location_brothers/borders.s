; check borders when leaving

	;======================================
	;======================================
	; special case leaving-level borders
	;======================================
	;======================================

check_borders:

	;=====================
	; check going south
	;	brothers -> lake_w
	; FIXME: in real game no issue. In ours can end up in lake on right side?

check_south:

	lda	MAP_LOCATION
	cmp	#LOCATION_LAKE_WEST
	bne	check_east

	lda	PEASANT_X
	cmp	#25
	bcc	check_south_ok

	lda	#25			; don't let us walk on water
	sta	PEASANT_X

check_south_ok:

	;=====================
	; check going east
	;	brothers -> river
	; walking east it toward bottom will put you up mid-screen
check_east:
	lda	MAP_LOCATION
	cmp	#LOCATION_RIVER_STONE
	bne	check_west

	lda	PEASANT_Y
	cmp	#80
	bcc	check_west		; blt

	lda	#80
	sta	PEASANT_Y

check_west:

	;=====================
	; check going north
	;	brothers -> well
	; only exit should be through gap.  Handled by collision though?
check_north:

check_done:


