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

/* Zero page addresses */
#define WNDLFT  0x20
#define WNDWDTH 0x21
#define WNDTOP  0x22
#define WNDBTM  0x23
#define CH      0x24
#define CV      0x25
#define GBASL   0x26
#define GBASH   0x27
#define BASL    0x28
#define BASH    0x29
#define BAS2L   0x2A
#define BAS2H   0x2B
#define H2      0x2C
#define V2      0x2D
#define MASK    0x2E
#define COLOR   0x30
#define INVFLG  0x32
#define YSAV    0x34
#define YSAV1   0x35
#define CSWL    0x36
#define CSWH    0x37



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

struct fixed_type {
        char i;
        unsigned char f;
};


int fixed_mul(struct fixed_type *x,
                struct fixed_type *y,
                struct fixed_type *z, int debug);

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

int city_map(void);

