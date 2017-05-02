extern unsigned char ram[128*1024];
int grsim_input(void);
int grsim_update(void);
int grsim_init(void);
int color_equals(int new_color);
int plot(int x, int y);
int hlin(int x1, int x2, int at);
int vlin(int y1, int y2, int at);
int gr(void);
