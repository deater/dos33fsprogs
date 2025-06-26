; check borders when leaving


	; check if going inside cottage
        ;       lady_cottage->inside_lady
check_inside:
	; need to position to correct x/y/facing co-ords

	lda	MAP_LOCATION
	cmp	#LOCATION_INSIDE_LADY
	bne	check_north

	lda	#25
	sta	PEASANT_X
	lda	#140
	sta	PEASANT_Y

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR


check_north:
