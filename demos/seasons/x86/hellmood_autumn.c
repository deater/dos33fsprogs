/* A Linux/SDL/C version of Hellmood's Autumn */

/* deater -- Vince Weaver -- vince@deater.net -- 5 May 2020 */

#define APPLEII	1

#include <stdio.h>
#include <unistd.h>

#include <SDL.h>

static unsigned short stack[128];
static unsigned short ax,bx,cx,dx,di,es;
static unsigned char ah,al;
static unsigned int ebp;
static int cf=0,newcf=0;
static int sp=0;
static unsigned char framebuffer[320*200];

static SDL_Surface *sdl_screen=NULL;

struct palette {
        unsigned char red[256];
        unsigned char green[256];
        unsigned char blue[256];
};

static struct palette pal;

static int mode13h_graphics_init(void) {

	int mode;

	mode=SDL_SWSURFACE|SDL_HWPALETTE|SDL_HWSURFACE;

	if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) {
		fprintf(stderr,
			"Couldn't initialize SDL: %s\n", SDL_GetError());
		return -1;
	}

	/* Clean up on exit */
	atexit(SDL_Quit);

	/* assume 32-bit color */
	sdl_screen = SDL_SetVideoMode(320, 200, 32, mode);

	if ( sdl_screen == NULL ) {
		fprintf(stderr, "ERROR!  Couldn't set 320x200 video mode: %s\n",
			SDL_GetError());
		return -1;
	}
	SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);

	SDL_WM_SetCaption("memories -- Linux/C/SDL","memories");

	return 0;
}

static int mode13h_graphics_update(unsigned char *buffer, struct palette *pal) {

        unsigned int *t_pointer;

        int x,temp;

        /* point to SDL output pixels */
        t_pointer=((Uint32 *)sdl_screen->pixels);

        for(x=0;x<320*200;x++) {

                temp=(pal->red[buffer[x]]<<16)|
                        (pal->green[buffer[x]]<<8)|
                        (pal->blue[buffer[x]]<<0)|0;

                t_pointer[x]=temp;
        }

        SDL_UpdateRect(sdl_screen, 0, 0, 320, 200);

        return 0;
}

static void set_vga_pal(void) {

/* output of vgapal https://github.com/canidlogic/vgapal */
unsigned char raw_pal[3*256]=
{ 0,   0,   0,    0,   0, 170,    0, 170,   0,    0, 170, 170,
170,   0,   0,  170,   0, 170,  170,  85,   0,  170, 170, 170,
 85,  85,  85,   85,  85, 255,   85, 255,  85,   85, 255, 255,
255,  85,  85,  255,  85, 255,  255, 255,  85,  255, 255, 255,
  0,   0,   0,   20,  20,  20,   32,  32,  32,   44,  44,  44,
 56,  56,  56,   69,  69,  69,   81,  81,  81,   97,  97,  97,
113, 113, 113,  130, 130, 130,  146, 146, 146,  162, 162, 162,
182, 182, 182,  203, 203, 203,  227, 227, 227,  255, 255, 255,
  0,   0, 255,   65,   0, 255,  125,   0, 255,  190,   0, 255,
255,   0, 255,  255,   0, 190,  255,   0, 125,  255,   0,  65,
255,   0,   0,  255,  65,   0,  255, 125,   0,  255, 190,   0,
255, 255,   0,  190, 255,   0,  125, 255,   0,   65, 255,   0,
  0, 255,   0,    0, 255,  65,    0, 255, 125,    0, 255, 190,
  0, 255, 255,    0, 190, 255,    0, 125, 255,    0,  65, 255,
125, 125, 255,  158, 125, 255,  190, 125, 255,  223, 125, 255,
255, 125, 255,  255, 125, 223,  255, 125, 190,  255, 125, 158,
255, 125, 125,  255, 158, 125,  255, 190, 125,  255, 223, 125,
255, 255, 125,  223, 255, 125,  190, 255, 125,  158, 255, 125,
125, 255, 125,  125, 255, 158,  125, 255, 190,  125, 255, 223,
125, 255, 255,  125, 223, 255,  125, 190, 255,  125, 158, 255,
182, 182, 255,  199, 182, 255,  219, 182, 255,  235, 182, 255,
255, 182, 255,  255, 182, 235,  255, 182, 219,  255, 182, 199,
255, 182, 182,  255, 199, 182,  255, 219, 182,  255, 235, 182,
255, 255, 182,  235, 255, 182,  219, 255, 182,  199, 255, 182,
182, 255, 182,  182, 255, 199,  182, 255, 219,  182, 255, 235,
182, 255, 255,  182, 235, 255,  182, 219, 255,  182, 199, 255,
  0,   0, 113,   28,   0, 113,   56,   0, 113,   85,   0, 113,
113,   0, 113,  113,   0,  85,  113,   0,  56,  113,   0,  28,
113,   0,   0,  113,  28,   0,  113,  56,   0,  113,  85,   0,
113, 113,   0,   85, 113,   0,   56, 113,   0,   28, 113,   0,
  0, 113,   0,    0, 113,  28,    0, 113,  56,    0, 113,  85,
  0, 113, 113,    0,  85, 113,    0,  56, 113,    0,  28, 113,
 56,  56, 113,   69,  56, 113,   85,  56, 113,   97,  56, 113,
113,  56, 113,  113,  56,  97,  113,  56,  85,  113,  56,  69,
113,  56,  56,  113,  69,  56,  113,  85,  56,  113,  97,  56,
113, 113,  56,   97, 113,  56,   85, 113,  56,   69, 113,  56,
 56, 113,  56,   56, 113,  69,   56, 113,  85,   56, 113,  97,
 56, 113, 113,   56,  97, 113,   56,  85, 113,   56,  69, 113,
 81,  81, 113,   89,  81, 113,   97,  81, 113,  105,  81, 113,
113,  81, 113,  113,  81, 105,  113,  81,  97,  113,  81,  89,
113,  81,  81,  113,  89,  81,  113,  97,  81,  113, 105,  81,
113, 113,  81,  105, 113,  81,   97, 113,  81,   89, 113,  81,
 81, 113,  81,   81, 113,  89,   81, 113,  97,   81, 113, 105,
 81, 113, 113,   81, 105, 113,   81,  97, 113,   81,  89, 113,
  0,   0,  65,   16,   0,  65,   32,   0,  65,   48,   0,  65,
 65,   0,  65,   65,   0,  48,   65,   0,  32,   65,   0,  16,
 65,   0,   0,   65,  16,   0,   65,  32,   0,   65,  48,   0,
 65,  65,   0,   48,  65,   0,   32,  65,   0,   16,  65,   0,
  0,  65,   0,    0,  65,  16,    0,  65,  32,    0,  65,  48,
  0,  65,  65,    0,  48,  65,    0,  32,  65,    0,  16,  65,
 32,  32,  65,   40,  32,  65,   48,  32,  65,   56,  32,  65,
 65,  32,  65,   65,  32,  56,   65,  32,  48,   65,  32,  40,
 65,  32,  32,   65,  40,  32,   65,  48,  32,   65,  56,  32,
 65,  65,  32,   56,  65,  32,   48,  65,  32,   40,  65,  32,
 32,  65,  32,   32,  65,  40,   32,  65,  48,   32,  65,  56,
 32,  65,  65,   32,  56,  65,   32,  48,  65,   32,  40,  65,
 44,  44,  65,   48,  44,  65,   52,  44,  65,   60,  44,  65,
 65,  44,  65,   65,  44,  60,   65,  44,  52,   65,  44,  48,
 65,  44,  44,   65,  48,  44,   65,  52,  44,   65,  60,  44,
 65,  65,  44,   60,  65,  44,   52,  65,  44,   48,  65,  44,
 44,  65,  44,   44,  65,  48,   44,  65,  52,   44,  65,  60,
 44,  65,  65,   44,  60,  65,   44,  52,  65,   44,  48,  65,
  0,   0,   0,    0,   0,   0,    0,   0,   0,    0,   0,   0,
  0,   0,   0,    0,   0,   0,    0,   0,   0,    0,   0,   0
};

	int i;

	for(i=0;i<256;i++) {
		pal.red[i]=raw_pal[i*3];
		pal.green[i]=raw_pal[(i*3)+1];
		pal.blue[i]=raw_pal[(i*3)+2];

	}
	return;

}

static int graphics_input(void) {

	SDL_Event event;
	int keypressed;

	while ( SDL_PollEvent(&event)) {

		switch(event.type) {

		case SDL_KEYDOWN:
			keypressed=event.key.keysym.sym;
			switch (keypressed) {

			case SDLK_ESCAPE:
				return 27;
			}
			break;
		}
	}
	return 0;

}


static void write_framebuffer(int address, int value) {
	int real_addr;

	real_addr=address-0xa0000;
	if ((real_addr<0) || (real_addr>320*200)) return;

	framebuffer[real_addr]=value;

}

static void push(int value) {
	//printf("Pushing %x\n",value);
	stack[sp]=value;
	sp++;
}

static short pop(void) {
	if (sp==0) {
		printf("Stack underflow!\n");
		return 0;
	}

	sp--;

	//printf("Popping %x\n",stack[sp]);

	return stack[sp];

}



int main(int argc, char **argv) {

	int debug=0;

	set_vga_pal();

	mode13h_graphics_init();

	es=0xa000;

	/* init graphics */
/*start:
	mov    $0x4f02,%ax		; set super VGA mode
	mov    $0x107,%bx		; 1280x1024, 256 colors
	int    $0x10			; set the mode
*/
	ax=0x004f;		/* return value on success */

label_108:
	if (debug) printf("=================================L108====\n");
	if (debug) printf("AX=%04x BX=%04x CX=%04x DX=%04x DI=%04x BP=%x\n",
		ax,bx,cx,dx,di,ebp);
	if (debug) printf("=========================================\n");

	ax=ax<<1;		// shl    %ax
	if (debug) printf("COLOR AFTER SHIFT: %x\n",ax);
	push(cx);		// push   %cx
	if (debug) printf("X-Y (%x-%x) = ",cx,dx);
	cx=cx-dx;		// sub    %dx,%cx
	if (debug) printf("X = %x\n",cx);

	if (cx&0x8000) {
		cx=cx>>1;
		cx|=0x8000;
	}
	else {
		cx=cx>>1;
	}

	if (debug) printf("X>>1 = %x\n",cx);
				// sar    %cx
	di=pop();		// pop    %di
	dx=dx+di;		// add    %di,%dx
	cf=dx&0x1;
	if (dx&0x8000) {
		dx=dx>>1;
		dx|=0x8000;
	}
	else {
		dx=dx>>1;
	}
				// sar    %dx
	newcf=ebp&1;
	ebp=ebp>>1;
	if (cf) {
		ebp|=0x80000000;
	}
	else {
		ebp&=~0x80000000;
	}
	cf=newcf;		// rcr    %ebp
	if (cf) goto label_11f;	// jump if carry=1 jb     0x11f

	ax++;			// inc    %ax
	cx+=0x080;		// add    $0x3,%ch
				// 0x300 == 1024
				// 0x200 == 600
				// 0x100 == ??
				// 0x080 == 200
	dx=-dx;			// neg    %dx
label_11f:
#ifdef APPLEII
#else
	al=ax&0xff;
	ah=(ax&0xff)/0x29;
	al=(ax&0xff)%0x29;	// aam    $0x29
	ax=(ah<<8)|(al&0xff);
	al=al&0xfc;		// and    $0xfc,%al
	al=al^0x12;		// xor    $0x12,%al
	ax=(ah<<8)|(al&0xff);
#endif
	if ((dx&0x8000)!=0) goto label_108;
				// test   $0x80,%dh
				// jmp if zf==0 jne    0x108
	if ((cx&0xf000)!=0) goto label_108;
				// test   $0xf0,%ch
				// jmp if zf==0 jne    0x108


//put_pixel:
	push(ax);		//	push   %ax

#ifdef APPLEII

	ax=ax&7;	// APPLE II

	printf("Putpixel (%d) %d,%d = %d\n",bx>>8,cx,dx,ax&0xf);

	switch(ax) {
		case 0: ax=2; break;
		case 4: ax=12;
			break;
		case 1: ax=2; break; /* green */
		case 2: ax=5; break; /* purple */
		case 5: ax=12; break; /* orange */
		case 6: ax=3; break; /* light blue */
		case 3:
		case 7:ax=15; break; /* white */
	}

#else
	printf("Putpixel (%d) %d,%d = %d\n",bx>>8,cx,dx,ax&0xf);
#endif

	write_framebuffer((es<<4)+(dx*320)+cx, ax&0xff);

				// and    $0xf,%al		; al = color
				// mov    $0xc,%ah		; ah = 0xc = putpixel
				// int    $0x10		; bh=page number, cx=x,dx=y
	ax=pop();		// pop    %ax

	mode13h_graphics_update(framebuffer,&pal);

	if (graphics_input()) {
		return 0;
	}

	goto	label_108;

	return 0;
}
