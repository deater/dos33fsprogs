
	;======================================
	; special case leaving-level borders


check_borders:

	;=====================
	; check going south
	;	jhonka -> outside_ned

check_south:
	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_NN
	bne	check_east

	; be sure we're in range
	lda	PEASANT_X
	cmp	#7
	bcs	check_done			; bge, left of fence

move_to_right_of_fence:
	lda	#7
	sta	PEASANT_X
	jmp	check_done

					; fine if at far left

	;=====================
	; check going east
	;	jhonka -> cottage

	; less than 49 fine
	; 49..70 make 49

check_east:

	lda	MAP_LOCATION
	cmp	#LOCATION_YOUR_COTTAGE
	bne	check_west

	; be sure we're in range
	lda	PEASANT_Y
	cmp	#49
	bcc	check_done			; blt

	cmp	#70
	bcs	check_done			; bge

	lda	#49
	sta	PEASANT_Y
	bne	check_done			; bra

check_west:
check_north:

check_done:


