/* Page Zero */

#define COLOR1	0x00
#define COLOR2	0x01
#define MATCH	0x02
#define XX	0x03
#define YY	0x04
#define YADD	0x05
#define LOOP	0x06
#define MEMPTRL	0x07
#define MEMPTRH	0x08
#define DISP_PAGE	0x09
#define DRAW_PAGE	0x0a
#define TEMPY		0xfb
#define OUTL		0xfe
#define OUTH		0xff

/* stats */
extern unsigned char level;
extern unsigned char hp,max_hp;
extern unsigned char limit;
extern unsigned char money,experience;
extern unsigned char time_hours,time_minutes;
extern unsigned char items1,items2;
extern unsigned char steps;

/* location */
extern unsigned char map_x;
extern char tfv_x,tfv_y;
extern unsigned char ground_color;

extern char nameo[9];


int opening(void);
int title(void);
int flying(void);

void game_over(void);
void show_map(void);
void print_info(void);
void print_help(void);

int name_screen(void);

int do_battle(void);

int world_map(void);
