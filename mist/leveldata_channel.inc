;===============================================
; level data for Channely Wood
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


; CHANNEL_OUTSIDE_CABIN		-- outside in clearing
location0:
	.byte	$ff			; north exit
	.byte	CHANNEL_CLOCK_PATH	; south exit
	.byte	CHANNEL_CABIN_OPEN	; east exit
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

; CHANNEL_CABIN_OPEN		-- outside, door open
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_CABIN_ENTRANCE	; east exit
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

; CHANNEL_CABIN_ENTRANCE	-- entering the cabin
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_INSIDE_CABIN	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	boiler_room_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff


; CHANNEL_INSIDE_CABIN		-- inside the cabin
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_OUTSIDE_CABIN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	boiler_e_lzsa		; east bg
	.word	boiler_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; CHANNEL_SAFE		-- looking at safe
location4:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_INSIDE_CABIN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$000			; east bg
	.word	safe_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff

; CHANNEL_CLOCK_PATH		-- path to clock
location5:
	.byte	CHANNEL_OUTSIDE_CABIN	; north exit
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


; CHANNEL_TREE_PATH		-- path to tree
location6:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_BIG_TREE	; east exit
	.byte	CHANNEL_OUTSIDE_CABIN	; west exit
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

; CHANNEL_BIG_TREE		-- at the big tree
location7:
	.byte	CHANNEL_TREE_ELEVATOR	; north exit
	.byte	CHANNEL_TREE_PATH	; south exit
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

; CHANNEL_TREE_ELEVATOR		-- in the tree elevator
location8:
	.byte	$ff			; north exit
	.byte	CHANNEL_TREE_BASEMENT	; south exit
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

; CHANNEL_TREE_BASEMENT		-- in the tree basement
location9:
	.byte	CHANNEL_BIG_TREE	; north exit
	.byte	CHANNEL_TREE_BOOK	; south exit
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

; CHANNEL_TREE_BOOK		-- tree basement book
location10:
	.byte	$ff			; north exit
	.byte	CHANNEL_TREE_BOOK_CLOSED; south exit
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

; CHANNEL_TREE_BOOK_CLOSED		-- tree basement book closed
location11:
	.byte	$ff			; north exit
	.byte	CHANNEL_TREE_BOOK_OPEN	; south exit
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

; CHANNEL_TREE_BOOK_OPEN		-- tree basement book open
location12:
	.byte	$ff			; north exit
	.byte	CHANNEL_TREE_BASEMENT	; south exit
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


; CHANNEL_ARRIVAL		-- arrival in channelwood
location13:
	.byte	CHANNEL_PATH2		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival_n_lzsa		; north bg
	.word	arrival_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff

; CHANNEL_PATH2		-- twisty maze of passages all alike
location14:
	.byte	CHANNEL_PATH6		; north exit
	.byte	CHANNEL_ARRIVAL		; south exit
	.byte	CHANNEL_PATH3		; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	path2_n_lzsa		; north bg
	.word	path2_s_lzsa		; south bg
	.word	path2_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH|BG_EAST
	.byte	$ff

; CHANNEL_PATH3		-- twisty maze of passages all alike
location15:
	.byte	CHANNEL_PATH4		; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_BRIDGE		; east exit
	.byte	CHANNEL_PATH2		; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	path3_n_lzsa		; north bg
	.word	$0000			; south bg
	.word	path3_e_lzsa		; east bg
	.word	path3_w_lzsa		; west bg
	.byte	BG_NORTH|BG_WEST|BG_EAST
	.byte	$ff

; CHANNEL_BRIDGE	-- raisable bridge
location16:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_PATH3		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	bridge_down_e_lzsa	; east bg
	.word	bridge_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; CHANNEL_PATH4		-- twisty maze of passages all alike
location17:
	.byte	$ff			; north exit
	.byte	CHANNEL_PATH3		; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_PATH5		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	path4_s_lzsa		; south bg
	.word	path4_e_lzsa		; east bg
	.word	path4_w_lzsa		; west bg
	.byte	BG_SOUTH|BG_WEST|BG_EAST
	.byte	$ff

; CHANNEL_PATH5		-- twisty maze of passages all alike
location18:
	.byte	CHANNEL_STEPS_FORK	; north exit
	.byte	CHANNEL_PATH6		; south exit
	.byte	CHANNEL_PATH4		; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	path5_n_lzsa		; north bg
	.word	path5_s_lzsa		; south bg
	.word	path5_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff

; CHANNEL_PATH6		-- twisty maze of passages all alike
location19:
	.byte	CHANNEL_PATH5		; north exit
	.byte	CHANNEL_PATH2		; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_FORK		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	path6_n_lzsa		; north bg
	.word	path6_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	path6_w_lzsa		; west bg
	.byte	BG_NORTH|BG_WEST|BG_SOUTH
	.byte	$ff

; CHANNEL_FORK		-- forked path
location20:
	.byte	CHANNEL_PATH6		; north exit
	.byte	CHANNEL_PIPE_BRIDGE2	; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_BEFORE_ELEV1	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	fork_n_lzsa		; north bg
	.word	fork_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	fork_w_lzsa		; west bg
	.byte	BG_NORTH|BG_WEST|BG_SOUTH
	.byte	$ff

; CHANNEL_BEFORE_ELEV1		-- just befor elevator 1
location21:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_FORK		; east exit
	.byte	CHANNEL_IN_ELEVATOR1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_E	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	before_elev1_e_lzsa	; east bg
	.word	before_elev1_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; CHANNEL_IN_ELEVATOR1		-- inside elevator1
location22:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_BEFORE_ELEV1	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	elevator1_open_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff

; CHANNEL_PIPE_BRIDGE2		-- east side of pipe bridge
location23:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_FORK		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	pipe_bridge2_e_lzsa	; east bg
	.word	pipe_bridge2_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; CHANNEL_STEPS_FORK		-- fork going to steps
location24:
	.byte	CHANNEL_WIND_PATH	; north exit
	.byte	CHANNEL_PATH5		; south exit
	.byte	$ff			; east exit
	.byte	CHANNEL_STEPS_PATH	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	steps_fork_n_lzsa	; north bg
	.word	steps_fork_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	steps_fork_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST
	.byte	$ff

; CHANNEL_STEPS_PATH		-- path going to steps
location25:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_STEPS_FORK	; east exit
	.byte	CHANNEL_STEPS_DOOR	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	steps_path_e_lzsa	; east bg
	.word	steps_path_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; CHANNEL_STEPS_DOOR		-- door to the steps
location26:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	CHANNEL_STEPS_PATH	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	steps_door_e_lzsa	; east bg
	.word	steps_door_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; CHANNEL_WIND_PATH		-- path to windmill
location27:
	.byte	CHANNEL_WIND_PATH2	; north exit
	.byte	CHANNEL_STEPS_FORK	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	wind_path_n_lzsa	; north bg
	.word	wind_path_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; CHANNEL_WIND_PATH2		-- path to windmill too
location28:
	.byte	CHANNEL_ISLAND1		; north exit
	.byte	CHANNEL_WIND_PATH	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	wind_path2_n_lzsa	; north bg
	.word	wind_path2_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; CHANNEL_ISLAND1		-- island part1
location29:
	.byte	CHANNEL_ISLAND2		; north exit
	.byte	CHANNEL_WIND_PATH2	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	island1_n_lzsa		; north bg
	.word	island1_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; CHANNEL_ISLAND2		-- island part2
location30:
	.byte	CHANNEL_ISLAND3		; north exit
	.byte	CHANNEL_ISLAND1		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	island2_n_lzsa		; north bg
	.word	island2_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; CHANNEL_ISLAND3		-- island part3
location31:
	.byte	$ff			; north exit
	.byte	CHANNEL_ISLAND2		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	island3_n_lzsa		; north bg
	.word	island3_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff



