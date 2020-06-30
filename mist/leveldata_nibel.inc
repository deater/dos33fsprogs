;===============================================
; level data for Nibel clouds
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8

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
	.byte	NIBEL_BLUE_PATH1	; east exit
	.byte	NIBEL_IN_ELEV2_TOP_OPEN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_E	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	outside_elevator2_e_lzsa	; east bg
	.word	outside_elevator2_open_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_OUTSIDE_ELEV2_CLOSED	-- outside of elevator2 at top, door closed
location3:
	.byte	$ff				; north exit
	.byte	$ff				; south exit
	.byte	NIBEL_BLUE_PATH1		; east exit
	.byte	NIBEL_OUTSIDE_ELEV2_OPEN	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	outside_elevator2_e_lzsa	; east bg
	.word	outside_elevator2_closed_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff

; NIBEL_BLUE_PATH1	-- path 1 to blue house
location4:
	.byte	NIBEL_OUTSIDE_ELEV2_CLOSED	; north exit
	.byte	NIBEL_BLUE_PATH2		; south exit
	.byte	$ff				; east exit
	.byte	$ff				; west exit
	.byte	DIRECTION_W	; north exit_dir
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
	.byte	NIBEL_BLUE_PATH3		; south exit
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
	.byte	NIBEL_BLUE_PATH2		; north exit
	.byte	NIBEL_BLUE_ROOM			; south exit
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
	.byte	$ff

; NIBEL_BLUE_ROOM	-- blue house
location7:
	.byte	NIBEL_BLUE_PATH3		; north exit
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
	.byte	$ff

