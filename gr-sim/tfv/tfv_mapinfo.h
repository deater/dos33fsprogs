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


struct map_info_type map_info[16] = {
	{	// NORTH_BEACH
		.name="North Beach",
		.n_exit=NOEXIT,
		.s_exit=PINE_BEACH,
		.e_exit=ARCTIC_WOODS,
		.w_exit=NOEXIT,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.land_type=LAND_LEFT_BEACH|LAND_NORTHSHORE,
		.background_image=NULL,
	},
	{	// ARCTIC_WOODS
		.name="Arctic Woods",
		.n_exit=NOEXIT,
		.s_exit=LANDING_SITE,
		.e_exit=ARCTIC_MOUNTAINS,
		.w_exit=NORTH_BEACH,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.land_type=LAND_GRASSLAND|LAND_NORTHSHORE,
		.background_image=NULL,
	},
	{	// ARCTIC_MOUNTAINS
		.name="Arctic Mountains",
		.n_exit=NOEXIT,
		.s_exit=NORTH_MOUNTAIN,
		.e_exit=HARFORD_COUNTY,
		.w_exit=ARCTIC_WOODS,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.land_type=LAND_MOUNTAIN|LAND_NORTHSHORE,
		.background_image=NULL,
	},
	{	// HARFORD_COUNTY
		.name="Harford County",
		.n_exit=NOEXIT,
		.s_exit=NORTH_FOREST,
		.e_exit=NOEXIT,
		.w_exit=ARCTIC_MOUNTAINS,
		.ground_color=(COLOR_WHITE|(COLOR_WHITE<<4)),
		.background_image=harfco_rle,
	},
	{	// PINE_BEACH
		.name="Pine Beach",
		.n_exit=NORTH_BEACH,
		.s_exit=PALM_BEACH,
		.e_exit=LANDING_SITE,
		.w_exit=NOEXIT,
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_LEFT_BEACH,
		.background_image=NULL,
	},
	{	// LANDING_SITE
		.name="Landing Site",
		.num_locations=1,
		// .locations
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.n_exit=ARCTIC_WOODS,
		.s_exit=GRASSLAND,
		.e_exit=NORTH_MOUNTAIN,
		.w_exit=PINE_BEACH,
		.miny=0,
		.land_type=LAND_GRASSLAND,
		.background_image=landing_rle,
	},
	{
		.name="North Mountain",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_MOUNTAIN,
		.background_image=NULL,
	},
	{
		.name="North Forest",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_FOREST|LAND_RIGHT_BEACH,
		.background_image=NULL,
	},
	{
		.name="Palm Beach",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_LEFT_BEACH,
		.background_image=NULL,
	},
	{
		.name="Grassland",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_GRASSLAND,
		.background_image=NULL,
	},
	{
		.name="Moria",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_MOUNTAIN,
		.background_image=NULL,
	},
	{
		.name="South Forest",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_FOREST|LAND_RIGHT_BEACH,
		.background_image=NULL,
	},
	{
		.name="South Beach",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_LEFT_BEACH|LAND_SOUTHSHORE,
		.background_image=NULL,
	},
	{
		.name="Cactus Ranch",
		.ground_color=(COLOR_ORANGE|(COLOR_ORANGE<<4)),
		.land_type=LAND_GRASSLAND|LAND_SOUTHSHORE,
		.background_image=NULL,
	},
	{
		.name="College Park",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.background_image=collegep_rle,
	},
	{
		.name="Ocean City",
		.ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4)),
		.land_type=LAND_RIGHT_BEACH|LAND_SOUTHSHORE,
		.background_image=NULL,
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


