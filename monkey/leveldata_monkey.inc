;===============================================
; level data for Monkey
;===============================================

locations:
	.word location0,location1,location2,location3
	.word location4,location5,location6,location7
	.word location8,location9,location10,location11
	.word location12,location13,location14

; MONKEY_LOOKOUT	-- lookout tower
location0:
	.word	lookout_lzsa			; background
	.word	lookout_adjust_destination	; destination
	.word	lookout_check_exit		; exit
	.word	lookout_check_bounds		; bounds check
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
	.word	poster_adjust_destination	; destination
	.word	poster_check_exit		; exit
	.word	poster_check_bounds		; bounds check
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
	.word	dock_adjust_destination		; destination
	.word	dock_check_exit			; exit
	.word	dock_check_bounds		; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	12,16	; x
		.byte	0,4	; y
		.word	moon_string		; name
		.word	moon_action-1	; action

; MONKEY_BAR		-- scumm bar
location3:
	.word	bar_lzsa			; background
	.word	bar_adjust_destination		; destination
	.word	bar_check_exit			; exit
	.word	bar_keep_in_bounds		; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	2				; num areas

		.byte	9,14	; x
		.byte	20,32	; y
		.word	door_string		; name
		.word	door_action-1		; action

		.byte	36,40	; x
		.byte	14,34	; y
		.word	archway_string		; name
		.word	archway_action-1	; action


; MONKEY_TOWN		-- downtown
location4:
	.word	town_lzsa			; background
	.word	town_adjust_destination		; destination
	.word	town_check_exit			; exit
	.word	town_check_bounds		; bounds check
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
	.word	map_adjust_destination		; destination
	.word	map_check_exit			; exit
	.word	map_check_bounds		; bounds check
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
	.word	bar_inside1_adjust_destination	; destination
	.word	bar_inside1_check_exit		; exit
	.word	bar_inside1_check_bounds	; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	7				; num areas

		.byte	0,10	; x
		.byte	34,40	; y
		.word	pirate_string		; name
		.word	bar1_pirate_action-1	; action

		.byte	4,9	; x
		.byte	16,32	; y
		.word	door_string		; name
		.word	bar1_door_action-1	; action

		.byte	10,15	; x
		.byte	22,32	; y
		.word	pirate_string		; name
		.word	bar1_pirate_action-1	; action

		.byte	16,20	; x
		.byte	22,34	; y
		.word	pirates_string		; name
		.word	bar1_pirate_action-1	; action

		.byte	21,35	; x
		.byte	22,38	; y
		.word	pirate_string		; name
		.word	bar1_pirate_action-1	; action

		.byte	37,40	; x
		.byte	14,30	; y
		.word	curtain_string		; name
		.word	curtain_action-1	; action

		.byte	35,40	; x
		.byte	30,38	; y
		.word	dog_string		; name
		.word	bar1_dog_action-1	; action




; MONKEY_BAR_INSIDE2	-- three pirates
location7:
	.word	bar_inside2_lzsa		; background
	.word	bar_inside2_adjust_destination	; destination
	.word	bar_inside2_check_exit		; exit
	.word	bar_inside2_check_bounds	; bounds check
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
	.word	church_adjust_destination	; destination
	.word	church_check_exit		; exit
	.word	church_check_bounds		; bounds check
	.byte	GUYBRUSH_SMALL			; size
	.byte	4				; num areas

		.byte	6,10	; x
		.byte	20,28	; y
		.word	door_string		; name
		.word	church_door_action-1	; action

		.byte	14,18	; x
		.byte	20,30	; y
		.word	alley_string		; name
		.word	alley_action-1		; action

		.byte	22,25	; x
		.byte	26,34	; y
		.word	door_string		; name
		.word	church_door_action-1	; action

		.byte	34,38	; x
		.byte	16,34	; y
		.word	archway_string		; name
		.word	archway_action-1	; action


; MONKEY_MANSION_PATH		-- path to the mansion
location9:
	.word	mansion_path_lzsa		; background
	.word	mansion_path_adjust_destination	; destination
	.word	mansion_path_check_exit		; exit
	.word	mansion_path_check_bounds	; bounds check
	.byte	GUYBRUSH_SMALL			; size
	.byte	3				; num areas

		.byte	0,11	; x
		.byte	0,12	; y
		.word	mansion_string		; name
		.word	mansion_action-1	; action

		.byte	9,11	; x
		.byte	12,13	; y
		.word	poodles_string		; name
		.word	poodles_action-1	; action

		.byte	32,40	; x
		.byte	12,40	; y
		.word	town_string		; name
		.word	town_action-1		; action


; MONKEY_MANSION	-- governor's mansion
location10:
	.word	mansion_lzsa			; background
	.word	mansion_adjust_destination	; destination
	.word	mansion_check_exit		; exit
	.word	mansion_check_bounds		; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	2				; num areas

		.byte	37,40	; x
		.byte	10,38	; y
		.word	trail_string		; name
		.word	trail_action-1		; action

		.byte	5,15	; x
		.byte	30,38	; y
		.word	poodles_string		; name
		.word	poodles_action-1	; action


; MONKEY_ZIPLINE		-- hook's zipline
location11:
	.word	zipline_lzsa			; background
	.word	zipline_adjust_destination	; destination
	.word	zipline_check_exit		; exit
	.word	zipline_check_bounds		; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	3				; num areas

		.byte	30,36	; x
		.byte	10,36	; y
		.word	pole_string		; name
		.word	pole_action-1		; action

		.byte	19,30	; x
		.byte	4,16	; y
		.word	cable_string		; name
		.word	cable_action-1		; action

		.byte	0,15	; x
		.byte	4,28	; y
		.word	sign_string		; name
		.word	sign_action-1		; action

; MONKEY_VOODOO1		-- voodoo shop
location12:
	.word	voodoo1_lzsa			; background
	.word	voodoo1_adjust_destination	; destination
	.word	voodoo1_check_exit		; exit
	.word	voodoo1_check_bounds		; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	12				; num areas

		.byte	11,17	; x
		.byte	12,26	; y
		.word	door_string		; name
		.word	voodoo1_door_action-1		; action

		.byte	24,33	; x
		.byte	20,26	; y
		.word	couch_string		; name
		.word	couch_action-1		; action

		.byte	28,33	; x
		.byte	10,18	; y
		.word	chickens_string		; name
		.word	chickens_action-1	; action

		.byte	22,27	; x
		.byte	10,20	; y
		.word	voodoo_knicknacks_string	; name
		.word	voodoo_knicknacks_action-1	; action

		.byte	20,23	; x
		.byte	16,28	; y
		.word	statue_string	; name
		.word	statue_action-1	; action

		.byte	7,14	; x
		.byte	10,20	; y
		.word	chickens_string		; name
		.word	chickens_action-1	; action

		.byte	12,20	; x
		.byte	30,40	; y
		.word	baskets_string		; name
		.word	baskets_action-1	; action

		.byte	22,25	; x
		.byte	30,38	; y
		.word	basket_string		; name
		.word	basket_action-1	; action

		.byte	34,37	; x
		.byte	32,36	; y
		.word	bones_string		; name
		.word	bones_action-1		; action

		.byte	38,40	; x
		.byte	32,36	; y
		.word	chalice_string		; name
		.word	chalice_action-1	; action

		.byte	29,39	; x
		.byte	36,40	; y
		.word	trunk_string		; name
		.word	trunk_action-1		; action

		.byte	31,33	; x
		.byte	30,36	; y
		.word	chicken_string		; name
		.word	chicken_pulley_action-1	; action

; MONKEY_VOODOO2		-- voodoo lady
location13:
	.word	voodoo2_lzsa			; background
	.word	voodoo2_adjust_destination	; destination
	.word	voodoo2_check_exit		; exit
	.word	voodoo2_check_bounds		; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	1				; num areas

		.byte	21,27	; x
		.byte	14,26	; y
		.word	voodoo_lady_string	; name
		.word	voodoo_lady_action-1	; action


; MONKEY_BAR_INSIDE3	-- kitchen
location14:
	.word	bar_inside3_lzsa		; background
	.word	bar_inside3_adjust_destination	; destination
	.word	bar_inside3_check_exit		; exit
	.word	bar_inside3_check_bounds	; bounds check
	.byte	GUYBRUSH_BIG			; size
	.byte	6				; num areas

		.byte	3,7	; x
		.byte	20,30	; y
		.word	door_string		; name
		.word	bar3_door_action-1	; action

		.byte	1,5	; x
		.byte	32,40	; y
		.word	barrel_string		; name
		.word	barrel_action-1		; action

		.byte	15,20	; x
		.byte	32,40	; y
		.word	table_string		; name
		.word	table_action-1		; action

		.byte	21,23	; x
		.byte	24,28	; y
		.word	stew_string		; name
		.word	stew_action-1		; action

		.byte	24,27	; x
		.byte	20,36	; y
		.word	door_string		; name
		.word	bar3_door_action-1	; action

		.byte	10,14	; x
		.byte	26,30	; y
		.word	meat_string		; name
		.word	meat_action-1	; action


; common strings

door_string:	.byte "DOOR",0
pirate_string:	.byte "PIRATE",0
pirates_string:	.byte "PIRATES",0

; bar3 strings
stew_string:	.byte "POT O' STEW",0
table_string:	.byte "TABLE",0
barrel_string:	.byte "BARREL",0
meat_string:	.byte "HUNK OF MEAT",0

; voodoo1 strings
couch_string:	.byte "COUCH",0
chicken_string:	.byte "CHICKEN",0
chickens_string:.byte "CHICKENS",0
statue_string:	.byte "STATUE",0
basket_string:	.byte "BASKET",0
baskets_string:	.byte "BASKETS",0
bones_string:	.byte "BONES",0
chalice_string:	.byte "CHALICE",0
trunk_string:	.byte "TRUNK",0
voodoo_knicknacks_string:.byte "VOODOO KNICKNACKS",0
chicken_pulley_string:	.byte "CHICKEN PULLEY",0
null_string:	.byte "NULL",0

; voodoo2 strings
voodoo_lady_string:	.byte "VOODOO LADY",0

; church strings
alley_string:	.byte "ALLEY",0

; mansion path strings
mansion_string:	.byte "GOVERNOR'S MANSION",0
town_string:	.byte "TOWN",0

; mansion strings
poodles_string:	.byte "PIRANHA POODLES",0
trail_string:	.byte "TRAIL",0

; zipline strings
pole_string:	.byte "POLE",0
cable_string:	.byte "CABLE",0
sign_string:	.byte "SIGN",0

; bar strings

; lookout strings

lookout_string:	.byte "LOOKOUT",0
path_string:	.byte "PATH",0
stairs_string:	.byte "STAIRS",0

; map strings

house_string:	.byte 18,20,"HOUSE",0
lights_string:	.byte 17,20,"LIGHTS",0
clearing_string:.byte 16,20,"CLEARING",0
island_string:	.byte 17,20,"ISLAND",0
shore_string:	.byte 18,20,"SHORE",0
lookout_point_string: .byte 13,20,"LOOKOUT POINT",0
village_string:	.byte 16,20,"VILLAGE",0

; inside_bar2 strings
dog_string:	.byte "DOG",0

; inside_bar2 strings

curtain_string:	.byte "CURTAIN",0
impt_pirate_string:	.byte "IMPORTANT PIRATES",0
fireplace_string:	.byte "FIREPLACE",0

; poster strings

cliffside_string:	.byte "CLIFFSIDE",0
poster_string:		.byte "POSTER",0

; dock strings

moon_string:	.byte "MOON",0

; town strings

archway_string:	.byte "ARCHWAY",0
clock_string:	.byte "CLOCK",0
citizen_string: .byte "CITIZEN OF MELEE",0
