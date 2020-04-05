
	; elevator button pressed

elevator_button:

	; see which floor we are on

	ldy	#LOCATION_SOUTH_EXIT
	lda	location18,Y
	cmp	#OCTAGON_ELEVATOR_OUT
	bne	elevator_goto_library_level

elevator_goto_tower_level:
	; we want to go up the tower

	; change exit
	lda	#OCTAGON_TOWER_BOOK
	sta	location18,Y

	; change bg image

	ldy	#LOCATION_SOUTH_BG
	lda	#<elevator_tower_s_lzsa
	sta	location18,Y
	lda	#>elevator_tower_s_lzsa
	sta	location18+1,Y

	jmp	change_location

elevator_goto_library_level:
	; we want to move back to the library

	; change exit
	lda	#OCTAGON_ELEVATOR_OUT
	sta	location18,Y

	; change south bg image
	ldy	#LOCATION_SOUTH_BG
	lda	#<elevator_lib_s_lzsa
	sta	location18,Y
	lda	#>elevator_lib_s_lzsa
	sta	location18+1,Y

	jmp	change_location


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





; TOWER ROTATION HINTS
; DOCK
; OCTOBER 11, 1984 10:04 AM
; JANUARY 17, 1207 5:46 AM
; NOVEMBER 23, 9791 6:57 PM
