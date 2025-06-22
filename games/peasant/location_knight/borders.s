
	;======================================
	; special case leaving-level borders


check_borders:

	;=====================
	; check going south
	;	knight->inn

check_south:
	; specical case if going outside inn
	; we don't want to end up behind inn

	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_INN
	bne	not_behind_inn

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcc	check_done			; blt ; fine if at far left

	cmp	#18
	bcc	move_to_left_of_inn		; blt: move to left

	cmp	#31
	bcs	check_done			; bge; fine if far right

	; otherwise, move to right

move_to_right_of_inn:
	lda	#31
	bne	border_update_x			; bra

move_to_left_of_inn:
	lda	#5

border_update_x:
	sta	PEASANT_X
	jmp	check_done

					; fine if at far left

not_behind_inn:


	;=====================
	; check going east
	;	knight->cliff_base
check_east:
	cmp	#LOCATION_CLIFF_BASE
	bne	not_going_to_cliff

	lda	#18			; set base of cliff, looking north
	sta	PEASANT_X
	lda	#140
	sta	PEASANT_Y
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR

not_going_to_cliff:
check_west:
check_north:

check_done:


