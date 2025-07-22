; check borders when leaving


; check borders when leaving


	; check if going outside cottage
        ;       inside_lady->outside_cottage
check_outside:

	; need to position to correct x/y/facing co-ords

	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_INN
	bne	check_north

	lda	#9
	sta	PEASANT_X
	lda	#112
	sta	PEASANT_Y

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR


check_north:
