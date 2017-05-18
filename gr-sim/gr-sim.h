extern unsigned char ram[128*1024];
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
int grsim_put_sprite(unsigned char *sprite_data, int xpos, int ypos);
int gr_copy(short source, short dest);
int text(void);
void basic_htab(int x);
void basic_vtab(int y);
void basic_print(char *string);
void basic_inverse(void);
void basic_normal(void);

#define APPLE_UP        11
#define APPLE_DOWN      10
#define APPLE_LEFT      8
#define APPLE_RIGHT     21

