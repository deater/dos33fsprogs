	;======================================
	;======================================
	; special case leaving-level borders
	;======================================
	;======================================

check_borders:

check_south:
check_east:

	;=====================
	; check going west
	;	cottage -> jhonka
	; this border is a pain
	;	if >84 and <128 then make 128
check_west:
	lda	MAP_LOCATION
	cmp	#LOCATION_JHONKA_CAVE
	bne	check_north

	lda	PEASANT_Y
	cmp	#128
	bcs	check_done	; we are fine if >128

	cmp	#84
	bcc	check_done	; if <84 also fine

	lda	#128
	sta	PEASANT_Y

check_north:

check_done:


