
;===============================================
; level data for Selena level
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
	.word location40,location41,location42

; SELENA_INSIDE_SHIP		-- Inside Ship
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_CONTROLS		; east exit
	.byte	SELENA_ELECTRIC_ORGAN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	(DIRECTION_E|DIRECTION_ONLY_POINT)	; east exit_dir
	.byte	(DIRECTION_W|DIRECTION_ONLY_POINT)	; west exit_dir
	.word	spaceship_inside_mist_n_lzsa	; north bg
	.word	$0000				; south bg
	.word	spaceship_inside_e_lzsa		; east bg
	.word	spaceship_inside_w_lzsa		; west bg
	.byte	BG_WEST | BG_EAST | BG_NORTH
	.byte	DIRECTION_N		; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	back_to_mist-1	; special function

; SELENA_CONTROLS		-- controls
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_INSIDE_SHIP	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	controls_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	12,25		; special x
	.byte	26,46		; special y
	.word	controls_pressed-1		; special function


; SELENA_ELECTRIC_ORGAN		-- electric organ
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SELENA_INSIDE_SHIP	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	organ_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	7,31		; special x
	.byte	24,34		; special y
	.word	organ_pressed-1		; special function


; SELENA_WALKWAY1		-- walkway1
location3:
	.byte	SELENA_WALKWAY2		; north exit
	.byte	SELENA_SPACESHIP_DOOR	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway1_n_lzsa		; north bg
	.word	walkway1_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; SELENA_SPACESHIP_DOOR		-- spaceship door
location4:
	.byte	$ff			; north exit
	.byte	SELENA_WALKWAY1		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	spaceship_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; SELENA_WALKWAY4		-- walkway4
location5:
	.byte	SELENA_BUNKER		; north exit
	.byte	SELENA_WALKWAY3		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway4_n_lzsa		; north bg
	.word	walkway4_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_BUNKER			-- bunker
location6:
	.byte	SELENA_WATER_TURN	; north exit
	.byte	SELENA_WALKWAY4		; south exit
	.byte	SELENA_BUNKER_KEYPAD	; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bunker_n_lzsa		; north bg
	.word	bunker_s_lzsa		; south bg
	.word	bunker_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff

; SELENA_WATER_TURN		-- turnoff for water
location7:
	.byte	SELENA_TOWER_VIEW		; north exit
	.byte	SELENA_BUNKER		; south exit
	.byte	$ff			; east exit
	.byte	SELENA_WATER_PATH	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	water_turn_n_lzsa	; north bg
	.word	water_turn_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	water_turn_w_lzsa	; west bg
	.byte	BG_SOUTH|BG_NORTH|BG_WEST
	.byte	$ff

; SELENA_WATER_PATH		-- path to water
location8:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_WATER_TURN	; east exit
	.byte	SELENA_WATER		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	water_path_e_lzsa	; east bg
	.word	water_path_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_WATER		-- water
location9:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_WATER_PATH	; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	water_note_n_lzsa		; north bg
	.word	water_note_s_lzsa		; south bg
	.word	water_note_e_lzsa		; east bg
	.word	water_note_w_lzsa		; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST|BG_NORTH
	.byte	DIRECTION_S|DIRECTION_W		; special exit
	.byte	19,27		; special x
	.byte	24,34		; special y
	.word	selena_take_blue_page-1	; special function

; SELENA_TOWER_VIEW		-- tower view
location10:
	.byte	$ff			; north exit
	.byte	SELENA_WATER_TURN	; south exit
	.byte	SELENA_CLOCK_PATH	; east exit
	.byte	SELENA_CHASM_PATH	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	tower_view_n_lzsa		; north bg
	.word	tower_view_s_lzsa		; south bg
	.word	tower_view_e_lzsa		; east bg
	.word	tower_view_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; SELENA_CHASM_PATH		-- path to chasm
location11:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TOWER_VIEW	; east exit
	.byte	SELENA_CHASM		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	chasm_path_e_lzsa		; east bg
	.word	chasm_path_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_CHASM			-- chasm
location12:
	.byte	SELENA_CHASM_PATH	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chasm_n_lzsa			; north bg
	.word	chasm_s_lzsa			; south bg
	.word	chasm_e_lzsa			; east bg
	.word	chasm_w_lzsa			; west bg
	.byte	BG_SOUTH|BG_EAST|BG_NORTH|BG_WEST
	.byte	DIRECTION_S	; special exit
	.byte	17,24		; special x
	.byte	18,26		; special y
	.word	chasm_button_pressed-1	; special function


; SELENA_CLOCK_PATH			-- path on way to clock
location13:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_CLOCK		; east exit
	.byte	SELENA_TOWER_VIEW	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	clock_path_e_lzsa		; east bg
	.word	clock_path_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_CLOCK			-- clocks
location14:
	.byte	$ff			; north exit
	.byte	SELENA_CLOCK_CLOSE	; south exit
	.byte	SELENA_CLOCK_BEFORE	; east exit
	.byte	SELENA_CLOCK_PATH	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S|DIRECTION_SPLIT	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	clock_n_lzsa			; north bg
	.word	clock_s_lzsa			; south bg
	.word	clock_e_lzsa			; east bg
	.word	clock_w_lzsa			; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST|BG_NORTH
	.byte	$ff

; SELENA_CLOCK_CLOSE		-- clock device
location15:
	.byte	$ff			; north exit
	.byte	SELENA_CLOCK		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	clock_note_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S		; special exit
	.byte	17,22		; special x
	.byte	20,28		; special y
	.word	clock_button_pressed-1	; special function

; SELENA_CLOCK_BEFORE	-- path before clocks, when coming from crystals
location16:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_CRYSTAL_TURN	; east exit
	.byte	SELENA_CLOCK		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	clock_before_e_lzsa		; east bg
	.word	clock_before_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_CRYSTAL_TURN	-- crystal turnoff
location17:
	.byte	$ff			; north exit
	.byte	SELENA_CRYSTAL_STEPS	; south exit
	.byte	SELENA_BEFORE_CRYSTALS	; east exit
	.byte	SELENA_CLOCK_BEFORE	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	crystal_turn_n_lzsa		; north bg
	.word	crystal_turn_s_lzsa		; south bg
	.word	crystal_turn_e_lzsa		; east bg
	.word	crystal_turn_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; SELENA_CRYSTAL_STEPS	-- top of steps
location18:
	.byte	$ff			; north exit
	.byte	SELENA_CRYSTALS		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	crystal_steps_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH
	.byte	$ff

; SELENA_CRYSTAL_PATH	-- bottom of steps
location19:
	.byte	SELENA_CRYSTAL_TURN	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	crystal_path_n_lzsa		; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH
	.byte	$ff

; SELENA_CRYSTALS		-- down by the crystals
location20:
	.byte	SELENA_CRYSTAL_PATH	; north exit
	.byte	SELENA_CRYSTAL_CLOSE	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E|DIRECTION_SPLIT	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	crystals_n_lzsa			; north bg
	.word	crystals_s_lzsa			; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_CRYSTAL_CLOSE		-- at the crystal device
location21:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_CRYSTALS		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	crystals_note_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	14,25		; special x
	.byte	0,34		; special y
	.word	selena_take_red_page-1	; special function


; SELENA_WALKWAY3		-- spaceship path/ walkway3
location22:
	.byte	SELENA_WALKWAY4		; north exit
	.byte	SELENA_WALKWAY2		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway3_n_lzsa		; north bg
	.word	walkway3_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_BEFORE_CRYSTALS	-- before crystals, if coming from tunnel
location23:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL_STEPS	; east exit
	.byte	SELENA_CRYSTAL_TURN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	before_crystals_e_lzsa		; east bg
	.word	before_crystals_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_TUNNEL_STEPS	-- steps on way to tunnel
location24:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL_PATH	; east exit
	.byte	SELENA_BEFORE_CRYSTALS	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	tunnel_steps_w_lzsa		; east bg
	.word	tunnel_steps_e_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_TUNNEL_PATH	-- path near tunnel
location25:
	.byte	SELENA_TUNNEL_MAINLAND	; north exit
	.byte	SELENA_TUNNEL_STEPS	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel_path_n_lzsa		; north bg
	.word	tunnel_path_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	tunnel_path_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST
	.byte	$ff

; SELENA_TUNNEL_MAINLAND	-- mainland tunnel entrance
location26:
	.byte	SELENA_TUNNEL_MAIN_CLOSE; north exit
	.byte	SELENA_TUNNEL_PATH	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N|DIRECTION_SPLIT	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel_main_n_lzsa		; north bg
	.word	tunnel_main_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_N		; special exit
	.byte	12,28		; special x
	.byte	24,46		; special y
	.word	tunnel_main_down-1	; special function

; SELENA_TUNNEL_MAIN_CLOSE	-- note panel on the tunnel
location27:
	.byte	SELENA_TUNNEL_MAINLAND	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel_note_n_lzsa		; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N		; special exit
	.byte	17,22		; special x
	.byte	26,34		; special y
	.word	tunnel_button_pressed-1	; special function

; SELENA_TUNNEL_MAIN_TOP	-- top of the ladder
location28:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL_MAINLAND	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	ladder_top_lzsa			; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	12,28		; special x
	.byte	24,46		; special y
	.word	tunnel_main_top_down-1	; special function

; SELENA_TUNNEL_MAIN_MID	-- middle of ladder
location29:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL_MAIN_TOP	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	ladder_middle_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	12,28		; special x
	.byte	24,46		; special y
	.word	tunnel_main_mid_down-1	; special function

; SELENA_TUNNEL_BASEMENT	-- bottom of ladder
location30:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL_MAIN_MID	; east exit
	.byte	SELENA_TUNNEL		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	ladder_bottom_lzsa		; east bg
	.word	tunnel_basement_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_TUNNEL		-- middle of tunnel (dark for now)
location31:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL_BASEMENT	; east exit
	.byte	SELENA_ANTENNA_BASEMENT	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	tunnel_e_lzsa			; east bg
	.word	tunnel_w_lzsa			; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_ANTENNA_BASEMENT	-- basement near antenna
location32:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_TUNNEL		; east exit
	.byte	SELENA_ANTENNA_MID	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_E	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	tunnel_basement_lzsa		; east bg
	.word	ladder_bottom_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_ANTENNA_MID	-- antenna ladder, mid
location33:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_ANTENNA_TOP	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	ladder_middle_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	12,28		; special x
	.byte	24,46		; special y
	.word	antenna_mid_down-1	; special function

; SELENA_ANTENNA_TOP	-- staring down ladder near antenna
location34:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_ANTENNA_TUNNEL	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	ladder_top_lzsa			; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	12,28		; special x
	.byte	24,46		; special y
	.word	antenna_mid_down-1	; special function

; SELENA_ANTENNA_TUNNEL	-- top of ladder near antenna
location35:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SELENA_ANTENNA_STEPS	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	antenna_tunnel_e_lzsa		; east bg
	.word	antenna_tunnel_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_E		; special exit
	.byte	12,28		; special x
	.byte	24,46		; special y
	.word	antenna_down-1	; special function

; SELENA_ANTENNA_STEPS		-- steps near antenna
location36:
	.byte	SELENA_ANTENNA		; north exit
	.byte	SELENA_ANTENNA_TUNNEL	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	antenna_steps_n_lzsa		; north bg
	.word	antenna_steps_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_ANTENNA	-- base of antenna
location37:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_ANTENNA_STEPS	; east exit
	.byte	SELENA_ANTENNA_OPEN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	antenna_e_lzsa			; east bg
	.word	antenna_w_lzsa			; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; SELENA_ANTENNA_OPEN	-- antenna panel open
location38:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_ANTENNA_STEPS	; east exit
	.byte	SELENA_ANTENNA_CLOSE	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W|DIRECTION_SPLIT	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	antenna_e_lzsa			; east bg
	.word	antenna_open_w_lzsa		; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff

; SELENA_ANTENNA_CLOSE	-- antenna panel
location39:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	SELENA_ANTENNA		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	antenna_close_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W		; special exit
	.byte	6,32		; special x
	.byte	24,40		; special y
	.word	touch_antenna_panel-1	; special function

; SELENA_BUNKER_OPEN	-- bunker with door open
location40:
	.byte	SELENA_WATER_TURN	; north exit
	.byte	SELENA_WALKWAY4		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bunker_n_lzsa		; north bg
	.word	bunker_s_lzsa		; south bg
	.word	bunker_open_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	15,27		; special x
	.byte	6,42		; special y
	.word	goto_sub-1	; special function

; SELENA_BUNKER_KEYPAD	-- bunker keypad
location41:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_BUNKER		; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	bunker_keypad_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	12,28		; special x
	.byte	10,32		; special y
	.word	keypad_press-1	; special function

; SELENA_WALKWAY2		-- walkway2
location42:
	.byte	SELENA_WALKWAY3		; north exit
	.byte	SELENA_WALKWAY1		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway2_n_lzsa		; north bg
	.word	walkway2_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff
