/*
	Map

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

/* This is surprisngly similar to how I name citties in Civ4 */

#define NORTH_BEACH		0
#define ARCTIC_WOODS		1
#define ARCTIC_MOUNTAINS	2
#define BEL_AIR			3
#define PINE_BEACH		4
#define LANDING_SITE		5
#define NORTH_MOUNTAIN		6
#define NORTH_FOREST		7
#define PALM_BEACH		8
#define GRASSLAND		9
#define MORIA			10
#define SOUTH_FOREST		11
#define SOUTH_BEACH		12
#define CACTUS_RANCH		13
#define COLLEGE_PARK		14
#define OCEAN_CITY		15
#define NOEXIT			255

struct location_type {
	char *name;
	int x0,x1,y0,y1;
	int type;
};

struct map_info_type {
	char *name;
	int num_locations;
	struct location_type locations[6];
	int floor_color;
	int n_exit,s_exit,e_exit,w_exit;
	int miny;
} map_info[16] = {
	{
		.name="North Beach",
		.n_exit=NOEXIT;
		.s_exit=PINE_BEACH;
		.e_exit=NOEXIT;
		.w_exit=ARTIC_WOODS:
	},
	{
		.name="Arctic Woods",
	},
	{
		.name="Arctic Mountains",
	},
	{
		.name="Bel Air",
	},
	{
		.name="Pine Beach",
	},
	{
		.name="Landing Site",
	},
	{
		.name="North Mountain",
	},
	{
		.name="North Forest",
	},
	{
		.name="Palm Beach",
	},
	{
		.name="Grassland",
	},
	{
		.name="Moria",
	},
	{
		.name="South Forest",
	},
	{
		.name="South Beach",
	},
	{
		.name="Cactus Ranch",
	},
	{
		.name="Ocean City",
	},

};
