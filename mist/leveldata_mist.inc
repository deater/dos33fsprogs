
;===============================================
; level data for Mist Island level
;===============================================

locations:
	.word location1, location1, location2, location3
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
	.word location44,location45,location46

; myst linking book
;location0:
;	.byte	$ff		; north exit
;	.byte	$ff		; south exit
;	.byte	$ff		; east exit
;	.byte	$ff		; west exit
;	.byte	$ff		; north exit_dir
;	.byte	$ff		; south exit_dir
;	.byte	$ff		; east exit_dir
;	.byte	$ff		; west exit_dir
;	.word	m_link_book_lzsa	; north bg
;	.word	$0000		; south bg
;	.word	$0000		; east bg
;	.word	$0000		; west bg
;	.byte	BG_NORTH	; only north bg
;	.byte	DIRECTION_N	; special exit
;	.byte	21,31		; special x
;	.byte	10,24		; special y
;	.word	mist_link_book-1		; special function


; dock
location1:
	.byte	$2		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dock_n_lzsa	; north bg
	.word	dock_s_lzsa	; south bg
	.word	dock_e_lzsa	; east bg
	.word	dock_w_lzsa	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	$ff		; special exit

; by dock switch
location2:
	.byte	3		; north exit
	.byte	1		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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



; dock steps
location3:
	.byte	19		; north exit
	.byte	$ff		; south exit
	.byte	2		; east exit
	.byte	4		; west exit
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



; above dock path
location4:
	.byte	20		; north exit
	.byte	5		; south exit
	.byte	2		; east exit
	.byte	$ff		; west exit
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

; base of steps
location5:
	.byte	4		; north exit
	.byte	6		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; steps 1st landing
location6:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	5		; east exit
	.byte	7		; west exit
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

; steps 2nd landing
location7:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	6		; east exit
	.byte	8		; west exit
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


; steps outside dentist chair branch
location8:
	.byte	21		; north exit
	.byte	$ff		; south exit
	.byte	7		; east exit
	.byte	9		; west exit
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

; steps one more time up
location9:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	8		; east exit
	.byte	10		; west exit
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

; at the top outside temple
location10:
	.byte	11		; north exit
	.byte	14		; south exit
	.byte	9		; east exit
	.byte	37		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N|DIRECTION_ONLY_POINT	; west exit_dir
	.word	step_top_n_lzsa	; north bg
	.word	step_top_s_lzsa	; south bg
	.word	step_top_e_lzsa	; east bg
	.word	step_top_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH	; all dirs
	.byte	$ff		; special exit

; temple doorway
location11:
	.byte	12		; north exit
	.byte	10		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	temple_door_n_lzsa	; north bg
	.word	temple_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH	; north and south
	.byte	$ff		; special exit

; temple inside
location12:
	.byte	$ff		; north exit
	.byte	11		; south exit
	.byte	28		; east exit
	.byte	13		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	temple_center_n_lzsa	; north bg
	.word	temple_center_s_lzsa	; south bg
	.word	temple_center_e_lzsa	; east bg
	.word	temple_center_w_lzsa	; west bg
	.byte	BG_NORTH|BG_WEST|BG_SOUTH|BG_EAST	; all directions
	.byte	$ff		; special exit

; red book shelf
location13:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	12		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	red_book_shelf_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	DIRECTION_N	; special exit
	.byte	16,25		; special x
	.byte	16,32		; special y
	.word	red_book-1	; special function


; pool
location14:
	.byte	$ff		; north exit
	.byte	23		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; clock
location15:
	.byte	$ff		; north exit
	.byte	25		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	clock_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$ff		; special exit

; spaceship far
location16:
	.byte	22		; north exit
	.byte	$ff		; south exit
	.byte	37		; east exit
	.byte	$ff		; west exit
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

; tree corridor #2
location17:
	.byte	10		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
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

; tree corridor #5
location18:
	.byte	23		; north exit
	.byte	$ff		; south exit
	.byte	24		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tree5_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	tree5_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH | BG_EAST
	.byte	$ff		; special exit

; gear
location19:
	.byte	$ff		; north exit
	.byte	4		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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


; gear base
location20:
	.byte	19		; north exit
	.byte	$ff		; south exit
	.byte	2		; east exit
	.byte	$ff		; west exit
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

; dentist door
location21:
	.byte	31		; north exit
	.byte	9		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; spaceship switch
location22:
	.byte	38		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; tree corridor4 (with generator switch)
location23:
	.byte	17		; north exit
	.byte	15		; south exit
	.byte	$ff		; east exit
	.byte	43		; west exit
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

; tree cabin
location24:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	18		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	tree_cabin_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; clock puzzle
location25:
	.byte	$ff		; north exit
	.byte	18		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	clock_puzzle_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	12,30		; special x
	.byte	38,48		; special y
	.word	clock_puzzle-1	; special function

; clock island
location26:
	.byte	18		; north exit
	.byte	27		; south exit
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

; clock inside
location27:
	.byte	$ff		; north exit
	.byte	26		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; fireplace
location28:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	29		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	fireplace_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

; in fireplace
location29:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	12		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	in_fireplace_w_lzsa	; west bg
	.byte	BG_WEST		; west
	.byte	$ff		; special exit

; open_gear
location30:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	19		; east exit
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

; chair view
location31:
	.byte	31		; north exit
	.byte	21		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; green shack
location32:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	23		; east exit
	.byte	33		; west exit
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

; green shack steps 1
location33:
	.byte	34		; north exit
	.byte	32		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; green shack steps 6
location34:
	.byte	35		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	33		; west exit
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

; generator room door
location35:
	.byte	35		; north exit
	.byte	34		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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


; generator room
location36:
	.byte	36		; north exit
	.byte	35		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_S	; north exit_dir
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

; pad on way to rocket
location37:
	.byte	16		; north exit
	.byte	$ff		; south exit
	.byte	10		; east exit
	.byte	$ff		; west exit
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

; rocket close in
location38:
	.byte	16		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; ceiling of temple
location39:
	.byte	12		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	temple_center_up_lzsa	; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; tower2 path
location40:
	.byte	41		; north exit
	.byte	$ff		; south exit
	.byte	37		; east exit
	.byte	$ff		; west exit
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

; tower2 base
location41:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	40		; west exit
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

; tower2 top
location42:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	41		; west exit
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

; tower1 trail
location43:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	23		; east exit
	.byte	44		; west exit
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

; tower1 trail2
location44:
	.byte	45		; north exit
	.byte	43		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
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

; tower1 bottom
location45:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	44		; east exit
	.byte	$ff		; west exit
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


; tower1 top
location46:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	45		; east exit
	.byte	$ff		; west exit
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


