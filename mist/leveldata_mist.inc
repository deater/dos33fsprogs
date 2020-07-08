
;===============================================
; level data for Mist Island level
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
	.word location36,location37,location38

; MIST_ARRIVAL_DOCK	-- dock
location0:
	.byte	MIST_DOCK_SWITCH	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_VIEWER_DOOR	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	dock_n_lzsa	; north bg
	.word	dock_s_lzsa	; south bg
	.word	dock_e_lzsa	; east bg
	.word	dock_w_lzsa	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	enter_stoneyship-1	; special function


; MIST_DOCK_SWITCH	-- by dock switch
location1:
	.byte	MIST_DOCK_STEPS		; north exit
	.byte	MIST_ARRIVAL_DOCK	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dock_switch_n_lzsa	; north bg
	.word	dock_switch_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_N	; special exit
	.byte	23,30		; special x
	.byte	25,32		; special y
	.word	click_switch-1	; special function

; MIST_DOCK_STEPS	-- dock steps
location2:
	.byte	MIST_GEAR		; north exit
	.byte	$ff			; south exit
	.byte	MIST_DOCK_SWITCH	; east exit
	.byte	MIST_ABOVE_DOCK		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	gear_base_n_lzsa		; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	dock_steps_w_lzsa		; west bg
	.byte	BG_WEST|BG_NORTH
	.byte	$ff		; special exit

; MIST_ABOVE_DOCK	-- above dock path
location3:
	.byte	MIST_GEAR_BASE		; north exit
	.byte	MIST_BASE_STEPS		; south exit
	.byte	MIST_DOCK_SWITCH	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	above_dock_n_lzsa	; north bg
	.word	above_dock_s_lzsa	; south bg
	.word	above_dock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH|BG_NORTH|BG_EAST
	.byte	$ff		; special exit

; MIST_BASE_STEPS			-- base of steps
location4:
	.byte	MIST_ABOVE_DOCK		; north exit
	.byte	MIST_STEPS_1ST_LANDING	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	step_base_n_lzsa	; north bg
	.word	step_base_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; MIST_STEPS_1ST_LANDING	-- steps 1st landing
location5:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_BASE_STEPS		; east exit
	.byte	MIST_STEPS_2ND_LANDING	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	step_land1_e_lzsa	; east bg
	.word	step_land1_w_lzsa	; west bg
	.byte	BG_WEST	| BG_EAST
	.byte	$ff		; special exit

; MIST_STEPS_2ND_LANDING	-- steps 2nd landing
location6:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_STEPS_1ST_LANDING	; east exit
	.byte	MIST_STEPS_DENTIST	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	step_land2_e_lzsa	; east bg
	.word	step_land2_w_lzsa	; west bg
	.byte	BG_WEST	| BG_EAST
	.byte	DIRECTION_W	; special exit (letter)
	.byte	27,32		; special x
	.byte	36,45		; special y
	.word	read_letter-1

; MIST_STEPS_DENTIST		-- steps outside dentist chair branch
location7:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	MIST_STEPS_2ND_LANDING		; east exit
	.byte	MIST_STEPS_4TH_LANDING		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	step_dentist_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	step_dentist_e_lzsa	; east bg
	.word	step_dentist_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	10,30		; special x
	.byte	0,46		; special y
	.word	goto_dentist-1


; MIST_STEPS_4TH_LANDING	-- steps one more time up
location8:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_STEPS_DENTIST	; east exit
	.byte	MIST_OUTSIDE_TEMPLE	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	step_land3_e_lzsa	; east bg
	.word	step_land3_w_lzsa	; west bg
	.byte	BG_WEST	| BG_EAST	; west and eastl
	.byte	DIRECTION_E	; special exit
	.byte	0,16		; special x
	.byte	0,32		; special y
	.word	goto_dentist_steps-1

; MIST_OUTSIDE_TEMPLE		-- at the top outside temple
location9:
	.byte	$ff			; north exit
	.byte	MIST_POOL		; south exit
	.byte	MIST_STEPS_4TH_LANDING	; east exit
	.byte	MIST_ROCKET_PATH_PAD	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; west exit_dir
	.word	step_top_n_lzsa	; north bg
	.word	step_top_s_lzsa	; south bg
	.word	step_top_e_lzsa	; east bg
	.word	step_top_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH	; all dirs
	.byte	DIRECTION_N		; special exit
	.byte	10,30		; special x
	.byte	0,46		; special y
	.word	enter_octagon-1

; MIST_POOL			-- pool
location10:
	.byte	MIST_OUTSIDE_TEMPLE	; north exit
	.byte	MIST_TREE_CORRIDOR_1	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	pool_n_lzsa	; north bg
	.word	pool_s_lzsa	; south bg
	.word	pool_e_lzsa	; east bg
	.word	pool_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_E|DIRECTION_W		; special exit
	.byte	2,38		; special x
	.byte	10,32		; special y
	.word	pool_pillars-1

; MIST_CLOCK			-- clock
location11:
	.byte	MIST_TREE_CORRIDOR_5	; north exit
	.byte	MIST_CLOCK_PUZZLE	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	clock_n_lzsa	; north bg
	.word	clock_s_lzsa	; south bg
	.word	clock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH|BG_EAST|BG_NORTH
	.byte	DIRECTION_E	; special exit
	.byte	5,30		; special x
	.byte	2,46		; special y
	.word	enter_channel_clock-1	; special function

; MIST_SPACESHIP_FAR		-- spaceship far
location12:
	.byte	MIST_SPACESHIP_SWITCH	; north exit
	.byte	$ff			; south exit
	.byte	MIST_ROCKET_PATH_PAD	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	spaceship_far_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	spaceship_far_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_EAST
	.byte	$ff		; special exit

; MIST_TREE_CORRIDOR_2		-- tree corridor #2
location13:
	.byte	MIST_TREE_CORRIDOR_1	; north exit
	.byte	MIST_TREE_CORRIDOR_4	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree2_n_lzsa	; north bg
	.word	tree2_s_lzsa	; south bg
	.word	tree2_e_lzsa	; east bg
	.word	tree2_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_E|DIRECTION_W
	.byte	6,33		; special x
	.byte	10,38		; special y
	.word	tree2_pillars-1


; MIST_TREE_CORRIDOR_5		-- tree corridor #5
location14:
	.byte	MIST_TREE_CORRIDOR_4	; north exit
	.byte	MIST_CLOCK		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree5_n_lzsa	; north bg
	.word	tree5_s_lzsa	; south bg
	.word	tree5_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH | BG_EAST | BG_SOUTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	enter_channel_main-1	; special function

; MIST_GEAR			-- gear
location15:
	.byte	$ff			; north exit
	.byte	MIST_ABOVE_DOCK		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	gear_n_lzsa	; north bg
	.word	gear_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	gear_w_lzsa	; west bg
	.byte	BG_NORTH | BG_SOUTH | BG_WEST
	.byte	DIRECTION_N	; special exit
	.byte	5,10		; special x
	.byte	29,35		; special y
	.word	click_switch-1	; special function

; MIST_GEAR_BASE		-- gear base
location16:
	.byte	MIST_GEAR		; north exit
	.byte	$ff			; south exit
	.byte	MIST_DOCK_SWITCH	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	gear_base_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	above_dock_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_EAST
	.byte	$ff		; special exit

; MIST_CAT_LETTER	-- catherine letter
location17:
	.byte	MIST_STEPS_2ND_LANDING	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	cat_letter_lzsa		; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff		; special exit

; MIST_SPACESHIP_SWITCH		-- spaceship switch
location18:
	.byte	MIST_ROCKET_CLOSE	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	spaceship_switch_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	$ff		; special exit

; MIST_TREE_CORRIDOR_4		-- tree corridor4 (with generator switch)
location19:
	.byte	MIST_TREE_CORRIDOR_2	; north exit
	.byte	MIST_TREE_CORRIDOR_5	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	tree4_n_lzsa	; north bg
	.word	tree4_s_lzsa	; south bg
	.word	tree4_e_lzsa	; east bg
	.word	tree4_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST|BG_EAST
	.byte	DIRECTION_W	; special exit
	.byte	6,34		; special x
	.byte	0,46		; special y
	.word	go_to_generator-1	; special function

; MIST_TREE_CORRIDOR_1
location20:
	.byte	MIST_POOL		; north exit
	.byte	MIST_TREE_CORRIDOR_2	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree1_n_lzsa		; north bg
	.word	tree1_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MIST_CLOCK_PUZZLE		-- clock puzzle
location21:
	.byte	MIST_TREE_CORRIDOR_5	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	clock_n_lzsa		; north bg
	.word	clock_puzzle_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	DIRECTION_S	; special exit
	.byte	12,30		; special x
	.byte	38,48		; special y
	.word	clock_puzzle-1	; special function

; MIST_CLOCK_ISLAND		-- clock island
location22:
	.byte	MIST_CLOCK		; north exit
	.byte	MIST_CLOCK_INSIDE	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	clock_island_n_lzsa	; north bg
	.word	clock_island_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; MYST_CLOCK_INSIDE		-- clock inside
location23:
	.byte	$ff			; north exit
	.byte	MIST_CLOCK_ISLAND	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	clock_inside_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	12,30		; special x
	.byte	8,32		; special y
	.word	clock_inside_puzzle-1	; special function

; MIST_OPEN_GEAR		-- open_gear (?)
location24:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	MIST_GEAR	; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	gear_open_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	17,23		; special x
	.byte	14,24		; special y
	.word	go_to_meche-1	; special function

; MIST_ROCKET_PATH_PAD		-- pad on way to rocket
location25:
	.byte	MIST_SPACESHIP_FAR	; north exit
	.byte	$ff			; south exit
	.byte	MIST_OUTSIDE_TEMPLE	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	pad_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	pad_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH | BG_EAST
	.byte	DIRECTION_N
	.byte	0,20		; special x
	.byte	0,48		; special y
	.word	pad_special-1	; special function

; MIST_ROCKET_CLOSE		-- rocket close in
location26:
	.byte	MIST_SPACESHIP_FAR	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	spaceship_door_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	15,25		; special x
	.byte	8,46		; special y
	.word	open_ss_door-1	; special function

; MIST_TOWER2_PATH		-- tower2 path
location27:
	.byte	MIST_TOWER2_BASE	; north exit
	.byte	$ff			; south exit
	.byte	MIST_ROCKET_PATH_PAD	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower2_path_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	tower2_path_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_EAST
	.byte	$ff

; MIST_TOWER2_BASE		-- tower2 base
location28:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_TOWER2_PATH	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	tower2_base_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	13,27		; special x
	.byte	0,46		; special y
	.word	leave_tower2-1	; special function

; MIST_TOWER2_TOP		-- tower2 top
location29:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_TOWER2_BASE	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W|DIRECTION_ONLY_POINT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	tower2_top_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	17,22		; special x
	.byte	10,18		; special y
	.word	circuit_breaker-1	; special function

; MIST_VIEWER_DOOR	-- viewer door
location30:
	.byte	MIST_DOCK_SWITCH	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dock_n_lzsa	; north bg
	.word	dock_s_lzsa	; south bg
	.word	dock_e_lzsa	; east bg
	.word	dock_w_open_lzsa	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	DIRECTION_W	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	enter_viewer-1	; special function

; MIST_PILLAR_EYE	-- pillar with eye
location31:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_POOL		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	pillar_eye_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_SNAKE	-- pillar with snake
location32:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_POOL		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	pillar_snake_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_BUG	-- pillar with bug
location33:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_TREE_CORRIDOR_2		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	pillar_bug_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_ANCHOR	-- pillar with anchor
location34:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_TREE_CORRIDOR_2		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	pillar_anchor_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_ARROW	-- pillar with arrow
location35:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TREE_CORRIDOR_2	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	pillar_arrow_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_LEAF	-- pillar with leaf
location36:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TREE_CORRIDOR_2	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	pillar_leaf_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_CROSS	-- pillar with cross
location37:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_POOL		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	pillar_cross_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function

; MIST_PILLAR_EMU	-- pillar with emu
location38:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_POOL		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	pillar_emu_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	14,27		; special x
	.byte	12,30		; special y
	.word	touch_pillar-1	; special function









