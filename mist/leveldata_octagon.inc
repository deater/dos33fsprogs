
;===============================================
; level data for the Octagon Temple on Mist
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20,location21,location22,location23
	.word location24,location25,location26,location27
	.word location28,location29,location30,location31
	.word location32,location33,location34,location35
	.word location36,location37

; OCTAGON_TEMPLE_DOORWAY	-- temple doorway
location0:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
;	.byte	9		; south exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	temple_door_n_lzsa	; north bg
	.word	temple_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH	; north and south
	.byte	DIRECTION_S	; special exit
	.byte	10,30		; special x
	.byte	0,46		; special y
	.word	leave_octagon-1	; special function


; OCTAGON_TEMPLE_CENTER		-- temple inside
location1:
	.byte	$ff			; north exit
	.byte	OCTAGON_TEMPLE_DOORWAY	; south exit
	.byte	OCTAGON_FIREPLACE	; east exit
	.byte	OCTAGON_RED_BOOKSHELF	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S|DIRECTION_ONLY_POINT	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	temple_center_n_lzsa	; north bg
	.word	temple_center_s_lzsa	; south bg
	.word	temple_center_e_lzsa	; east bg
	.word	temple_center_w_lzsa	; west bg
	.byte	BG_NORTH|BG_WEST|BG_SOUTH|BG_EAST	; all directions
	.byte	DIRECTION_ANY		; special exit
	.byte	4,35		; special x
	.byte	0,46		; special y
	.word	handle_octagon-1	; special function

; OCTAGON_RED_BOOK_SHELF	-- red book shelf
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W|DIRECTION_ONLY_POINT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	red_book_shelf_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	DIRECTION_W	; special exit
	.byte	16,28		; special x
	.byte	16,32		; special y
	.word	touch_red_book-1	; special function

; OCTAGON_FIREPLACE		-- fireplace
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_IN_FIREPLACE	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	fireplace_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; OCTAGON_IN_FIREPLACE		-- in fireplace
location4:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W|DIRECTION_ONLY_POINT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	in_fireplace_w_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	DIRECTION_W		; special exit
	.byte	3,8		; special x
	.byte	22,32		; special y
	.word	close_fireplace-1	; special function


; OCTAGON_CEILING		-- ceiling of temple
location5:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	temple_center_up_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; OCTAGON_MAP		-- looking at map
location6:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TOWER_ROTATION	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W|DIRECTION_SPLIT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	map_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff

; OCTAGON_FRAME_SHELF		-- picture that moves the bookcase
location7:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	frame_bookcase_open_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	15,25		; special x
	.byte	12,28		; special y
	.word	open_bookshelf-1	; special function


; OCTAGON_BOOKSHELF		-- the bookcase
location8:
	.byte	OCTAGON_BOOKSHELF_CLOSE	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bookshelf_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; OCTAGON_FRAME_DOOR		-- picture that opens the door
location9:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	frame_door_open_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	15,25		; special x
	.byte	12,28		; special y
	.word	close_bookshelf-1	; special function


; OCTAGON_BLUE_BOOKSHELF		-- the blue bookshelf
location10:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_TEMPLE_CENTER	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	blue_book_shelf_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	16,28		; special x
	.byte	16,32		; special y
	.word	touch_blue_book-1	; special function

; OCTAGON_TOWER_ROTATION		-- looking at tower rotation
location11:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W|DIRECTION_ONLY_POINT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	tower_rotation_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W
	.byte	28,33		; special x
	.byte	14,22		; special y
	.word	rotate_tower-1	; special function

; OCTAGON_BOOKSHELF_CLOSE		-- the bookcase close in
location12:
	.byte	OCTAGON_TEMPLE_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bookshelf_close_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	6,34		; special x
	.byte	2,46		; special y
	.word	read_book-1	; special function

; OCTAGON_TOWER_HALL1		-- hallway to tower
location13:
	.byte	OCTAGON_TOWER_HALL2	; north exit
	.byte	OCTAGON_TEMPLE_CENTER	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_hall1_n_lzsa	; north bg
	.word	tower_hall1_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; OCTAGON_TOWER_HALL2		-- hallway to tower
location14:
	.byte	OCTAGON_ELEVATOR_VIEW	; north exit
	.byte	OCTAGON_TOWER_HALL1	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_hall2_n_lzsa	; north bg
	.word	tower_hall2_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; OCTAGON_ELEVATOR_VIEW		-- elevator in sight
location15:
	.byte	OCTAGON_ELEVATOR_OUT	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	elevator_far_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; OCTAGON_ELEVATOR_OUT		-- standing outside elevator
location16:
	.byte	OCTAGON_ELEVATOR_OPEN	; north exit
	.byte	OCTAGON_TOWER_HALL2	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	elevator_n_lzsa		; north bg
	.word	elevator_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; OCTAGON_ELEVATOR_OPEN		-- standing outside elevator, door open
location17:
	.byte	OCTAGON_ELEVATOR_IN	; north exit
	.byte	OCTAGON_ELEVATOR_OUT	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	elevator_open_n_lzsa	; north bg
	.word	elevator_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; OCTAGON_ELEVATOR_IN		-- standing in elevator
location18:
	.byte	$ff			; north exit
	.byte	OCTAGON_ELEVATOR_OUT	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	elevator_lib_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	29,35		; special x
	.byte	34,40		; special y
	.word	elevator_button-1	; special function

; OCTAGON_TOWER_BOOK		-- tower, bookside
location19:
	.byte	OCTAGON_ELEVATOR_IN	; north exit
	.byte	OCTAGON_BOOK_LADDER	; south exit
	.byte	OCTAGON_TOWER_RIGHT	; east exit
	.byte	OCTAGON_TOWER_LEFT	; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	tower_book_n_lzsa	; north bg
	.word	tower_book_s_lzsa	; south bg
	.word	tower_book_e_lzsa	; east bg
	.word	tower_book_w_lzsa	; west bg
	.byte	BG_SOUTH|BG_NORTH|BG_EAST|BG_WEST
	.byte	$ff

; OCTAGON_BOOK_LADDER		-- ladder, bookside
location20:
	.byte	OCTAGON_TOWER_BOOK	; north exit
	.byte	OCTAGON_BOOK_VIEW	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_book_ladder_n_lzsa	; north bg
	.word	tower_book_ladder_s_lzsa	; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; OCTAGON_BOOK_VIEW		-- ladder, view outside
location21:
	.byte	OCTAGON_BOOK_LADDER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_book_view_n_lzsa		; north bg
	.word	tower_book_view_blank_s_lzsa	; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; OCTAGON_TOWER_KEY		-- base of key ladder
location22:
	.byte	OCTAGON_KEY_LADDER	; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_TOWER_LEFT	; east exit
	.byte	OCTAGON_TOWER_RIGHT	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	tower_key_n_lzsa	; north bg
	.word	tower_key_s_lzsa	; south bg
	.word	tower_key_e_lzsa	; east bg
	.word	tower_key_w_lzsa	; west bg
	.byte	BG_SOUTH|BG_NORTH|BG_EAST|BG_WEST
	.byte	$ff

; OCTAGON_TOWER_LEFT		-- left out of elevator
location23:
	.byte	OCTAGON_TOWER_KEY	; north exit
	.byte	OCTAGON_TOWER_BOOK	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_left_n_lzsa	; north bg
	.word	tower_left_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; OCTAGON_TOWER_RIGHT		-- right out of elevator
location24:
	.byte	OCTAGON_TOWER_KEY	; north exit
	.byte	OCTAGON_TOWER_BOOK	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_right_n_lzsa	; north bg
	.word	tower_right_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; OCTAGON_KEY_LADDER		-- ladder, key side
location25:
	.byte	OCTAGON_KEY_VIEW	; north exit
	.byte	OCTAGON_TOWER_KEY	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_SPLIT	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_key_ladder_n_lzsa		; north bg
	.word	tower_key_ladder_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; OCTAGON_KEY_VIEW		-- key ladder, view hint
location26:
	.byte	$ff			; north exit
	.byte	OCTAGON_KEY_LADDER	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower_key_view_blank_n_lzsa	; north bg
	.word	tower_key_view_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; OCTAGON_RED_BOOK_CLOSED	-- red book, but closed
location27:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	red_book_closed_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	DIRECTION_W	; special exit
	.byte	14,29		; special x
	.byte	2,46		; special y
	.word	open_red_book-1	; special function

; OCTAGON_RED_BOOK_OPEN		-- red book, but closed
location28:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_TEMPLE_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W|DIRECTION_ONLY_POINT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	red_book_open_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	$ff

; OCTAGON_BLUE_BOOK_CLOSED	-- blue book, but closed
location29:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_TEMPLE_CENTER	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	blue_book_closed_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST		; east
	.byte	DIRECTION_E	; special exit
	.byte	14,29		; special x
	.byte	2,46		; special y
	.word	open_blue_book-1	; special function

; OCTAGON_BLUE_BOOK_OPEN		-- blue book, but open
location30:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_TEMPLE_CENTER	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT	; east exit_dir
	.byte	$ff			; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	blue_book_open_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST		; east
	.byte	$ff

; OCTAGON_RED_END		-- red ending
location31:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	red_book_ending_lzsa	; west bg
	.byte	BG_WEST
	.byte	$ff

; OCTAGON_BLUE_END		-- blue ending
location32:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	blue_book_ending_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff

; OCTAGON_GRID_BOOK		-- the bookcase close in
location33:
	.byte	OCTAGON_BOOKSHELF_CLOSE	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	fireplace_book_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	6,34		; special x
	.byte	5,35		; special y
	.word	turn_page-1	; special function

; OCTAGON_IN_FIREPLACE_CLOSED		-- in fireplace, closed
location34:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	OCTAGON_FIREPLACE_SHELF	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_E			; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	in_fireplace_door_lzsa		; west bg
	.byte	BG_WEST		; west
	.byte	DIRECTION_W		; special exit
	.byte	3,8		; special x
	.byte	22,32		; special y
	.word	open_fireplace-1	; special function

; OCTAGON_FIREPLACE_SHELF	-- in fireplace, rotated shelf
location35:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	fireplace_shelf_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	3,30		; special x
	.byte	6,44		; special y
	.word	fireplace_shelf_action-1	; special function

; OCTAGON_GREEN_BOOK	-- looking at green book
location36:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_FIREPLACE_SHELF	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	green_book_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	12,30	; special x
	.byte	2,46	; special y
	.word	open_green_book-1	; special function


; OCTAGON_GREEN_BOOK_OPEN	-- green book is open
location37:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	OCTAGON_FIREPLACE_SHELF	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	green_book_open_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	6,34	; special x
	.byte	2,46	; special y
	.word	touch_green_book-1	; special function

