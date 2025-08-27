	;======================================
	; special case leaving-level borders


check_borders:

	;=====================
	; check going south
	;	haystack -> jhonka

check_south:
	lda	MAP_LOCATION
	cmp	#LOCATION_JHONKA_CAVE
	bne	check_east

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcs	check_done			; bge, left of fence

move_to_right_of_fence:
	lda	#6
	sta	PEASANT_X
	jmp	check_done

					; fine if at far left


	;=====================
	; check going east
	;	haystack -> puddle

check_east:
	lda	MAP_LOCATION
	cmp	#LOCATION_MUD_PUDDLE
	bne	check_west

	; move further if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	border_not_in_hay

	lda	#3
	sta	PEASANT_X

border_not_in_hay:



	;=====================
	; check going west

check_west:
check_north:

check_done:


