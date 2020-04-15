
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
	.word location36,location37,location38,location39
	.word location40

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
	.byte	29,32		; special x
	.byte	38,45		; special y
	.word	read_letter-1


; MIST_STEPS_DENTIST		-- steps outside dentist chair branch
location7:
	.byte	MIST_DENTIST_DOOR		; north exit
	.byte	$ff				; south exit
	.byte	MIST_STEPS_2ND_LANDING		; east exit
	.byte	8				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	step_dentist_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	step_dentist_e_lzsa	; east bg
	.word	step_dentist_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH
	.byte	$ff		; special exit

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
	.byte	$ff		; special exit

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
	.byte	$ff			; north exit
	.byte	MIST_TREE_CORRIDOR_4	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	pool_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; MIST_CLOCK			-- clock
location11:
	.byte	$ff			; north exit
	.byte	MIST_CLOCK_PUZZLE	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	clock_s_lzsa	; south bg
	.word	clock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH|BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
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
	.byte	MIST_OUTSIDE_TEMPLE	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree2_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	25,31		; special x
	.byte	19,23		; special y
	.word	click_switch-1	; special function

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

; MIST_DENTIST_DOOR		-- dentist door
location17:
	.byte	MIST_CHAIR_VIEW		; north exit
	.byte	MIST_STEPS_4TH_LANDING	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dentist_door_n_lzsa	; north bg
	.word	dentist_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
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
	.byte	MIST_TOWER1_TRAIL	; west exit
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
	.byte	6,28		; special x
	.byte	0,46		; special y
	.word	green_house-1	; special function

; UNUSED (was MIST_TREE_CABIN)
location20:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TREE_CORRIDOR_5	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; MIST_CLOCK_PUZZLE		-- clock puzzle
location21:
	.byte	MIST_TREE_CORRIDOR_4	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree5_n_lzsa		; north bg
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
	.byte	MIST_TREE_CORRIDOR_5	; north exit
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

; MIST_CHAIR_VIEW		-- chair view
location25:
	.byte	MIST_CHAIR_VIEW		; north exit
	.byte	MIST_DENTIST_DOOR	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chair_view_n_lzsa	; north bg
	.word	chair_view_s_lzsa	; south bg
	.word	gear_open_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	$ff		; TODO: lightswitch

; MIST_GREEN_SHACK
location26:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TREE_CORRIDOR_4	; east exit
	.byte	MIST_GREEN_STEPS1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	green_house_e_lzsa	; east bg
	.word	green_house_w_lzsa	; west bg
	.byte	BG_EAST | BG_WEST
	.byte	$ff

; MIST_GREEN_STEPS1		-- green shack steps 1
location27:
	.byte	MIST_GREEN_STEPS6	; north exit
	.byte	MIST_GREEN_SHACK	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff			; west exit_dir
	.word	green_steps1_n_lzsa	; north bg
	.word	green_steps1_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	$ff

; MIST_GREEN_STEPS6		-- green shack steps 6
location28:
	.byte	MIST_GENERATOR_DOOR	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MIST_GREEN_STEPS1	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	green_steps6_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	green_steps6_w_lzsa	; west bg
	.byte	BG_NORTH | BG_WEST
	.byte	$ff

; MIST_GENERATOR_DOOR		-- generator room door
location29:
	.byte	MIST_GENERATOR_DOOR	; north exit
	.byte	MIST_GREEN_STEPS6	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	gen_door_closed_n_lzsa	; north bg
	.word	gen_door_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	DIRECTION_N	; special exit
	.byte	27,32		; special x
	.byte	26,32		; special y
	.word	open_gen_door-1	; special function


; MIST_GENERATOR_ROOM		-- generator room
location30:
	.byte	$ff			; north exit
	.byte	MIST_GENERATOR_DOOR	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	generator_n_lzsa	; north bg
	.word	generator_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	DIRECTION_N
	.byte	24,36		; special x
	.byte	34,40		; special y
	.word	generator_button_press-1	; special function

; MIST_ROCKET_PATH_PAD		-- pad on way to rocket
location31:
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
location32:
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
location33:
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
location34:
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
location35:
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

; MIST_TOWER1_TRAIL		-- tower1 trail
location36:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TREE_CORRIDOR_4	; east exit
	.byte	MIST_TOWER1_TRAIL2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	tower1_trail_e_lzsa	; east bg
	.word	tower1_trail_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; MIST_TOWER1_TRAIL2		-- tower1 trail2
location37:
	.byte	MIST_TOWER1_BOTTOM	; north exit
	.byte	MIST_TOWER1_TRAIL	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tower1_trail2_n_lzsa	; north bg
	.word	tower1_trail2_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	tower1_trail2_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST
	.byte	$ff

; MIST_TOWER1_BOTTOM		-- tower1 bottom
location38:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TOWER1_TRAIL2	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	tower1_base_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	10,26		; special x
	.byte	0,46		; special y
	.word	leave_tower1-1	; special function


; MIST_TOWER1_TOP		-- tower1 top
location39:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MIST_TOWER1_BOTTOM	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	tower1_top_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	16,22		; special x
	.byte	10,18		; special y
	.word	circuit_breaker-1	; special function

; MIST_VIEWER_DOOR	-- viewer door
location40:
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

