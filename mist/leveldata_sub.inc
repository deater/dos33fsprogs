
;===============================================
; level data for Bunker/Submarine level
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20

; SUB_BUNKER_ENTRY	-- entryway inside bunker
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_HALLWAY		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	bunker_entry_e_lzsa		; east bg
	.word	bunker_entry_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_W		; special exit
	.byte	15,24		; special x
	.byte	8,42		; special y
	.word	goto_selena-1	; special function

; SUB_HALLWAY	-- hallway to the sub room
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_HALLWAY2		; east exit
	.byte	SUB_BUNKER_ENTRY	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	sub_hallway_e_lzsa		; east bg
	.word	sub_hallway_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SUB_HALLWAY2	-- another hallway to the sub room
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_ROOM		; east exit
	.byte	SUB_HALLWAY		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	sub_hallway2_e_lzsa		; east bg
	.word	sub_hallway2_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SUB_ROOM		-- sub room
location3:
	.byte	SUB_HALLWAY2		; north exit
	.byte	SUB_MEDIUM		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	subroom_n_lzsa	; north bg
	.word	subroom_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; SUB_CLOSE	-- standing close to the sub
location4:
	.byte	SUB_MEDIUM		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	sub_close_n_lzsa		; north bg
	.word	sub_close_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_S
	.byte	24,30		; special x
	.byte	10,18		; special y
	.word	sub_selena_open-1		; special function

; SUB_CLOSE_OPEN	-- standing close to the sub, door open
location5:
	.byte	SUB_MEDIUM		; north exit
	.byte	SUB_INSIDE_BACK		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	sub_close_n_lzsa		; north bg
	.word	sub_close_open_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_S
	.byte	24,30		; special x
	.byte	10,18		; special y
	.word	sub_selena_close-1		; special function

; SUB_INSIDE_BACK	-- inside the submarine, in the back
location6:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_INSIDE_FRONT_SELENA	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	inside_sub_back_closed_s_lzsa	; south bg
	.word	inside_sub_back_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_EAST
	.byte	DIRECTION_S
	.byte	9,12		; special x
	.byte	18,26		; special y
	.word	sub_door_selena_open-1		; special function


; SUB_INSIDE_BACK_OPEN	-- inside the submarine, in the back, door open
location7:
	.byte	$ff			; north exit
	.byte	SUB_CLOSE_OPEN		; south exit
	.byte	SUB_INSIDE_FRONT_SELENA	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	inside_sub_back_selena_s_lzsa	; south bg
	.word	inside_sub_back_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_EAST
	.byte	DIRECTION_S
	.byte	9,12		; special x
	.byte	18,26		; special y
	.word	sub_door_close-1		; special function

; SUB_INSIDE_FRONT_SELENA	-- inside the submarine front, at selena side
location8:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SUB_INSIDE_BACK		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	inside_sub_selena_e_lzsa	; east bg
	.word	inside_sub_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_E
	.byte	7,27		; special x
	.byte	24,35		; special y
	.word	sub_controls_move_toward_book-1		; special function


; SUB_INSIDE_FRONT_MOVING	-- inside the submarine front, when "moving"
location9:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SUB_INSIDE_BACK	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	inside_sub_e_lzsa		; east bg
	.word	inside_sub_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_E
	.byte	7,27		; special x
	.byte	24,40		; special y
	.word	sub_controls_moving-1		; special function

; SUB_INSIDE_FRONT_BOOK	-- inside the submarine front, at book area
location10:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SUB_INSIDE_BACK		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	inside_sub_book_e_lzsa		; east bg
	.word	inside_sub_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_E
	.byte	7,27		; special x
	.byte	28,40		; special y
	.word	sub_controls_move_toward_selena-1		; special function

; SUB_OUTSIDE_BOOK	-- outside sub in book area
location11:
	.byte	SUB_INSIDE_BACK		; north exit
	.byte	SUB_BOOK_HALLWAY	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	outside_book_n_lzsa		; north bg
	.word	outside_book_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SUB_BOOK_HALLWAY	-- hallway to the book room
location12:
	.byte	SUB_OUTSIDE_BOOK	; north exit
	.byte	SUB_BOOK_HALLWAY2	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_hallway_n_lzsa		; north bg
	.word	book_hallway_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SUB_BOOK_HALLWAY2	-- hallway to the book room
location13:
	.byte	SUB_BOOK_HALLWAY	; north exit
	.byte	SUB_BOOK_ROOM		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_hallway2_n_lzsa		; north bg
	.word	book_hallway2_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_BOOK_ROOM		-- book room
location14:
	.byte	SUB_BOOK_HALLWAY2	; north exit
	.byte	SUB_BOOK_CLOSED		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_table_n_lzsa	; north bg
	.word	book_table_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; SUB_BOOK_CLOSED		-- book
location15:
	.byte	$ff			; north exit
	.byte	SUB_BOOK_OPEN		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_mist_closed_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; SUB_BOOK_OPEN		-- mist book open
location16:
	.byte	$ff			; north exit
	.byte	SUB_BOOK_ROOM		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_mist_open_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S
	.byte	24,32		; special x
	.byte	12,22		; special y
	.word	mist_link_book-1		; special function

; SUB_MEDIUM		-- mediumly close to sub
location17:
	.byte	SUB_ROOM		; north exit
	.byte	SUB_CLOSE		; south exit
	.byte	SUB_WALK_LEFT		; east exit
	.byte	SUB_WALK_RIGHT		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	sub_med_n_lzsa	; north bg
	.word	sub_med_s_lzsa	; south bg
	.word	sub_med_e_lzsa	; east bg
	.word	sub_med_w_lzsa	; west bg
	.byte	BG_SOUTH|BG_NORTH|BG_EAST|BG_WEST
	.byte	$ff

; SUB_WALK_LEFT		-- left path around sub
location18:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_WALK_RIGHT		; east exit
	.byte	SUB_MEDIUM		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	subroom_s_lzsa	; south bg
	.word	subroom_s_lzsa	; east bg
	.word	subroom_s_lzsa	; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; SUB_WALK_RIGHT		-- right_path_around_sub
location19:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_MEDIUM		; east exit
	.byte	SUB_WALK_LEFT		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_E	; west exit_dir
	.word	$0000		; north bg
	.word	subroom_s_lzsa	; south bg
	.word	subroom_n_lzsa	; east bg
	.word	subroom_n_lzsa	; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; SUB_BOTTOM_STAIRS	-- bottom of the bunker stairs
location20:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SUB_HALLWAY2		; east exit
	.byte	SUB_BUNKER_ENTRY	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	sub_hallway_e_lzsa		; east bg
	.word	sub_hallway_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff
