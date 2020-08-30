
;===============================================
; level data for Meche level
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
	.word location40,location41,location42,location43
	.word location44,location45,location46,location47
	.word location48,location49,location50,location51
	.word location52,location53,location54

; MECHE_INSIDE_GEAR		-- Inside gear on Mist
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_CLOSED_BOOK	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	departure_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit


; MECHE_CLOSED_BOOK		-- closed book
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_OPEN_BOOK		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	meche_book_closed_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; MECHE_OPEN_BOOK		-- open book
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_INSIDE_GEAR	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	meche_book_open_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	meche_link_book-1		; special function


; MECHE_ARRIVAL			-- arrival
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_ENTRANCE		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	arrival_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; MECHE_ENTRANCE		-- entrance
location4:
	.byte	MECHE_FORT_VIEW		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_ARRIVAL		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	entrance_n_lzsa		; north bg
	.word	entrance_s_lzsa		; south bg
	.word	entrance_e_lzsa		; east bg
	.word	entrance_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_N|DIRECTION_W	; special exit
	.byte	6,36		; special x
	.byte	26,46		; special y
	.word	try_exit_puzzle-1	; special function


; MECHE_FORT_VIEW		-- fort view
location5:
	.byte	MECHE_BRIDGE2		; north exit
	.byte	MECHE_ENTRANCE		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	fort_view_n_lzsa	; north bg
	.word	fort_view_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_BRIDGE2				-- bridge2
location6:
	.byte	MECHE_FORT_DOOR		; north exit
	.byte	MECHE_FORT_VIEW		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bridge2_n_lzsa		; north bg
	.word	bridge2_s_lzsa		; south bg
	.word	bridge2_e_lzsa		; east bg
	.word	bridge2_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit


; MECHE_FORT_DOOR			-- fort door
location7:
	.byte	MECHE_FORT_ENTRY		; north exit
	.byte	MECHE_BRIDGE2		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	fort_door_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff		; special exit

; MECHE_FORT_ENTRY			-- fort entryway
location8:
	.byte	MECHE_LEFT_HALL2	; north exit
	.byte	MECHE_BRIDGE2		; south exit
	.byte	MECHE_RIGHT_HALL2	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	fort_entry_n_lzsa	; north bg
	.word	fort_entry_s_lzsa	; south bg
	.word	fort_entry_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff		; special exit

; MECHE_WEST_PLATFORM			-- rotated to west platform
location9:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_FORT_ENTRY	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	westturn_n_lzsa	; north bg
	.word	westturn_s_lzsa	; south bg
	.word	westturn_e_lzsa	; east bg
	.word	westturn_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit


; MECHE_NORTH_PLATFORM			-- rotated to north platform
location10:
	.byte	MECHE_NORTH_DIP		; north exit
	.byte	MECHE_FORT_ENTRY	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	northturn_n_lzsa	; north bg
	.word	northturn_s_lzsa	; south bg
	.word	northturn_e_lzsa	; east bg
	.word	northturn_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit

; MECHE_NORTH_HINT			-- hint plate
location11:
	.byte	MECHE_NORTH_CLOSE	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	north_hint_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff		; special exit

; MECHE_NORTH_TOP			-- north top
location12:
	.byte	MECHE_NORTH_CLOSE	; north exit
	.byte	MECHE_NORTH_DIP		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	north_top_n_lzsa	; north bg
	.word	north_top_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_NORTH_DIP			-- north dip
location13:
	.byte	MECHE_NORTH_TOP		; north exit
	.byte	MECHE_NORTH_PLATFORM	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	north_dip_n_lzsa	; north bg
	.word	north_dip_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_LEFT_HALL2			-- left hallway
location14:
	.byte	MECHE_LEFT_HALL_CORNER	; north exit
	.byte	MECHE_FORT_ENTRY	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	left_hall2_n_lzsa	; north bg
	.word	left_hall2_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_LEFT_HALL_CORNER		-- left hallway corner
location15:
	.byte	MECHE_LEFT_HALL_CORNER	; north exit
	.byte	MECHE_LEFT_HALL2	; south exit
	.byte	MECHE_RED_ROOM_CENTER	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	$ff			; west exit_dir
	.word	$0000			; north bg
	.word	left_hall_corner_s_lzsa	; south bg
	.word	left_hall_corner_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_EAST
	.byte	$ff		; special exit

; MECHE_RED_ROOM_CENTER		-- center of red room
location16:
	.byte	$ff			; north exit
	.byte	MECHE_RED_THRONE	; south exit
	.byte	MECHE_RED_ROOM_EAST	; east exit
	.byte	MECHE_LEFT_HALL_CORNER	; west exit
	.byte	$ff			; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	DIRECTION_S		; west exit_dir
	.word	red_room_center_n_lzsa	; north bg
	.word	red_room_center_s_lzsa	; south bg
	.word	red_room_center_e_lzsa	; east bg
	.word	red_room_center_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST|BG_EAST
	.byte	DIRECTION_N
	.byte	21,28		; special x
	.byte	12,26		; special y
	.word	view_telescope-1	; special function
;	.byte	DIRECTION_S
;	.byte	25,33		; special x
;	.byte	18,38		; special y
;	.word	enter_red_secret-1	; special function

; MECHE_CENTER_HALL		-- center hall 1
location17:
	.byte	$ff			; north exit
	.byte	MECHE_RED_BUTTON	; south exit
	.byte	MECHE_CENTER_HALL	; east exit
	.byte	MECHE_RED_ROOM_EAST	; west exit
	.byte	$ff			; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	DIRECTION_S		; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	$0000			; north bg
	.word	center_hall_s_lzsa	; south bg
	.word	center_hall_e_lzsa	; east bg
	.word	center_hall_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_RED_BUTTON			-- Button on wall
location18:
	.byte	MECHE_CENTER_HALL	; north exit
	.byte	MECHE_CENTER_HALL2	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	red_button_n_lzsa	; north bg
	.word	red_button_s_lzsa	; south bg
	.word	red_button_e_lzsa	; east bg
	.word	red_button_cf_ce_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST|BG_SOUTH|BG_NORTH
	.byte	DIRECTION_W	; special exit
	.byte	28,33		; special x
	.byte	14,24		; special y
	.word	basement_button-1		; special function


; MECHE_BASEMENT			-- Basement
location19:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_RED_BUTTON	; east exit
	.byte	MECHE_ELEVATOR_ROTATE	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	elevator_basement_e_lzsa	; east bg
	.word	elevator_basement_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff		; special exit

; MECHE_ELEVATOR_ROTATE			-- elevator rotate mechanism
location20:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_BASEMENT		; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_E		; west exit_dir
	.word	$ff				; north bg
	.word	$ff				; south bg
	.word	$ff				; east bg
	.word	basement_controls_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	21,29		; special x
	.byte	14,36		; special y
	.word	elevator_panel_clicked-1	; special function

; MECHE_RIGHT_HALL2			-- looks a lot like left hall2
location21:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_RIGHT_HALL_CORNER	; east exit
	.byte	MECHE_FORT_ENTRY	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_N		; east exit_dir
	.byte	DIRECTION_S		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	left_hall2_n_lzsa	; east bg
	.word	right_hall2_s_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; MECHE_RIGHT_HALL_CORNER		-- looks a lot like left hall corner
location22:
	.byte	MECHE_BLUE_ROOM_SOUTH	; north exit
	.byte	MECHE_RIGHT_HALL_CORNER	; south exit
	.byte	$ff			; east exit
	.byte	MECHE_RIGHT_HALL2	; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_W		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	right_hall_corner_n_lzsa	; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	right_hall_corner_w_lzsa	; west bg
	.byte	BG_NORTH|BG_WEST
	.byte	$ff		; special exit



; MECHE_BLUE_ROOM_CENTER		-- center of blue room
location23:
	.byte	MECHE_CENTER_HALL2		; north exit
	.byte	MECHE_BLUE_ROOM_SOUTH		; south exit
	.byte	$ff				; east exit
	.byte	MECHE_BLUE_THRONE		; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	blue_room_center_n_lzsa		; north bg
	.word	blue_room_center_s_lzsa		; south bg
	.word	blue_room_center_e_lzsa		; east bg
	.word	blue_room_center_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff
;	.byte	DIRECTION_W
;	.byte	9,14		; special x
;	.byte	24,44		; special y
;	.word	enter_blue_secret-1	; special function


; MECHE_CENTER_HALL2		-- center hall 2
location24:
	.byte	MECHE_CENTER_HALL2	; north exit
	.byte	MECHE_BLUE_ROOM_CENTER	; south exit
	.byte	$ff			; east exit
	.byte	MECHE_RED_BUTTON	; west exit
	.byte	DIRECTION_W		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_N		; west exit_dir
	.word	center_hall2_n_lzsa	; north bg
	.word	center_hall2_s_lzsa	; south bg
	.word	$ff			; east bg
	.word	center_hall2_w_lzsa	; west bg
	.byte	BG_WEST|BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_ELEVATOR_PATH		-- path to elevator
location25:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_RED_BUTTON	; east exit
	.byte	MECHE_IN_ELEVATOR	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	elevator_path_e_lzsa	; east bg
	.word	elevator_path_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff		; special exit

; MECHE_IN_ELEVATOR		-- elevator (ground floor default)
location26:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_ELEVATOR_PATH	; east exit
	.byte	$ff			; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	$0000			; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	elevator_ground_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	1,12		; special x
	.byte	14,30		; special y
	.word	elevator_button-1		; special function

; MECHE_TOP_FLOOR			-- elevator top floor
location27:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_TOP_FLOOR		; east exit
	.byte	MECHE_IN_ELEVATOR	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_W		; east exit_dir
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	top_floor_e_lzsa	; east bg
	.word	top_floor_ye_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	13,25		; special x
	.byte	0,8		; special y
	.word	goto_top_floor_up-1	; special function

; MECHE_ROTATE_CONTROLS			-- elevator rotate controls
location28:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_TOP_FLOOR		; east exit
	.byte	MECHE_IN_ELEVATOR	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_W		; east exit_dir
	.byte	DIRECTION_E|DIRECTION_ONLY_POINT		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	rotate_controls_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	13,28		; special x
	.byte	18,42		; special y
	.word	handle_rotation_controls-1	; special function

; MECHE_EAST_PLATFORM			-- rotated to east platform
location29:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_EAST_PATH		; east exit
	.byte	MECHE_FORT_ENTRY	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	eastturn_n_lzsa	; north bg
	.word	eastturn_s_lzsa	; south bg
	.word	eastturn_e_lzsa	; east bg
	.word	eastturn_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE EAST_ARCH			-- cool archway
location30:
	.byte	$ff			; north exit
	.byte	MECHE_EAST_STEPS	; south exit
	.byte	$ff			; east exit
	.byte	MECHE_EAST_PATH		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	east_arch_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	east_arch_w_lzsa	; west bg
	.byte	BG_SOUTH|BG_WEST
	.byte	$ff		; special exit

; MECHE_EAST_TOP			-- top of the world
location31:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_EAST_HINT		; east exit
	.byte	MECHE_EAST_LANDING	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	east_top_e_lzsa		; east bg
	.word	east_top_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; MECHE EAST_HINT			-- final hint
location32:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_EAST_TOP		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	east_hint_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; MECHE EXIT_PUZZLE			-- exit puzzle
location33:
	.byte	MECHE_ENTRANCE		; north exit
	.byte	$ff			; south exit
	.byte	MECHE_EAST_TOP		; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	exit_puzzle_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	2,38		; special x
	.byte	26,48		; special y
	.word	exit_puzzle_button_press-1	; special function

; MECHE_BOOK_STAIRS			-- stairs down to book
location34:
	.byte	MECHE_MIST_BOOK		; north exit
	.byte	MECHE_ENTRANCE		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_stairs_n_lzsa	; north bg
	.word	book_stairs_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; MECHE_MIST_BOOK			-- book in room
location35:
	.byte	MECHE_MIST_CLOSED	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_room_n_lzsa	; north bg
	.word	$ff			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; MECHE_MIST_CLOSED			-- book in room
location36:
	.byte	MECHE_MIST_OPEN		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_closed_n_lzsa	; north bg
	.word	$ff			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; MECHE_MIST_OPEN			-- book in room
location37:
	.byte	MECHE_BOOK_STAIRS	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	book_open_n_lzsa	; north bg
	.word	$ff			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N
	.byte	24,32		; special x
	.byte	12,22		; special y
	.word	mist_link_book-1	; special function

; MECHE_BLUE_SECRET_DOOR		-- blue room secret door
location38:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_BLUE_SECRET_ROOM	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	blue_secret_door_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	$ff

; MECHE_BLUE_SECRET_ROOM		-- blue room secret room
location39:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_BLUE_ROOM_CENTER	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_secret_room_n_lzsa	; north bg
	.word	blue_secret_room_s_lzsa	; south bg
	.word	blue_secret_room_e_lzsa	; east bg
	.word	blue_secret_room_w_lzsa	; west bg
	.byte	BG_NORTH | BG_SOUTH | BG_EAST | BG_WEST
	.byte   DIRECTION_W|DIRECTION_N
	.byte	8,18		; special x
	.byte	22,40		; special y
	.word	meche_take_blue_page-1	; special function

; MECHE_RED_SECRET_DOOR		-- red room secret door
location40:
	.byte	$ff			; north exit
	.byte	MECHE_RED_SECRET_ROOM	; south exit
	.byte	$ff			; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	red_secret_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; MECHE_RED_SECRET_ROOM			-- red room secret room
location41:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_RED_ROOM_CENTER	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	red_secret_room_n_lzsa	; north bg
	.word	red_secret_room_s_lzsa	; south bg
	.word	red_secret_room_e_lzsa	; east bg
	.word	red_secret_room_w_lzsa	; west bg
	.byte	BG_NORTH | BG_SOUTH | BG_EAST | BG_WEST
	.byte   DIRECTION_N | DIRECTION_S
	.byte	22,31		; special x
	.byte	14,32		; special y
	.word	meche_take_red_page-1	; special function

; MECHE_TOP_FLOOR_UP			-- looking above elevator
location42:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_TOP_FLOOR		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	top_floor_up_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; MECHE_ACHENAR_LETTER			-- letter from Achenar
location43:
	.byte	$ff			; north exit
	.byte	MECHE_RED_SECRET_ROOM	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	achenar_letter_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; MECHE_EAST_PATH			-- path to east hint
location44:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_EAST_ARCH		; east exit
	.byte	MECHE_EAST_PLATFORM	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	east_path_e_lzsa	; east bg
	.word	east_path_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; MECHE_EAST_STEPS			-- steps to east hint
location45:
	.byte	MECHE_EAST_ARCH		; north exit
	.byte	MECHE_EAST_LANDING	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	east_steps_n_lzsa	; north bg
	.word	east_steps_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

; MECHE_EAST_LANDING			-- steps to east hint
location46:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_EAST_TOP		; east exit
	.byte	MECHE_EAST_STEPS	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	east_landing_e_lzsa	; east bg
	.word	east_landing_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; MECHE_NORTH_CLOSE			-- north close
location47:
	.byte	MECHE_NORTH_HINT	; north exit
	.byte	MECHE_NORTH_TOP		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	north_close_n_lzsa	; north bg
	.word	north_close_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; MECHE_RED_THRONE		-- red room throne
location48:
	.byte	$ff			; north exit
	.byte	MECHE_RED_ROOM_CENTER	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff			; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	$0000			; north bg
	.word	red_throne_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S
	.byte	28,37		; special x
	.byte	10,34		; special y
	.word	enter_red_secret-1	; special function

; MECHE_RED_ROOM_EAST		-- east exit of red room
location49:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	MECHE_CENTER_HALL	; east exit
	.byte	MECHE_RED_ROOM_CENTER	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	red_room_east_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	red_room_east_e_lzsa	; east bg
	.word	red_room_east_w_lzsa	; west bg
	.byte	BG_NORTH|BG_WEST|BG_EAST
	.byte	$ff

; MECHE_TELESCOPE_SKELETON		-- some call him "Bob"
location50:
	.byte	MECHE_RED_ROOM_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	red_skeleton_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff		; special exit


; MECHE_TELESCOPE_PLAIN		-- nothing
location51:
	.byte	MECHE_RED_ROOM_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	red_no_skeleton_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff		; special exit

; MECHE_BLUE_THRONE		-- blue room throne
location52:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_BLUE_ROOM_CENTER	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	blue_throne_closed_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W
	.byte	5,13		; special x
	.byte	16,40		; special y
	.word	open_blue_secret-1	; special function

; MECHE_BLUE_THRONE_OPEN	-- blue room throne, open passage
location53:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_BLUE_ROOM_CENTER	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_W		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	blue_throne_open_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W
	.byte	5,13		; special x
	.byte	16,40		; special y
	.word	enter_blue_secret-1	; special function

; MECHE_BLUE_ROOM_SOUTH		-- south side of blue room
location54:
	.byte	MECHE_BLUE_ROOM_CENTER		; north exit
	.byte	MECHE_RIGHT_HALL_CORNER		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_W		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	blue_room_south_n_lzsa		; north bg
	.word	blue_room_south_s_lzsa		; south bg
	.word	blue_room_south_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	DIRECTION_E
	.byte	27,31		; special x
	.byte	34,46		; special y
	.word	touch_blue_box-1	; special function
