
;===============================================
; level data for Island level
;===============================================
; 24 bytes each location

LOCATION_NORTH_EXIT=0
LOCATION_SOUTH_EXIT=1
LOCATION_EAST_EXIT=2
LOCATION_WEST_EXIT=3
LOCATION_NORTH_EXIT_DIR=4
LOCATION_SOUTH_EXIT_DIR=5
LOCATION_EAST_EXIT_DIR=6
LOCATION_WEST_EXIT_DIR=7
LOCATION_SPECIAL_EXIT=8
LOCATION_NORTH_BG=9
LOCATION_SOUTH_BG=11
LOCATION_EAST_BG=13
LOCATION_WEST_BG=15
LOCATION_SPECIAL_X1=17
LOCATION_SPECIAL_X2=18
LOCATION_SPECIAL_Y1=19
LOCATION_SPECIAL_Y2=20
LOCATION_SPECIAL_FUNC=21
LOCATION_BGS	= 23
	BG_NORTH = 1
	BG_SOUTH = 2
	BG_EAST = 4
	BG_WEST = 8


locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20,location21,location22,location23
	.word location24,location25,location26,location27
	.word location28,location29

; myst linking book
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$00		; special exit
	.word	m_link_book_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	myst_link_book-1		; special function
	.byte	$1		; only north bg

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
	.byte	$ff		; special exit
	.word	dock_n_lzsa	; north bg
	.word	dock_s_lzsa	; south bg
	.word	dock_e_lzsa	; east bg
	.word	dock_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	$f		; all bgs

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
	.byte	$00		; special exit
	.word	dock_switch_n_lzsa	; north bg
	.word	dock_switch_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	23,30		; special x
	.byte	25,32		; special y
	.word	click_switch-1	; special function
	.byte	BG_NORTH|BG_SOUTH


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
	.byte	$ff		; special exit
	.word	gear_base_n_lzsa		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	dock_steps_w_lzsa		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST|BG_NORTH

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
	.byte	$ff		; special exit
	.word	above_dock_n_lzsa	; north bg
	.word	above_dock_s_lzsa	; south bg
	.word	above_dock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH|BG_NORTH|BG_EAST

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
	.byte	$ff		; special exit
	.word	step_base_n_lzsa	; north bg
	.word	step_base_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH|BG_NORTH

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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	step_land1_e_lzsa	; east bg
	.word	step_land1_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST	| BG_EAST

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
	.byte	$00		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	step_land2_e_lzsa	; east bg
	.word	step_land2_w_lzsa	; west bg
	.byte	29,32		; special x
	.byte	38,45		; special y
	.word	read_letter-1
	.byte	BG_WEST	| BG_EAST

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
	.byte	$ff		; special exit
	.word	step_dentist_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	step_dentist_e_lzsa	; east bg
	.word	step_dentist_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_EAST|BG_WEST|BG_NORTH

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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	step_land3_e_lzsa	; east bg
	.word	step_land3_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST	| BG_EAST	; west and eastl


; at the top outside temple
location10:
	.byte	11		; north exit
	.byte	14		; south exit
	.byte	9		; east exit
	.byte	16		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.byte	$ff		; special exit
	.word	step_top_n_lzsa	; north bg
	.word	step_top_s_lzsa	; south bg
	.word	step_top_e_lzsa	; east bg
	.word	step_top_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH	; all dirs

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
	.byte	$ff		; special exit
	.word	temple_door_n_lzsa	; north bg
	.word	temple_door_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_SOUTH	; north and south

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
	.byte	$ff		; special exit
	.word	temple_center_n_lzsa	; north bg
	.word	temple_center_s_lzsa	; south bg
	.word	temple_center_e_lzsa	; east bg
	.word	temple_center_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_WEST|BG_SOUTH|BG_EAST	; all directions

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
	.byte	$00		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	red_book_shelf_lzsa	; west bg
	.byte	16,25		; special x
	.byte	16,32		; special y
	.word	red_book-1	; special function
	.byte	BG_WEST		; west

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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	pool_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH

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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	clock_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH


; spaceship far
location16:
	.byte	22		; north exit
	.byte	$ff		; south exit
	.byte	10		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	spaceship_far_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	spaceship_far_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_EAST


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
	.byte	$00		; special exit
	.word	tree2_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	25,31		; special x
	.byte	19,23		; special y
	.word	click_switch-1	; special function
	.byte	BG_NORTH


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
	.byte	$ff		; special exit
	.word	tree5_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	tree5_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH | BG_EAST

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
	.byte	$00		; special exit
	.word	gear_n_lzsa	; north bg
	.word	gear_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	gear_w_lzsa	; west bg
	.byte	5,10		; special x
	.byte	29,35		; special y
	.word	click_switch-1	; special function
	.byte	BG_NORTH | BG_SOUTH | BG_WEST

; gear base
location20:
	.byte	19		; north exit
	.byte	$ff		; south exit
	.byte	3		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	gear_base_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	above_dock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH | BG_EAST

; dentist door
location21:
	.byte	21		; north exit
	.byte	9		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	dentist_door_n_lzsa	; north bg
	.word	dentist_door_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH | BG_SOUTH

; spaceship switch
location22:
	.byte	16		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	spaceship_switch_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH


; tree corridor4 (with generator switch)
location23:
	.byte	17		; north exit
	.byte	15		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	tree4_n_lzsa	; north bg
	.word	tree4_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	tree4_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_SOUTH|BG_WEST


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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tree_cabin_e_lzsa		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_EAST

; clock puzzle
location25:
	.byte	$ff		; north exit
	.byte	26		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	clock_puzzle_s_lzsa		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH

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
	.byte	$ff		; special exit
	.word	clock_island_n_lzsa		; north bg
	.word	clock_island_s_lzsa		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH|BG_NORTH

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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	clock_inside_s_lzsa		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH

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
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	fireplace_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_EAST

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
	.byte	$00		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	in_fireplace_w_lzsa		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; west
