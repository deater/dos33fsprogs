#include <stdio.h>
#include <unistd.h>

#include <SDL.h>

#include "vga_emulator.h"

/* technically bigger than 320x200 but some code writes off edge... */
/* in theory 16-bit pointer can't write beyond this */
unsigned char framebuffer[65536];

static SDL_Surface *sdl_screen=NULL;

static struct palette pal;

static int debug=0;

static int xsize=320,ysize=200,scale=1;

int mode13h_graphics_init(char *name, int new_scale) {

	int mode;

	scale=new_scale;
	xsize=320*scale;
	ysize=200*scale;

	mode=SDL_SWSURFACE|SDL_HWPALETTE|SDL_HWSURFACE;

	if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) {
		fprintf(stderr,
			"Couldn't initialize SDL: %s\n", SDL_GetError());
		return -1;
	}

	/* Clean up on exit */
	atexit(SDL_Quit);

	/* assume 32-bit color */
	sdl_screen = SDL_SetVideoMode(xsize, ysize, 32, mode);

	if ( sdl_screen == NULL ) {
		fprintf(stderr, "ERROR!  Couldn't set %dx%d video mode: %s\n",
			xsize,ysize,SDL_GetError());
		return -1;
	}
	SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);

	if (name==NULL) {
		SDL_WM_SetCaption("Linux/C/SDL","unknown");
	}
	else {
		SDL_WM_SetCaption(name,name);
	}

	return 0;
}

int mode13h_graphics_update(void) {

        unsigned int *t_pointer;

        int x,y,temp,in_ptr,out_ptr,i,j;

        /* point to SDL output pixels */
        t_pointer=((Uint32 *)sdl_screen->pixels);

	out_ptr=0;
	for(y=0;y<200;y++) {
		for(j=0;j<scale;j++) {
	        for(x=0;x<320;x++) {
			in_ptr=(y*320)+x;
	                temp=(pal.red[framebuffer[in_ptr]]<<16)|
        	                (pal.green[framebuffer[in_ptr]]<<8)|
                	        (pal.blue[framebuffer[in_ptr]]<<0)|0;
			for(i=0;i<scale;i++) {
				t_pointer[out_ptr]=temp;
				out_ptr++;
			}
		}
		}
        }

        SDL_UpdateRect(sdl_screen, 0, 0, xsize, ysize);

        return 0;
}


/* output of vgapal https://github.com/canidlogic/vgapal */
static unsigned char default_pal[3*256]=
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

void set_default_pal(void) {

	int i;

	for(i=0;i<256;i++) {
		pal.red[i]=default_pal[i*3];
		pal.green[i]=default_pal[(i*3)+1];
		pal.blue[i]=default_pal[(i*3)+2];

	}
	return;

}

int graphics_input(void) {

	SDL_Event event;
	int keypressed;

	while ( SDL_PollEvent(&event)) {

		switch(event.type) {

		case SDL_KEYDOWN:
			keypressed=event.key.keysym.sym;
			switch (keypressed) {

			case SDLK_ESCAPE:
				return 27;

			default:
				return keypressed;
			}
			break;
		}
	}
	return 0;

}

void framebuffer_write_20bit(int address, int value) {
	int real_addr;

	real_addr=address-0xa0000;
	if ((real_addr<0) || (real_addr>320*200)) return;

	framebuffer[real_addr]=value;

}

void framebuffer_write(int address, int value) {

	if (debug) {
	if ((address<0) || (address>320*200)) {
		fprintf(stderr,
			"Error!  Framebuffer write of 0x%x (%d,%d) "
			"out of bounds\n",
			address,address%320,address/320);
		return;
	}
	}

	framebuffer[address]=value;

}




static int dac_write_address=0,dac_write_which=0;
static int dac_read_address=0,dac_read_which=0;

void outp(short address, int value) {

	switch(address) {

	/* DAC read address */
	case 0x3c7:
		if (debug) fprintf(stderr,"Setting read address to %d\n",value);
		dac_read_address=value;
		dac_read_which=0;
		break;

	/* DAC write address */
	case 0x3c8:
		if (debug) fprintf(stderr,"Setting write address to %d\n",value);
		dac_write_address=value;
		dac_write_which=0;
		break;

	/* PEL/DAC data */
	/* Note colors are 0..63 */
	case 0x3c9:
		if (dac_write_which==0) {
			pal.red[dac_write_address]=value*4;
			if (debug) fprintf(stderr,"Color %d R=0x%x ",
				dac_write_address,value);
		}
		if (dac_write_which==1) {
			pal.green[dac_write_address]=value*4;
			if (debug) fprintf(stderr,"G=0x%x ",value);
		}
		if (dac_write_which==2) {
			pal.blue[dac_write_address]=value*4;
			if (debug) fprintf(stderr,"B=0x%x\n",value);
		}
		dac_write_which++;
		if (dac_write_which==3) {
			dac_write_address++;
			dac_write_which=0;
			if (dac_write_address>255) {
				if (debug) fprintf(stderr,"Palette overflow!\n");
				dac_write_address=0;	/* FIXME: is this right? */
			}
		}
		break;


	default:
		printf("outp to unknown port 0x%x\n",address);
	}
}

int inp(short address) {

	int retval=0;

	switch(address) {

	/* DAC read address */
	case 0x3c9:
		if (dac_read_which==0) {
			retval=pal.red[dac_read_address]/4;
			if (debug) fprintf(stderr,"Color %d R=0x%x ",
				dac_read_address,retval);
		}
		if (dac_read_which==1) {
			retval=pal.green[dac_read_address]/4;
			if (debug) fprintf(stderr,"G=0x%x ",retval);
		}
		if (dac_read_which==2) {
			retval=pal.blue[dac_read_address]/4;
			if (debug) fprintf(stderr,"B=0x%x\n",retval);
		}
		dac_read_which++;
		if (dac_read_which==3) {
			dac_read_address++;
			dac_read_which=0;
			if (dac_read_address>255) {
				if (debug) fprintf(stderr,"Palette overflow!\n");
				dac_read_address=0;	/* FIXME: is this right? */
			}
		}
		break;


		default:
			printf("inp from unknown port 0x%x\n",address);
	}

        return retval;
}
