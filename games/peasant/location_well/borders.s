

	; check if left baby in the well

check_baby_in_well:

	lda	GAME_STATE_0
	and	#BABY_IN_WELL
	beq	baby_not_in_well

	ldx	#<well_leave_baby_in_well_message
	ldy	#>well_leave_baby_in_well_message
	jsr	finish_parse_message

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK	; needed?
	sta	LEVEL_OVER
	jmp	level_over

baby_not_in_well:


	;======================================
	;======================================
	; special case leaving-level borders
	;======================================
	;======================================

check_borders:

	;=====================
	; check going south
	;	well->brothers
check_south:
	; in actual game, walking down center pops you out gap in trees
	; at archery
        ; walking to the left side of screen pops you out the trees on left
	; but you can't go back that way

	lda	MAP_LOCATION
	cmp	#LOCATION_ARCHERY
	bne	check_east

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcs	exit_mid_left

exit_through_trees:

	lda	#8
	bne	border_update_x			; bra

	;=======================
	; if 8..25 exit at 25
	; if 30-40 exit at 29
	; else exit as-is

exit_mid_left:
	cmp	#25
	bcs	exit_mid_right
	lda	#25
	bne	border_update_x			; bra

exit_mid_right:
	cmp	#30
	bcc	exit_straight_through

	lda	#29

exit_straight_through:

border_update_x:
	sta	PEASANT_X
	jmp	check_done

					; fine if at far left

not_going_to_archery:

check_east:
check_west:
check_north:

check_done:


