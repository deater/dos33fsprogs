extern unsigned char ram[128*1024];
int grsim_input(void);
int grsim_update(void);
int grsim_init(void);
int color_equals(int new_color);
int plot(unsigned char xcoord, unsigned char ycoord);
int hlin(int x1, int x2, int at);
int vlin(int y1, int y2, int at);
int gr(void);
int bload(char *filename, int address);
int scrn(unsigned char xcoord, unsigned char ycoord);
int grsim_unrle(unsigned char *rle_data, int address);
int home(void);

