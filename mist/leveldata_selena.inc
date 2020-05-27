
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
	.word location24,location25


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
	.byte	SELENA_WALKWAY4		; north exit
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
	.byte	SELENA_WALKWAY1		; south exit
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
	.byte	SELENA_SUB_ROOM		; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bunker_n_lzsa		; north bg
	.word	bunker_s_lzsa		; south bg
	.word	bunker_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff

; SELENA_SUB_ROOM		-- sub room
location7:
	.byte	$ff			; north exit
	.byte	SELENA_BOOK_ROOM	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	subroom_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff

; SELENA_BOOK_ROOM		-- book room
location8:
	.byte	$ff			; north exit
	.byte	SELENA_BOOK_CLOSED	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	book_table_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; SELENA_BOOK_CLOSED		-- book
location9:
	.byte	$ff			; north exit
	.byte	SELENA_BOOK_OPEN	; south exit
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

; SELENA_BOOK_OPEN		-- mist book open
location10:
	.byte	$ff			; north exit
	.byte	SELENA_BOOK_ROOM	; south exit
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

; SELENA_WATER_TURN		-- turnoff for water
location11:
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
location12:
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
location13:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	SELENA_WATER_PATH	; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	water_note_s_lzsa		; south bg
	.word	water_note_e_lzsa		; east bg
	.word	water_note_w_lzsa		; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_S		; special exit
	.byte	20,27		; special x
	.byte	24,34		; special y
	.word	selena_take_blue_page-1	; special function

; SELENA_TOWER_VIEW		-- tower view
location14:
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
location15:
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
location16:
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
	.word	$0000				; west bg
	.byte	BG_SOUTH|BG_EAST|BG_NORTH
	.byte	$ff

; SELENA_CLOCK_PATH			-- path on way to clock
location17:
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
location18:
	.byte	$ff			; north exit
	.byte	SELENA_CLOCK_CLOSE	; south exit
	.byte	SELENA_CLOCK_BEFORE	; east exit
	.byte	SELENA_CLOCK_PATH	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	clock_n_lzsa			; north bg
	.word	clock_s_lzsa			; south bg
	.word	clock_e_lzsa			; east bg
	.word	clock_w_lzsa			; west bg
	.byte	BG_SOUTH|BG_EAST|BG_WEST|BG_NORTH
	.byte	$ff

; SELENA_CLOCK_CLOSE		-- clock device
location19:
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
	.byte	$ff

; SELENA_CLOCK_BEFORE	-- path before clocks, when coming from crystals
location20:
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
location21:
	.byte	$ff			; north exit
	.byte	SELENA_CRYSTAL_STEPS	; south exit
	.byte	$ff			; east exit
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
location22:
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
location23:
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
location24:
	.byte	SELENA_CRYSTAL_PATH	; north exit
	.byte	SELENA_CRYSTAL_CLOSE	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	crystals_n_lzsa			; north bg
	.word	crystals_s_lzsa			; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; SELENA_CRYSTAL_CLOSE		-- at the crystal device
location25:
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
	.byte	$ff

