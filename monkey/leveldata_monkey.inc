;===============================================
; level data for Monkey
;===============================================

locations:
	.word location0,location1,location2,location3
	.word location4,location5,location6,location7
	.word location8,location9,location10,location11


; MONKEY_LOOKOUT	-- lookout tower
location0:
	.word	lookout_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	3				; num areas

		.byte	12,15	; x
		.byte	18,28	; y
		.word	lookout_string		; name
		.word	lookout_action-1	; action

		.byte	32,40	; x
		.byte	0,20	; y
		.word	path_string		; name
		.word	path_action-1		; action

		.byte	28,36	; x
		.byte	32,40	; y
		.word	stairs_string		; name
		.word	stairs_action-1		; action

; MONKEY_POSTER		-- house with poster
location1:
	.word	poster_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	2				; num areas

		.byte	0,5	; x
		.byte	0,40	; y
		.word	cliffside_string	; name
		.word	cliffside_action-1	; action

		.byte	26,30	; x
		.byte	22,32	; y
		.word	poster_string		; name
		.word	poster_action-1		; action

; MONKEY_DOCK		-- dock
location2:
	.word	dock_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	12,16	; x
		.byte	0,4	; y
		.word	moon_string		; name
		.word	moon_action-1	; action

; MONKEY_BAR		-- scumm bar
location3:
	.word	bar_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action

; MONKEY_TOWN		-- downtown
location4:
	.word	town_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	8				; num areas

		.byte	33,38	; x
		.byte	14,26	; y
		.word	archway_string		; name
		.word	archway_action-1	; action

		.byte	29,30	; x
		.byte	20,28	; y
		.word	door_string		; name
		.word	town_door_action-1	; action

		.byte	19,23	; x
		.byte	20,30	; y
		.word	citizen_string		; name
		.word	citizen_action-1	; action

		.byte	10,11	; x
		.byte	16,22	; y
		.word	door_string		; name
		.word	town_door_action-1	; action

		.byte	7,8	; x
		.byte	16,22	; y
		.word	door_string		; name
		.word	town_door_action-1	; action

		.byte	4,5	; x
		.byte	16,20	; y
		.word	door_string		; name
		.word	town_door_action-1	; action

		.byte	0,3	; x
		.byte	14,20	; y
		.word	archway_string		; name
		.word	archway_action-1	; action

		.byte	0,3	; x
		.byte	5,10	; y
		.word	clock_string		; name
		.word	clock_action-1		; action


; MONKEY_MAP		-- melee map
location5:
	.word	map_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_TINY			; size
	.byte	7				; num areas

		.byte	32,33	; x
		.byte	20,22	; y
		.word	house_string		; name
		.word	map_action-1		; action

		.byte	24,27	; x
		.byte	26,30	; y
		.word	lights_string		; name
		.word	map_action-1		; action

		.byte	18,19	; x
		.byte	16,18	; y
		.word	clearing_string		; name
		.word	map_action-1		; action

		.byte	28,29	; x
		.byte	2,3	; y
		.word	island_string		; name
		.word	map_action-1		; action

		.byte	26,27	; x
		.byte	2,5	; y
		.word	shore_string		; name
		.word	map_action-1		; action

		.byte	12,13	; x
		.byte	22,23	; y
		.word	lookout_point_string	; name
		.word	map_action-1		; action

		.byte	10,13	; x
		.byte	24,28	; y
		.word	village_string	; name
		.word	map_action-1		; action
		

; MONKEY_BAR_INSIDE1	-- inside bar, lots going on
location6:
	.word	bar_inside1_lzsa		; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	4				; num areas

		.byte	0,3	; x
		.byte	12,34	; y
		.word	curtain_string		; name
		.word	curtain_action-1	; action

		.byte	7,20	; x
		.byte	22,32	; y
		.word	impt_pirate_string	; name
		.word	impt_pirate_action-1	; action

		.byte	23,28	; x
		.byte	20,28	; y
		.word	fireplace_string	; name
		.word	fireplace_action-1	; action

		.byte	34,38	; x
		.byte	18,36	; y
		.word	door_string		; name
		.word	bar2_door_action-1	; action


; MONKEY_BAR_INSIDE2	-- three pirates
location7:
	.word	bar_inside2_lzsa		; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	4				; num areas

		.byte	0,3	; x
		.byte	12,34	; y
		.word	curtain_string		; name
		.word	curtain_action-1	; action

		.byte	7,20	; x
		.byte	22,32	; y
		.word	impt_pirate_string	; name
		.word	impt_pirate_action-1	; action

		.byte	23,28	; x
		.byte	20,28	; y
		.word	fireplace_string	; name
		.word	fireplace_action-1	; action

		.byte	34,38	; x
		.byte	18,36	; y
		.word	door_string		; name
		.word	bar2_door_action-1	; action

; MONKEY_CHURCH		-- outside the church
location8:
	.word	church_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action

; MONKEY_MANSION_PATH		-- path to the mansion
location9:
	.word	mansion_path_lzsa		; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action

; MONKEY_MANSION	-- governor's mansion
location10:
	.word	mansion_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action

; MONKEY_ZIPLINE		-- hook's zipline
location11:
	.word	zipline_lzsa			; background
	.word	set_destination_lookout-1	; destination
	.word	check_exit_lookout-1		; exit
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action




string_data:
house_string:	.byte 18,20,"HOUSE",0
lights_string:	.byte 17,20,"LIGHTS",0
clearing_string:.byte 16,20,"CLEARING",0
island_string:	.byte 17,20,"ISLAND",0
shore_string:	.byte 18,20,"SHORE",0
lookout_point_string: .byte 13,20,"LOOKOUT POINT",0
village_string:	.byte 16,20,"VILLAGE",0


curtain_string:	.byte 20,20,"CURTAIN",0
impt_pirate_string:	.byte 20,20,"IMPORTANT PIRATES",0
fireplace_string:	.byte 20,20,"FIREPLACE",0

lookout_string:	.byte 20,20,"LOOKOUT",0
path_string:	.byte 20,20,"PATH",0
stairs_string:	.byte 20,20,"STAIRS",0

cliffside_string:	.byte 20,20,"CLIFFSIDE",0
poster_string:	.byte 20,20,"POSTER",0

moon_string:	.byte 20,20,"MOON",0

door_string:	.byte 20,20,"DOOR",0

archway_string:	.byte 20,20,"ARCHWAY",0
clock_string:	.byte 20,20,"CLOCK",0
citizen_string: .byte 20,20,"CITIZEN OF MELEE",0
