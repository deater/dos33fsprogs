
;===============================================
; level data for Island level
;===============================================
; 24 bytes each location
; we put special at end as it's ignored if not set

LOCATION_NORTH_EXIT=0			; new room when heading north
LOCATION_SOUTH_EXIT=1			; new room when heading south
LOCATION_EAST_EXIT=2			; new room when heading east
LOCATION_WEST_EXIT=3			; new room when heading west
LOCATION_NORTH_EXIT_DIR=4		; direction faced in new room when N
LOCATION_SOUTH_EXIT_DIR=5		; direction faced in new room when S
LOCATION_EAST_EXIT_DIR=6		; direction faced in new room when E
LOCATION_WEST_EXIT_DIR=7		; direction faced in new room when W
LOCATION_NORTH_BG=8			; pointer to north background image
LOCATION_SOUTH_BG=10			; pointer to south background image
LOCATION_EAST_BG=12			; pointer to east background image
LOCATION_WEST_BG=14			; pointer to west background image
LOCATION_BGS	= 16			; bitmap saying which backgrounds valid
	BG_NORTH = 1
	BG_SOUTH = 2
	BG_EAST = 4
	BG_WEST = 8
LOCATION_SPECIAL_EXIT=17		; if we have something clickable
					; $FF if not, direction if so
LOCATION_SPECIAL_X1=18			; collision box for the thing to click
LOCATION_SPECIAL_X2=19
LOCATION_SPECIAL_Y1=20
LOCATION_SPECIAL_Y2=21
LOCATION_SPECIAL_FUNC=22		; pointer-1 of function to call on click



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
	.word location36

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
	.word	m_link_book_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH	; only north bg
	.byte	DIRECTION_N	; special exit
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	mist_link_book-1		; special function


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
	.byte	16		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
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
	.byte	10		; east exit
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
	.byte	16		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
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
	.byte	32		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	tree4_n_lzsa	; north bg
	.word	tree4_s_lzsa	; south bg
	.word	tree4_e_lzsa	; east bg
	.word	tree4_w_lzsa	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_WEST|BG_EAST
	.byte	$ff		; special exit

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
	.word	exit_level-1	; special function

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
	.byte	DIRECTION_N|DIRECTION_SPLIT|DIRECTION_ONLY_POINT
	.byte	24,36		; special x
	.byte	34,40		; special y
	.word	generator_button_press-1	; special function








