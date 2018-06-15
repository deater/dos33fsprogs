/* This is surprisngly similar to how I name cities in Civ4 */

#define NORTH_BEACH		0
#define ARCTIC_WOODS		1
#define ARCTIC_MOUNTAINS	2
#define HARFORD_COUNTY		3
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

#define U_OF_MD			16
#define WATERFALL		17
#define TALBOT_HALL		18
#define DINING_HALL		19
#define METRO_STATION		20
#define FOUNTAIN		21

#define BEL_AIR			22
#define C_MILTON		23
#define HARFORD_MALL		24
#define MINIGOLF		25
#define JOHN_CARROLL		26

#define VIDEO_HOMEROOM		27
#define AP_CALCULUS		28
#define DEUTSCH			29
#define HOMEROOM		30
#define MATH_OFFICE		31
#define PATRIOT_ROOM		32
#define MAIN_OFFICE		33

#define NOEXIT			255

struct location_type {
	char *name;
	int x0,x1,y0,y1;
	int type;
};

#define LAND_MOUNTAIN		0x01
#define LAND_GRASSLAND		0x02
#define LAND_FOREST		0x04
#define LAND_LEFT_BEACH		0x08
#define LAND_RIGHT_BEACH	0x10
#define LAND_NORTHSHORE		0x20
#define LAND_SOUTHSHORE		0x40


struct map_info_type {
	char *name;
	int land_type;
	int num_locations;
	struct location_type locations[6];
	int ground_color;
	int n_exit,s_exit,e_exit,w_exit;
	int miny;
	unsigned char *background_image;
};

extern struct map_info_type map_info[];

/* location */
extern unsigned char map_location;
extern char tfv_x,tfv_y;
extern unsigned char ground_color;

extern char nameo[9];


