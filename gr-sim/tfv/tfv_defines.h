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
#define JOHN_CARROLL		23

#define JC_UPSTAIRS		24
#define JC_DOWNSTAIRS		25
#define JC_OFFICE		26

// UPSTAIRS
#define VIDEO_HOMEROOM		27
#define DEUTSCH			28
#define HOMEROOM		29

// DOWNSTAIRS
#define AP_CALCULUS		30
#define MATH_OFFICE		31
#define PATRIOT_ROOM		32

#define MIRROR_LAKE		33

#define NOEXIT			255

#define LOCATION_PLACE		0
#define LOCATION_CONVERSATION	1
#define LOCATION_SPACESHIP	2

struct location_type {
	char *name;
	int x0,x1,y0,y1;
	int enter_x,enter_y;
	int type;
	int destination;
};

#define LAND_BORING		0x00
#define LAND_MOUNTAIN		0x01
#define LAND_GRASSLAND		0x02
#define LAND_FOREST		0x04
#define LAND_LEFT_BEACH		0x08
#define LAND_RIGHT_BEACH	0x10
#define LAND_NORTHSHORE		0x20
#define LAND_SOUTHSHORE		0x40
#define LAND_LIGHTNING		0x80

#define SCATTER_NONE		0x00
#define SCATTER_SNOWYPINE	0x01
#define SCATTER_PINE		0x02
#define SCATTER_PALM		0x04
#define SCATTER_CACTUS		0x08
#define SCATTER_SPOOL		0x10

#define ENTRY_NORMAL		0x00
#define ENTRY_EXPLICIT		0x01
#define ENTRY_CENTER		0x02
#define ENTRY_R_OR_L		0x04
#define ENTRY_MINX		0x08
#define ENTRY_MAXX		0x10
#define ENTRY_MINY		0x20
#define ENTRY_MAXY		0x40

#define EXIT_NORMAL		0x00
#define EXIT_HIGH		0x01
#define EXIT_R_OR_L		0x02



struct map_info_type {
	char *name;
	int land_type;
	int num_locations;
	struct location_type location[5];
	int ground_color;
	int n_exit,s_exit,e_exit,w_exit;
	int miny;
	int scatter;
	int scatter_x,scatter_y,scatter_cutoff;
	int entry_type,entry_x,entry_y;
	int saved_x,saved_y;
	unsigned char *background_image;
};

extern struct map_info_type map_info[];

/* location */
extern unsigned char map_location;
extern char tfv_x,tfv_y;
extern unsigned char ground_color;

extern char nameo[9];


