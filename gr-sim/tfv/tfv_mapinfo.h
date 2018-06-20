/*	Map

	0         1          2        3

0     BEACH     ARCTIC   ARCTIC        BELAIR
                TREE    MOUNTAIN

1     BEACH     LANDING   GRASS      FOREST
      PINETREE            MOUNTAIN

2     BEACH     GRASS     GRASS       FOREST
      PALMTREE            MOUNTAIN

3     BEACH     DESERT    COLLEGE      BEACH
                CACTUS   PARK
*/


struct map_info_type map_info[33] = {
	{	// 0: NORTH_BEACH
		.name="North Beach",
		.n_exit=NOEXIT,
		.s_exit=PINE_BEACH,
		.e_exit=ARCTIC_WOODS,
		.w_exit=NOEXIT,
		.miny=4,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.land_type=LAND_LEFT_BEACH|LAND_NORTHSHORE,
		.scatter=SCATTER_NONE,
		.background_image=NULL,
	},
	{	// 1: ARCTIC_WOODS
		.name="Arctic Woods",
		.n_exit=NOEXIT,
		.s_exit=LANDING_SITE,
		.e_exit=ARCTIC_MOUNTAINS,
		.w_exit=NORTH_BEACH,
		.miny=4,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.land_type=LAND_GRASSLAND|LAND_NORTHSHORE,
		.scatter=SCATTER_SNOWYPINE,
		.scatter_x=10, .scatter_y=22, .scatter_cutoff=22,
		.background_image=NULL,
	},
	{	// 2: ARCTIC_MOUNTAINS
		.name="Arctic Mountains",
		.n_exit=NOEXIT,
		.s_exit=NORTH_MOUNTAIN,
		.e_exit=HARFORD_COUNTY,
		.w_exit=ARCTIC_WOODS,
		.miny=4,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.land_type=LAND_MOUNTAIN|LAND_NORTHSHORE,
		.scatter=SCATTER_NONE,
		.background_image=NULL,
	},
	{	// 3: HARFORD_COUNTY
		.name="Harford County",
		.n_exit=NOEXIT,
		.s_exit=NORTH_FOREST,
		.e_exit=NOEXIT,
		.w_exit=ARCTIC_MOUNTAINS,
		.miny=4,
		.ground_color=(COLOR_LIGHTBLUE|(COLOR_LIGHTBLUE<<4)),
		.land_type=LAND_LIGHTNING,
		.scatter=SCATTER_NONE,
		.background_image=harfco_rle,
	},
	{	// 4: PINE_BEACH
		.name="Pine Beach",
		.n_exit=NORTH_BEACH,
		.s_exit=PALM_BEACH,
		.e_exit=LANDING_SITE,
		.w_exit=NOEXIT,
		.miny=4,
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.scatter=SCATTER_PINE,
		.scatter_x=25, .scatter_y=16, .scatter_cutoff=15,
		.land_type=LAND_LEFT_BEACH,
		.background_image=NULL,
	},
	{	// 5: LANDING_SITE
		.name="Landing Site",
		.num_locations=1,
		// .locations
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=ARCTIC_WOODS,
		.s_exit=GRASSLAND,
		.e_exit=NORTH_MOUNTAIN,
		.w_exit=PINE_BEACH,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_GRASSLAND,
		.background_image=landing_rle,
	},
	{	// 6: NORTH_MOUNTAIN
		.name="North Mountain",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=ARCTIC_MOUNTAINS,
		.s_exit=MORIA,
		.e_exit=NORTH_FOREST,
		.w_exit=LANDING_SITE,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_MOUNTAIN,
		.background_image=NULL,
	},
	{	// 7: NORTH_FOREST
		.name="North Forest",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=HARFORD_COUNTY,
		.s_exit=SOUTH_FOREST,
		.e_exit=NOEXIT,
		.w_exit=NORTH_MOUNTAIN,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_FOREST|LAND_RIGHT_BEACH,
		.background_image=NULL,
	},
	{	// 8: PALM_BEACH
		.name="Palm Beach",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=PINE_BEACH,
		.s_exit=SOUTH_BEACH,
		.e_exit=GRASSLAND,
		.w_exit=NOEXIT,
		.miny=4,
		.scatter=SCATTER_PALM,
		.scatter_x=10, .scatter_y=20, .scatter_cutoff=22,
		.land_type=LAND_LEFT_BEACH,
		.background_image=NULL,
	},
	{	// 9: GRASSLAND
		.name="Grassland",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=LANDING_SITE,
		.s_exit=CACTUS_RANCH,
		.e_exit=MORIA,
		.w_exit=PALM_BEACH,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_GRASSLAND,
		.background_image=NULL,
	},
	{	// 10: MORIA
		.name="Khazad-dum",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=NORTH_MOUNTAIN,
		.s_exit=COLLEGE_PARK,
		.e_exit=SOUTH_FOREST,
		.w_exit=GRASSLAND,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_MOUNTAIN,
		.background_image=NULL,
	},
	{	// 11: SOUTH_FOREST
		.name="South Forest",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=NORTH_FOREST,
		.s_exit=OCEAN_CITY,
		.e_exit=NOEXIT,
		.w_exit=MORIA,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_FOREST|LAND_RIGHT_BEACH,
		.background_image=NULL,
	},
	{	// 12: SOUTH_BEACH
		.name="South Beach",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=PALM_BEACH,
		.s_exit=NOEXIT,
		.e_exit=CACTUS_RANCH,
		.w_exit=NOEXIT,
		.miny=4,
		.scatter=SCATTER_PALM,
		.scatter_x=20, .scatter_y=20, .scatter_cutoff=22,
		.land_type=LAND_LEFT_BEACH|LAND_SOUTHSHORE,
		.background_image=NULL,
	},
	{	// 13: CACTUS_RANCH
		.name="Cactus Ranch",
		.ground_color=(COLOR_ORANGE|(COLOR_ORANGE<<4)),
		.n_exit=GRASSLAND,
		.s_exit=NOEXIT,
		.e_exit=COLLEGE_PARK,
		.w_exit=SOUTH_BEACH,
		.miny=4,
		.scatter=SCATTER_CACTUS,
		.scatter_x=25, .scatter_y=16, .scatter_cutoff=15,
		.land_type=LAND_GRASSLAND|LAND_SOUTHSHORE,
		.background_image=NULL,
	},
	{	// 14: COLLEGE_PARK
		.name="College Park",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=MORIA,
		.s_exit=NOEXIT,
		.e_exit=OCEAN_CITY,
		.w_exit=CACTUS_RANCH,
		.miny=2,
		.scatter=SCATTER_NONE,
		.background_image=collegep_rle,
		.num_locations=2,
		.location[0] = {
			.name="University of M",
			.x0 = 12, .x1 = 18,
			.y0 = 0,  .y1 = 20,
			.destination = U_OF_MD,
		},
		.location[1] = {
			.name="Waterfall",
			.x0 = 27, .x1 = 39,
			.y0 = 18, .y1 = 33,
			.destination = WATERFALL,
		},
	},
	{	// 15: OCEAN_CITY
		.name="Ocean City",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=SOUTH_FOREST,
		.s_exit=NOEXIT,
		.e_exit=NOEXIT,
		.w_exit=COLLEGE_PARK,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_RIGHT_BEACH|LAND_SOUTHSHORE,
		.background_image=NULL,
	},
	{	// 16: U of MD
		.name="University of M",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=NOEXIT,
		.s_exit=NOEXIT,
		.e_exit=COLLEGE_PARK,
		.w_exit=COLLEGE_PARK,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_BORING,
		.background_image=umcp_rle,
		.num_locations=4,
		.location[0] = {
			.name="Talbot Hall",
			.x0 = 0,  .x1 = 10,
			.y0 = 18, .y1 = 31,
			.destination = TALBOT_HALL,
			.type=LOCATION_PLACE,
		},
		.location[1] = {
			.name="Dining Hall",
			.x0 = 13, .x1 = 26,
			.y0 = 10, .y1 = 24,
			.destination = DINING_HALL,
			.type=LOCATION_PLACE,
		},
		.location[2] = {
			.name="Metro Station",
			.x0 = 30, .x1 = 39,
			.y0 = 10, .y1 = 39,
			.destination = METRO_STATION,
			.type=LOCATION_PLACE,
		},
		.location[3] = {
			.name="Fountain",
			.x0 = 14, .x1 = 29,
			.y0 = 28, .y1 = 39,
			.destination = FOUNTAIN,
			.type=LOCATION_PLACE,
		},
	},
	{	// 17: Waterfall
		.name="Waterfall",
	},
	{	// 18: Talbot Hall
		.name="Talbot Hall",
		.ground_color=(COLOR_BLACK|(COLOR_BLACK<<4)),
		.n_exit=NOEXIT,
		.s_exit=NOEXIT,
		.e_exit=U_OF_MD,
		.w_exit=U_OF_MD,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_BORING,
		.background_image=talbot_rle,
		.num_locations=5,
		.location[0] = {
			.name="Liz and Will",
			.x0 = 8,  .x1 = 12,
			.y0 = 22, .y1 = 38,
			//.destination = TALBOT_HALL,
			.type=LOCATION_CONVERSATION,
		},
		.location[1] = {
			.name="Pete",
			.x0 = 13,  .x1 = 19,
			.y0 = 15, .y1 = 21,
			//.destination = TALBOT_HALL,
			.type=LOCATION_CONVERSATION,
		},
		.location[2] = {
			.name="Kenjesu",
			.x0 = 21,  .x1 = 26,
			.y0 = 19, .y1 = 28,
			//.destination = TALBOT_HALL,
			.type=LOCATION_CONVERSATION,
		},
		.location[3] = {
			.name="Mathemagician",
			.x0 = 28,  .x1 = 34,
			.y0 = 20, .y1 = 26,
			//.destination = TALBOT_HALL,
			.type=LOCATION_CONVERSATION,
		},
		.location[4] = {
			.name="Darth Tater",
			.x0 = 28,  .x1 = 36,
			.y0 = 26, .y1 = 38,
			//.destination = TALBOT_HALL,
			.type=LOCATION_CONVERSATION,
		},
	},
	{	// 19: Dining Hall
		.name="Dining Hall",
		.ground_color=(COLOR_BLACK|(COLOR_BLACK<<4)),
		.n_exit=NOEXIT,
		.s_exit=NOEXIT,
		.e_exit=U_OF_MD,
		.w_exit=U_OF_MD,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_BORING,
		.background_image=dining_rle,
	},
	{	// 20: METRO_STATION
		.name="Metro Station",
		.ground_color=(COLOR_BLACK|(COLOR_BLACK<<4)),
		.n_exit=NOEXIT,
		.s_exit=NOEXIT,
		.e_exit=U_OF_MD,
		.w_exit=U_OF_MD,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_BORING,
		.background_image=metro_rle,
	},
	{	// 21: FOUNTAIN
		.name="Fountain",
		.ground_color=(COLOR_BLACK|(COLOR_BLACK<<4)),
		.n_exit=NOEXIT,
		.s_exit=NOEXIT,
		.e_exit=U_OF_MD,
		.w_exit=U_OF_MD,
		.miny=4,
		.scatter=SCATTER_NONE,
		.land_type=LAND_BORING,
		//.background_image=metro_rle,
	},


};

#if 0

WORLDMAP_LOCATIONS
	COLLEGE_PARK
	HARFORD_COUNTY
	LANDING_SITE

	umcp_rle
		"TALBOT HALL",X1,Y1,X2,Y2,TALBOT_HALL,
		"SOUTH CAMPUS DINING",X1,Y1,X2,Y2,SOUTH_CAMPUS,
		"METRO STATION",X1,Y1,X2,Y2,METRO_STATION,
		"FOUNTAIN" -- drink from it restore heatlh?
			mermaid.  Did ye put bubbles in fountain?

	bel_air_rle
		"C. MILTON",
		"JOHN CARROLL",
		"SHOPPING MALL",
		"MINIGOLF",

	jc_rle:
		"VIDEO HOMEROOM"
		"AP CALCULUS, TEAM I-1"
		"DEUTSCH"
		"HOMEROOM"
		"MATH OFFICE"
		"PATRIOT ROOM"


	dining_rle
		"OSCAR",
		"NICOLE",
		"CINDY",
		"ELAINE",
		"CAFETERIA LADY",

	metro_rle:
		"METRO WORKER",
		"TINY CAPABARA",
		"GIANT GUINEA PIG",
		"LARGE BIRD",

	talbot_rle:
		"LIZ AND WILL",
		"PETE",
		"KENJESU",
		"MATHEMAGICIAN",
		"DARTH TATER",


	math_office_rle:
		"CAPTAIN STEVE",
		"BRIGHID",
		"RACHAEL YRBK",
		"MREE",

	video_hr_rle:
		"GUS",
		"RAISTLIN",
		"FORD",
		"SISTER SCARYNUN",

#endif


