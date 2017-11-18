extern unsigned char ram[128*1024];
extern unsigned char a,y,x;

int grsim_input(void);
int grsim_update(void);
int grsim_init(void);
int color_equals(int new_color);
int basic_plot(unsigned char xcoord, unsigned char ycoord);
int basic_hlin(int x1, int x2, int at);
int basic_vlin(int y1, int y2, int at);
int gr(void);
int bload(char *filename, int address);
int scrn(unsigned char xcoord, unsigned char ycoord);
int grsim_unrle(unsigned char *rle_data, int address);
int home(void);
int grsim_put_sprite_page(int page,unsigned char *sprite_data, int xpos, int ypos);
int grsim_put_sprite(unsigned char *sprite_data, int xpos, int ypos);
int gr_copy(short source, short dest);
int gr_copy_to_current(short source);
int text(void);
void basic_htab(int x);
void basic_vtab(int y);
void basic_print(char *string);
void basic_inverse(void);
void basic_normal(void);
int hlin(int page, int x1, int x2, int at);
int hlin_continue(int width);
int hlin_double_continue(int width);
int hlin_double(int page, int x1, int x2, int at);
void soft_switch(unsigned short address);
int soft_switch_read(unsigned short address);
int vlin(int y1, int y2, int at);
int collision(int xx, int yy, int ground_color);
void clear_top(int page);
void clear_bottom(int page);
void vtab(int ypos);
void htab(int xpos);
void move_cursor(void);
void move_and_print(char *string);
void print(char *string);
void print_both_pages(char *string);
void print_inverse(char *string);
int plot(unsigned char xcoord, unsigned char ycoord);

#define APPLE_UP        11
#define APPLE_DOWN      10
#define APPLE_LEFT      8
#define APPLE_RIGHT     21

#define COLOR_BLACK	0
#define COLOR_RED	1
#define COLOR_DARKBLUE	2
#define COLOR_PURPLE	3
#define COLOR_DARKGREEN	4
#define COLOR_GREY	5
#define COLOR_MEDIUMBLUE	6
#define COLOR_LIGHTBLUE	7
#define COLOR_BROWN	8
#define COLOR_ORANGE	9
#define COLOR_GREY2	10
#define COLOR_PINK	11
#define COLOR_LIGHTGREEN	12
#define COLOR_YELLOW	13
#define COLOR_AQUA	14
#define COLOR_WHITE	15

/* Soft Switches */
#define EIGHTYSTORE_OFF	0xc000	// page2 selects AUX ram
#define EIGHTYSTORE_ON	0xc001	// page2 selects MAIN ram
#define EIGHTYCOL_OFF	0xc00c	// Display 40 columns
#define EIGHTYCOLO_ON	0xc00d	// Display 80 columns
#define ALTCHAR_OFF	0xc00e	// Use primary charset
#define ALTCHAR_ON	0xc00f	// Use alternate charset
#define EIGHTYSTORE_RD	0xc018	// Read 80stor switch (R7)
#define TEXT_RD		0xc01a	// Read text switch (R7)
#define MIXED_RD	0xc01b	// Read mixed switch (R7)
#define PAGE2_RD	0xc01c	// Read Page2 (R7)
#define HIRES_RD	0xc01d	// Read HIRES (R7)
#define ALTCHAR_RD	0xc01e	// Read ALTCHAR switch (R7)
#define EIGHTYCOL_RD	0xc01f	// Read 80col switch (1==on) (R7)
#define TXTCLR		0xc050  // Display GR
#define TEXT_OFF	0xc050	// Display GR
#define TXTSET		0xc051	// Display Text
#define TEXT_ON		0xc051	// Display Text
#define MIXED_OFF	0xc052	// Mixed Text Off
#define MIXCLR		0xc052	// Mixed Text Off
#define MIXED_ON	0xc053	// Mixed Text On
#define MIXSET		0xc053	// Mixed Text On
#define PAGE2_OFF	0xc054	// Use Page 1
#define LOWSCR		0xc054	// Use Page 1
#define PAGE2_ON	0xc055	// Use Page 2
#define HISCR		0xc055	// Use Page 2
#define HIRES_OFF	0xc056	// lowres mode
#define LORES		0xc056	// lowres mode
#define HIRES_ON	0xc057	// hires mode
#define HIRES		0xc057	// hires mode
#define DHIRES_ON	0xc05e	// double-hires on
#define DHIRES_OFF	0xc05f	// double-hires off
#define DHIRES_RD	0xc07f	// double-hires read


#define PAGE0	0x0
#define PAGE1	0x4
#define PAGE2	0x8
