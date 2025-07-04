	;======================================
	; special case leaving-level borders

check_borders:

	;=====================
	; check going south
	;	outside_ned -> gary

check_south:
	lda	MAP_LOCATION
	cmp	#LOCATION_POOR_GARY
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
check_east:
check_west:
check_north:

check_done:


