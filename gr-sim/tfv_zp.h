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

int opening(void);

