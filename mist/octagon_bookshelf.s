
open_bookshelf:

	; change background of center room N

	ldy	#LOCATION_NORTH_BG
	lda	#<temple_center_open_n_lzsa
	sta	location1,Y
	lda	#>temple_center_open_n_lzsa
	sta	location1+1,Y

	; change background of bookshelf N

	lda	#<bookshelf_open_n_lzsa
	sta	location8,Y
	lda	#>bookshelf_open_n_lzsa
	sta	location8+1,Y

	; change background of door N

	lda	#<temple_door_closed_n_lzsa
	sta	location0,Y
	lda	#>temple_door_closed_n_lzsa
	sta	location0+1,Y

	; change background of center room S

	ldy	#LOCATION_SOUTH_BG
	lda	#<temple_center_closed_s_lzsa
	sta	location1,Y
	lda	#>temple_center_closed_s_lzsa
	sta	location1+1,Y

	; change background of door S

	lda	#<temple_door_closed_s_lzsa
	sta	location0,Y
	lda	#>temple_door_closed_s_lzsa
	sta	location0+1,Y

	; disable exit to S
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location0,Y

	; enable exit to N

	ldy	#LOCATION_NORTH_EXIT
	lda	#OCTAGON_TOWER_HALL1
	sta	location8,Y

	; start animation

	rts



close_bookshelf:

	; change background of center room N

	ldy	#LOCATION_NORTH_BG
	lda	#<temple_center_n_lzsa
	sta	location1,Y
	lda	#>temple_center_n_lzsa
	sta	location1+1,Y

	; change background of bookshelf N

	lda	#<bookshelf_n_lzsa
	sta	location8,Y
	lda	#>bookshelf_n_lzsa
	sta	location8+1,Y

	; change background of door N

	lda	#<temple_door_n_lzsa
	sta	location0,Y
	lda	#>temple_door_n_lzsa
	sta	location0+1,Y

	; change background of center room S

	ldy	#LOCATION_SOUTH_BG
	lda	#<temple_center_s_lzsa
	sta	location1,Y
	lda	#>temple_center_s_lzsa
	sta	location1+1,Y

	; change background of door S

	lda	#<temple_door_s_lzsa
	sta	location0,Y
	lda	#>temple_door_s_lzsa
	sta	location0+1,Y

	; re-enable exit to S
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location0,Y

	; disable exit to N

	ldy	#LOCATION_NORTH_EXIT
	lda	#OCTAGON_BOOKSHELF_CLOSE
	sta	location8,Y

	; start animation

	rts

