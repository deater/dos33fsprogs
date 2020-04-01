
;===============================================
; level data for the Octagon Temple on Mist
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12

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
	.byte	16,25		; special x
	.byte	16,32		; special y
	.word	red_book-1	; special function

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
	.byte	$ff		; special exit

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
	.byte	DIRECTION_W	; west exit_dir
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
	.byte	$ff


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
	.byte	$ff

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
	.byte	$ff

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
	.byte	$ff

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
	.byte	$ff
