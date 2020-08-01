
;===============================================
; level data for Mist Island Generator
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9

; GEN_GREEN_SHACK
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	GEN_GREEN_STEPS1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	green_house_e_lzsa	; east bg
	.word	green_house_w_lzsa	; west bg
	.byte	BG_EAST | BG_WEST
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	back_to_mist-1	; special function


; GEN_GREEN_STEPS1		-- green shack steps 1
location1:
	.byte	GEN_GREEN_STEPS3	; north exit
	.byte	GEN_GREEN_SHACK		; south exit
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

; GEN_GREEN_STEPS6		-- green shack steps 6
location2:
	.byte	GEN_GENERATOR_DOOR	; north exit
	.byte	GEN_GREEN_STEPS3	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	green_steps6_n_lzsa	; north bg
	.word	green_steps6_w_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	$ff

; GEN_GENERATOR_DOOR		-- generator room door
location3:
	.byte	$ff			; north exit
	.byte	GEN_GREEN_STEPS6	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
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


; GEN_GENERATOR_ROOM		-- generator room
location4:
	.byte	$ff			; north exit
	.byte	GEN_GENERATOR_DOOR	; south exit
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

; GEN_TOWER1_TRAIL		-- tower1 trail
location5:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	GEN_TOWER1_TRAIL2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	tower1_trail_e_lzsa	; east bg
	.word	tower1_trail_w_lzsa	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	back_to_mist-1	; special function

; GEN_TOWER1_TRAIL2		-- tower1 trail2
location6:
	.byte	GEN_TOWER1_BOTTOM	; north exit
	.byte	GEN_TOWER1_TRAIL	; south exit
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

; GEN_TOWER1_BOTTOM		-- tower1 bottom
location7:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	GEN_TOWER1_TRAIL2	; east exit
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

; GEN_TOWER1_TOP		-- tower1 top
location8:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	GEN_TOWER1_BOTTOM	; east exit
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

; GEN_GREEN_STEPS3		-- green shack steps 3
location9:
	.byte	GEN_GREEN_STEPS6	; north exit
	.byte	GEN_GREEN_STEPS1	; south exit
	.byte	$ff			; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	green_steps3_n_lzsa	; north bg
	.word	green_steps3_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	$ff
