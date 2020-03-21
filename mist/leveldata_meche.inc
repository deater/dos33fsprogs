
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
	.word location24

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
	.byte	$ff		; special exit

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
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	westturn_n_lzsa	; north bg
	.word	westturn_s_lzsa	; south bg
	.word	westturn_e_lzsa	; east bg
	.word	westturn_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit


; MECHE_NORTH_PLATFORM			-- rotated to north platform
location10:
	.byte	$ff			; north exit
	.byte	MECHE_FORT_ENTRY	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
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
	.byte	MECHE_NORTH_TOP		; north exit
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
	.byte	MECHE_NORTH_HINT	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	$ff			; south exit_dir
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
	.byte	$ff			; north exit
	.byte	MECHE_LEFT_HALL2	; south exit
	.byte	MECHE_RED_ROOM_CENTER	; east exit
	.byte	$ff			; west exit
	.byte	$ff			; north exit_dir
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
	.byte	$ff			; south exit
	.byte	MECHE_CENTER_HALL	; east exit
	.byte	MECHE_LEFT_HALL_CORNER	; west exit
	.byte	$ff			; north exit_dir
	.byte	$ff			; south exit_dir
	.byte	DIRECTION_E		; east exit_dir
	.byte	DIRECTION_S		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	red_room_center_e_lzsa	; east bg
	.word	red_room_center_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff		; special exit

; MECHE_CENTER_HALL		-- center hall 1
location17:
	.byte	$ff			; north exit
	.byte	MECHE_RED_BUTTON	; south exit
	.byte	$ff			; east exit
	.byte	MECHE_RED_ROOM_CENTER	; west exit
	.byte	$ff			; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
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
	.byte	$ff			; west exit_dir
	.word	red_button_n_lzsa	; north bg
	.word	red_button_s_lzsa	; south bg
	.word	red_button_e_lzsa	; east bg
	.word	red_button_cf_ce_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST|BG_SOUTH|BG_NORTH
	.byte	$ff		; special exit

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
	.word	$0000				; east bg
	.word	elevator_basement_w_lzsa	; west bg
	.byte	BG_WEST
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
	.byte	$ff		; special exit

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
	.byte	MECHE_BLUE_ROOM_CENTER	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	MECHE_RIGHT_HALL2	; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	$ff			; south exit_dir
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
	.byte	MECHE_RIGHT_HALL2		; south exit
	.byte	$ff				; east exit
	.byte	MECHE_RIGHT_HALL_CORNER		; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_W		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	$ff			; west exit_dir
	.word	blue_room_center_n_lzsa		; north bg
	.word	blue_room_center_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit


; MECHE_CENTER_HALL2		-- center hall 2
location24:
	.byte	$ff			; north exit
	.byte	MECHE_BLUE_ROOM_CENTER	; south exit
	.byte	$ff			; east exit
	.byte	MECHE_RED_BUTTON	; west exit
	.byte	DIRECTION_N		; north exit_dir
	.byte	DIRECTION_S		; south exit_dir
	.byte	$ff			; east exit_dir
	.byte	DIRECTION_N		; west exit_dir
	.word	center_hall2_n_lzsa	; north bg
	.word	center_hall2_s_lzsa	; south bg
	.word	$ff			; east bg
	.word	center_hall2_w_lzsa	; west bg
	.byte	BG_WEST|BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

