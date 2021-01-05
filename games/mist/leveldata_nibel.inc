;===============================================
; level data for Nibel clouds
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20,location21,location22,location23
	.word location24,location25,location26,location27
	.word location28,location29,location30

; NIBEL_IN_ELEV2_TOP_CLOSED	-- inside elevator2 at top, door closed
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	NIBEL_IN_ELEV2_TOP_OPEN	; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	elevator2_closed_top_lzsa	; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	28,34		; special x
	.byte	28,36		; special y
	.word	elevator2_handle-1	; special function

; NIBEL_IN_ELEV2_TOP_OPEN	-- inside elevator2 at top, door open
location1:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_OUTSIDE_ELEV2_CLOSED	; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	elevator2_open_top_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	10,17		; special x
	.byte	6,46		; special y
	.word	elevator2_close_door-1	; special function

; NIBEL_OUTSIDE_ELEV2_OPEN	-- outside of elevator2 at top, door open
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	NIBEL_BLUE_PATH_0P5	; east exit
	.byte	NIBEL_RED_PATH1		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	outside_elevator2_e_lzsa	; east bg
	.word	outside_elevator2_open_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_W		; special exit
	.byte	5,15			; special x
	.byte	8,34			; special y
	.word	nibel_getin_elevator-1	; special function


; NIBEL_OUTSIDE_ELEV2_CLOSED	-- outside of elevator2 at top, door closed
location3:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_BLUE_PATH_0P5		; east exit
	.byte	NIBEL_RED_PATH1			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	outside_elevator2_e_lzsa	; east bg
	.word	outside_elevator2_closed_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_W		; special exit
	.byte	5,15			; special x
	.byte	8,34			; special y
	.word	nibel_open_elevator-1	; special function

; NIBEL_BLUE_PATH1	-- path 1 to blue house
location4:
	.byte	NIBEL_BLUE_PATH_0P5		; north exit
	.byte	NIBEL_BLUE_PATH2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path1_n_lzsa		; north bg
	.word	blue_path1_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; NIBEL_BLUE_PATH2	-- path 2 to blue house
location5:
	.byte	NIBEL_BLUE_PATH1		; north exit
	.byte	NIBEL_BLUE_PATH_2P25		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path2_n_lzsa		; north bg
	.word	blue_path2_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; NIBEL_BLUE_PATH3	-- path 3 to blue house
location6:
	.byte	NIBEL_BLUE_PATH_2P75		; north exit
	.byte	NIBEL_BLUE_HOUSE_DOOR		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path3_n_lzsa		; north bg
	.word	blue_path3_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_N	; special exit
	.byte	23,35		; special x
	.byte	6,42		; special y
	.word	goto_shack_outside-1	; special function

; NIBEL_BLUE_ROOM	-- blue house
location7:
	.byte	NIBEL_BLUE_HOUSE_DOOR		; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_BLUE_HOUSE_VIEWER		; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_house_n_lzsa		; north bg
	.word	blue_house_s_lzsa		; south bg
	.word	blue_house_e_lzsa		; east bg
	.word	blue_house_w_lzsa		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_E		; special exit
	.byte	5,11			; special x
	.byte	40,46			; special y
	.word	nibel_take_blue_page-1	; special function

; NIBEL_BLUE_HOUSE_VIEWER	-- blue house viewer machine
location8:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_BLUE_ROOM			; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	projector_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	14,24			; special x
	.byte	34,40			; special y
	.word	projector_button-1	; special function

; NIBEL_RED_PATH1	-- path 1 to red house
location9:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_OUTSIDE_ELEV2_CLOSED	; east exit
	.byte	NIBEL_RED_DOOR_CLOSED		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	red_path1_e_lzsa		; east bg
	.word	red_path1_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_RED_DOOR_CLOSED	-- outside red house
location10:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_RED_PATH1			; east exit
	.byte	NIBEL_RED_DOOR_OPEN		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	red_door_e_lzsa			; east bg
	.word	red_door_closed_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_RED_DOOR_OPEN	-- outside red house, door open
location11:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_RED_PATH1			; east exit
	.byte	NIBEL_RED_ROOM			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	red_door_e_lzsa			; east bg
	.word	red_door_open_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_RED_ROOM	-- inside red room
location12:
	.byte	$ff				; north exit
	.byte	NIBEL_RED_TABLE			; south exit
	.byte	NIBEL_RED_DOOR_CLOSED		; east exit
	.byte	NIBEL_RED_BED			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	red_room_n_lzsa			; north bg
	.word	red_room_s_lzsa			; south bg
	.word	red_room_e_lzsa			; east bg
	.word	red_room_w_lzsa			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_RED_TABLE	-- windmill table closeup
location13:
	.byte	$ff				; north exit
	.byte	NIBEL_RED_ROOM			; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	red_room_table_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S		; special exit
	.byte	10,30			; special x
	.byte	34,44			; special y
	.word	nibel_open_drawer-1	; special function


; NIBEL_RED_TABLE_OPEN	-- windmill table closeup, open with red page
location14:
	.byte	$ff				; north exit
	.byte	NIBEL_RED_ROOM			; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000				; north bg
	.word	red_room_table_open_s_lzsa	; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S		; special exit
	.byte	12,20			; special x
	.byte	36,46			; special y
	.word	nibel_take_red_page-1	; special function

; NIBEL_RED_BED	-- close up of bed
location15:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	NIBEL_RED_BED_OPEN		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	red_room_bed_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff			; special exit

; NIBEL_RED_BED_OPEN	-- bed drawer open
location16:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	NIBEL_RED_ROOM			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	red_room_bed_open_w_lzsa	; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W		; special exit
	.byte	17,24			; special x
	.byte	24,40			; special y
	.word	nibel_view_torn_page-1	; special function

; NIBEL_HALF_LETTER	-- right half of letter
location17:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	$ff				; east exit
	.byte	NIBEL_RED_ROOM			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	$0000				; east bg
	.word	right_letter_lzsa		; west bg
	.byte	BG_WEST
	.byte	$ff			; special exit

; NIBEL_BLUE_PATH_0P5	-- path 0.5 to blue house
location18:
	.byte	NIBEL_OUTSIDE_ELEV2_CLOSED	; north exit
	.byte	NIBEL_BLUE_PATH1		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path_0p5_n_lzsa		; north bg
	.word	blue_path_0p5_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; NIBEL_BLUE_PATH_2P25	-- path 2.25 with the door to conference room
location19:
	.byte	NIBEL_BLUE_PATH2		; north exit
	.byte	NIBEL_BLUE_PATH_2P5		; south exit
	.byte	NIBEL_SHACK_DOOR_OPEN		; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path_2p25_n_lzsa		; north bg
	.word	blue_path_2p25_s_lzsa		; south bg
	.word	blue_path_2p25_e_lzsa		; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	DIRECTION_S	; special exit
	.byte	11,29		; special x
	.byte	4,44		; special y
	.word	handle_shack_door-1	; special function

; NIBEL_BLUE_PATH_2P5	-- path 2.5 along the wall
location20:
	.byte	NIBEL_BLUE_PATH_2P25		; north exit
	.byte	NIBEL_BLUE_PATH_2P75		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path_2p5_n_lzsa		; north bg
	.word	blue_path_2p5_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	DIRECTION_N	; special exit
	.byte	11,17		; special x
	.byte	0,46		; special y
	.word	touch_gate_n-1	; special function


; NIBEL_BLUE_PATH_2P75	-- path 2.75 along the wall
location21:
	.byte	NIBEL_BLUE_PATH_2P5		; north exit
	.byte	NIBEL_BLUE_PATH3		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path_2p75_n_lzsa		; north bg
	.word	blue_path_2p75_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	DIRECTION_S	; special exit
	.byte	5,16		; special x
	.byte	6,42		; special y
	.word	goto_shack_outside-1	; special function

; NIBEL_BLUE_HOUSE_DOOR	-- door outside blue house
location22:
	.byte	NIBEL_BLUE_PATH3		; north exit
	.byte	NIBEL_BLUE_HOUSE_DOOR_OPEN	; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_house_door_n_lzsa		; north bg
	.word	blue_house_door_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	$ff

; NIBEL_BLUE_HOUSE_DOOR_OPEN	-- blue house door, open
location23:
	.byte	NIBEL_BLUE_PATH3		; north exit
	.byte	NIBEL_BLUE_ROOM			; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_house_door_n_lzsa		; north bg
	.word	blue_house_door_open_s_lzsa	; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff			; special function

; NIBEL_SHACK_OUTSIDE	-- outside the weird shack
location24:
	.byte	NIBEL_SHACK_HALLWAY		; north exit
	.byte	NIBEL_BLUE_PATH3		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack_outside_n_lzsa		; north bg
	.word	shack_outside_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	DIRECTION_S	; special exit
	.byte	23,35		; special x
	.byte	6,42		; special y
	.word	goto_wall-1	; special function


; NIBEL_SHACK_HALLWAY	-- outside the weird shack, in the hallway
location25:
	.byte	NIBEL_SHACK_EXIT		; north exit
	.byte	NIBEL_SHACK_OUTSIDE		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack_hallway_n_lzsa		; north bg
	.word	shack_hallway_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	$ff

; NIBEL_SHACK_EXIT	-- exit of the weird shack
location26:
	.byte	NIBEL_SHACK_CENTER		; north exit
	.byte	NIBEL_SHACK_HALLWAY		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack_exit_n_lzsa		; north bg
	.word	shack_exit_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	$ff

; NIBEL_SHACK_CENTER	-- center of the weird shack
location27:
	.byte	NIBEL_SHACK_ENTRANCE		; north exit
	.byte	NIBEL_SHACK_EXIT		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack_center_n_lzsa		; north bg
	.word	shack_center_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	DIRECTION_S	; special exit
	.byte	12,29		; special x
	.byte	20,34		; special y
	.word	touch_trap-1	; special function

; NIBEL_SHACK_ENTRANCE	-- entranceway of the weird shack
location28:
	.byte	NIBEL_SHACK_ENTRANCE_OPEN	; north exit
	.byte	NIBEL_SHACK_CENTER		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack_entrance_n_lzsa		; north bg
	.word	shack_entrance_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	$ff

; NIBEL_SHACK_ENTRANCE_OPEN	-- entranceway of the weird shack, door open
location29:
	.byte	NIBEL_BLUE_PATH_2P25		; north exit
	.byte	NIBEL_SHACK_CENTER		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	shack_entrance_open_n_lzsa	; north bg
	.word	shack_entrance_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH	
	.byte	$ff

; NIBEL_SHACK_DOOR_OPEN	-- open door to conference room
location30:
	.byte	NIBEL_BLUE_PATH2		; north exit
	.byte	NIBEL_BLUE_PATH_2P5		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	blue_path_2p25_n_lzsa		; north bg
	.word	blue_path_2p25_s_lzsa		; south bg
	.word	blue_path_2p25_open_e_lzsa	; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	11,27		; special x
	.byte	4,44		; special y
	.word	scary_entrance-1	; special function
	; FIXME: we should also still handle south stuff if possible
