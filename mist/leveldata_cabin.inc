;===============================================
; level data for Cabin
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13

; CABIN_OUTSIDE		-- outside in clearing
location0:
	.byte	$ff			; north exit
	.byte	CABIN_CLOCK_PATH	; south exit
	.byte	CABIN_OPEN		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	clearing_s_lzsa		; south bg
	.word	clearing_e_lzsa		; east bg
	.word	clearing_w_lzsa		; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_E|DIRECTION_W	; special exit
	.byte	7,33		; special x
	.byte	2,46		; special y
	.word	handle_clearing-1		; special function

; CABIN_OPEN		-- outside, door open
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CABIN_ENTRANCE		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	clearing_s_lzsa		; south bg
	.word	clearing_e_open_lzsa	; east bg
	.word	clearing_w_lzsa		; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_E|DIRECTION_W	; special exit
	.byte	7,33		; special x
	.byte	2,46		; special y
	.word	handle_clearing-1		; special function

; CABIN_ENTRANCE	-- entering the cabin
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CABIN_INSIDE		; east exit
	.byte	CABIN_OUTSIDE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	boiler_room_e_lzsa	; east bg
	.word	boiler_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_W	; special exit
	.byte	28,36	; special x
	.byte	16,32	; special y
	.word	goto_safe-1


; CABIN_INSIDE		-- inside the cabin
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	CABIN_OUTSIDE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	boiler_e_lzsa		; east bg
	.word	boiler_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_W	; special exit
	.byte	28,36	; special x
	.byte	16,32	; special y
	.word	goto_safe-1


; CABIN_SAFE		-- looking at safe
location4:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	CABIN_INSIDE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$000			; east bg
	.word	safe_w_lzsa		; west bg
	.byte	BG_WEST
	.byte   DIRECTION_W	; special exit
	.byte	3,31	; special x
	.byte	16,44	; special y
	.word	touch_safe-1

; CABIN_CLOCK_PATH		-- path to clock
location5:
	.byte	CABIN_OUTSIDE		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	clock_path_n_lzsa	; north bg
	.word	clock_path_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	enter_clock-1	; special function


; CABIN_TREE_PATH		-- path to tree
location6:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CABIN_BIG_TREE		; east exit
	.byte	CABIN_OUTSIDE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	tree_path_e_lzsa	; east bg
	.word	tree_path_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; CABIN_BIG_TREE		-- at the big tree
location7:
	.byte	CABIN_TREE_ELEVATOR	; north exit
	.byte	CABIN_TREE_PATH		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree_base_n_lzsa	; north bg
	.word	tree_base_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; CABIN_TREE_ELEVATOR		-- in the tree elevator
location8:
	.byte	$ff			; north exit
	.byte	CABIN_TREE_BASEMENT	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	tree_elevator_basement_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; CABIN_TREE_BASEMENT		-- in the tree basement
location9:
	.byte	CABIN_BIG_TREE		; north exit
	.byte	CABIN_TREE_BOOK		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree_basement_n_lzsa	; north bg
	.word	tree_basement_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; CABIN_TREE_BOOK		-- tree basement book
location10:
	.byte	$ff			; north exit
	.byte	CABIN_TREE_BOOK_CLOSED	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	tree_basement_book_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; CABIN_TREE_BOOK_CLOSED		-- tree basement book closed
location11:
	.byte	$ff			; north exit
	.byte	CABIN_TREE_BOOK_OPEN	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	tree_basement_book_closed_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; CABIN_TREE_BOOK_OPEN		-- tree basement book open
location12:
	.byte	$ff			; north exit
	.byte	CABIN_TREE_BASEMENT	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	tree_basement_book_open_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte   DIRECTION_S	; special exit
	.byte	21,31	; special x
	.byte	10,24	; special y
	.word	channel_link_book-1

; CABIN_OPEN_SAFE		-- looking at open safe
location13:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	CABIN_INSIDE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$000			; east bg
	.word	safe_open_w_lzsa	; west bg
	.byte	BG_WEST
	.byte   DIRECTION_W	; special exit
	.byte	14,34	; special x
	.byte	0,44	; special y
	.word	touch_open_safe-1
