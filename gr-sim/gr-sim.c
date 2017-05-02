#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <SDL.h>

#include "gr-sim.h"

#define XSIZE		40
#define YSIZE		48

#define PIXEL_X_SCALE	14
#define PIXEL_Y_SCALE	8

static int xsize=XSIZE*PIXEL_X_SCALE;
static int ysize=YSIZE*PIXEL_Y_SCALE;

static unsigned char framebuffer[XSIZE][YSIZE];

/* 128kB of RAM */
unsigned char ram[128*1024];


static SDL_Surface *sdl_screen=NULL;

int grsim_input(void) {

	SDL_Event event;
	int keypressed;


	while ( SDL_PollEvent(&event)) {

		switch(event.type) {

		case SDL_KEYDOWN:
			keypressed=event.key.keysym.sym;
			switch (keypressed) {

			case SDLK_ESCAPE:
				return 'q';
			default:
				return keypressed;
			}
			break;


		case SDL_JOYBUTTONDOWN:
		case SDL_JOYAXISMOTION:
		default:
			printf("Unknown input action!\n");
			break;

		}
	}

	return 0;
}




static unsigned int color[16]={
	0,		/*  0 black */
	0xe31e60,	/*  1 magenta */
	0x604ebd,	/*  2 dark blue */
	0xff44fd,	/*  3 purple */
	0x00a360,	/*  4 dark green */
	0x9c9c9c,	/*  5 grey 1 */
	0x14cffd,	/*  6 medium blue */
	0xd0c3ff,	/*  7 light blue */
	0x607203,	/*  8 brown */
	0xff6a3c,	/*  9 orange */
	0x9d9d9d,	/* 10 grey 2 */
	0xffa0d0,	/* 11 pink */
	0x14f53c,	/* 12 bright green */
	0xd0dd8d,	/* 13 yellow */
	0x72ffd0,	/* 14 aqua */
	0xffffff,	/* 15 white */
};

int grsim_update(void) {

	int x,y,i,j;
	unsigned int *t_pointer;

	t_pointer=((Uint32 *)sdl_screen->pixels);

	for(y=0;y<YSIZE;y++) {
		for(j=0;j<PIXEL_Y_SCALE;j++) {
		for(x=0;x<XSIZE;x++) {
			for(i=0;i<PIXEL_X_SCALE;i++) {
				*t_pointer=color[framebuffer[x][y]];
				t_pointer++;
			}
		}
		}
	}

	SDL_UpdateRect(sdl_screen, 0, 0, xsize, ysize);

	return 0;
}


int grsim_init(void) {

	int mode;
	int x,y;

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

	/* Init screen */
	for(y=0;y<YSIZE;y++) for(x=0;x<XSIZE;x++) framebuffer[x][y]=0;

	return 0;
}

static int current_color=0;

int color_equals(int new_color) {
	current_color=new_color;
	return 0;
}

int plot(int x, int y) {
	framebuffer[x][y]=current_color;
	return 0;
}

int hlin(int x1, int x2, int at) {

	int i;

	for(i=x1;i<x2;i++) plot(i,at);

	return 0;
}

int vlin(int y1, int y2, int at) {

	int i;

	for(i=y1;i<y2;i++) plot(at,i);

	return 0;
}


