extern unsigned char framebuffer[65536];

struct palette {
        unsigned char red[256];
        unsigned char green[256];
        unsigned char blue[256];
};

int mode13h_graphics_init(char *name, int scale);
int mode13h_graphics_update(void);
void set_default_pal(void);
int graphics_input(void);

void framebuffer_write_20bit(int address, int value);
void framebuffer_write(int address, int value);

void outp(short address, int value);
int inp(short addr);
