#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <SDL.h>

#include "gr-sim.h"

#include "apple2_font.h"

#define XSIZE		40
#define YSIZE		48

#define PIXEL_X_SCALE	14
#define PIXEL_Y_SCALE	8

static int xsize=XSIZE*PIXEL_X_SCALE;
static int ysize=YSIZE*PIXEL_Y_SCALE;

static int debug=0;


/* 128kB of RAM */
#define RAMSIZE 128*1024
unsigned char ram[RAMSIZE];

/* Registers */
unsigned char a,y,x;

/* Zero page addresses */
#define WNDLFT	0x20
#define WNDWDTH	0x21
#define WNDTOP	0x22
#define WNDBTM	0x23
#define	CH	0x24
#define CV	0x25
#define GBASL	0x26
#define GBASH	0x27
#define BASL	0x28
#define BASH	0x29
#define MASK	0x2E
#define COLOR	0x30


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


	/* a = ycoord */
static int gbascalc(unsigned char a) {

	unsigned char s,c;

			/* input ABCD EFGH */
	s=a;		/* store a on stack */
	c=a&1;
	a=a>>1;		/* lsr */
	a=a&0x3;	/* mask */
	a=a|0x4;	/* 00001FG */
	ram[GBASH]=a;
	a=s;

	a=a&0x18;	/* 000D E000 */

	/* if odd */
	if (c) {
		a=a+0x7f+1;
	}
	ram[GBASL]=a;
	a=a<<2;
	a=a|ram[GBASL];
	ram[GBASL]=a;

	if (debug) printf("GBAS=%02X%02X\n",ram[GBASH],ram[GBASL]);

	return 0;
}

static short y_indirect(unsigned char base, unsigned char y) {

	unsigned short addr;

	addr=(((short)(ram[base+1]))<<8) | (short)ram[base];

	if (debug) printf("Address=%x\n",addr+y);

	return addr+y;

}

int scrn(unsigned char xcoord, unsigned char ycoord) {

	unsigned char a,y,c;

	a=ycoord;
	y=xcoord;

	c=a&1;
	a=a>>1;
	gbascalc(a);
	a=ram[y_indirect(GBASL,y)];

	if (c) {
		return a>>4;
	}
	else {
		return a&0xf;
	}

	return 0;
}


int grsim_update(void) {

	int x,y,i,j;
	unsigned int *t_pointer;

	t_pointer=((Uint32 *)sdl_screen->pixels);

	for(y=0;y<YSIZE;y++) {
		for(j=0;j<PIXEL_Y_SCALE;j++) {
		for(x=0;x<XSIZE;x++) {
			for(i=0;i<PIXEL_X_SCALE;i++) {
				*t_pointer=color[scrn(x,y)];
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
	int x;

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
	for(x=0x400;x<0x800;x++) ram[x]=0;

	/* Set up some zero page values */
	ram[WNDLFT]=0x00;
	ram[WNDWDTH]=0x28;
	ram[WNDTOP]=0x00;
	ram[WNDBTM]=0x18;

	a=0; y=0; x=0;

	return 0;
}

int color_equals(int new_color) {

	/* Top and Bottom both have color */
	ram[COLOR]=((new_color%16)<<4)|(new_color%16);

	return 0;
}





int plot(unsigned char xcoord, unsigned char ycoord) {

	unsigned char c;

	if (ycoord>40) {
		printf("Y too big %d\n",ycoord);
		return -1;
	}

	/* Applesoft Source Code	*/
	/* F225	GET X,Y Values		*/
	/* Y-coord in A			*/
	/* X-coord in Y			*/
	/* Check that X-coord<40	*/
	a=ycoord;
	y=xcoord;

	if (y>=40) {
		printf("X too big %d\n",y);
		return -1;
	}
	/* Call into Monitor $F800 */

	c=a&1;	/* save LSB in carry	*/
	a=a>>1;	/* lsr A */
	gbascalc(a);

	if (c) {
		/* If odd, mask is 0xf0 */
		ram[MASK]=0xf0;
	}
	else {
		/* If even, mask is 0x0f */
		ram[MASK]=0x0f;
	}

	a=ram[y_indirect(GBASL,y)];

	a=a^ram[COLOR];

	a=a&ram[MASK];

	a=a^ram[y_indirect(GBASL,y)];

	ram[y_indirect(GBASL,y)]=a;

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

int gr(void) {
	int i;

	/* Init screen */
	for(i=0x400;i<0x800;i++) ram[i]=0;

	return 0;
}

int bload(char *filename, int address) {

	FILE *fff;
	int count=0,ch=0;

	fff=fopen(filename,"r");
	if (fff==NULL) {
		fprintf(stderr,"Could not open %s\n",filename);
		return -1;
	}

	while(1) {

		if ((address+count)>RAMSIZE) {
			fprintf(stderr,"ERROR ram too high\n");
			return -1;
		}


		ch=fgetc(fff);
		if (ch<0) break;

		ram[address+count]=ch;
		count++;
	}
	fclose(fff);

	return 0;
}

static int bascalc(void) {
	// FBC1

	unsigned char s,c;

	s=a;
	c=a&0x1;

	a=a>>1;
	a=a&0x3;
	a=a|0x4;
	ram[BASH]=a;
	a=s;
	a=a&0x18;
	if (c!=0) {
		a=a+0x80;
	}
// BSCLC2
	ram[BASL]=a;
	a=a<<2;
	a=a|ram[BASL];
	ram[BASL]=a;

	return 0;
}

static int vtabz(void) {

	bascalc();

	a+=ram[WNDLFT];
	ram[BASL]=a;

	return 0;
}

static int vtab(void) {

	a=ram[CV];
	vtabz();

	return 0;
}


static int cleolz(void) {
	// FC9E

	a=0xa0;
clreol2:
	ram[y_indirect(BASL,y)]=a;
	y++;

	if (y<ram[WNDWDTH]) goto clreol2;

	return 0;
}

static int cleop1(void) {

	unsigned char s;

cleop1_begin:
	s=a;
	vtabz();
	cleolz();
	y=0x00;
	a=s;
	a++;
	if (a<=ram[WNDBTM]) goto cleop1_begin;
	vtab();

	return 0;
}

int home(void) {

	/* FC58 */
	a=ram[WNDTOP];
	ram[CV]=a;
	y=0x00;
	ram[CH]=y;
	cleop1();

	return 0;
}

int grsim_unrle(unsigned char *rle_data, int address) {

	int i,total=0;
//	int xoffset=0;
//	int yoffset=0;

	int xsize,ysize,end,run,value;
	unsigned char *out_pointer;
	int offset,x=0,y=0;

	xsize=rle_data[0];
	ysize=rle_data[1];

	end=xsize*(ysize/2);
	out_pointer=ram+address;
	offset=2;

	while(1) {
		run=rle_data[offset];
		offset++;
		value=rle_data[offset];
		offset++;

		for(i=0;i<run;i++) {
			*out_pointer=value;
			out_pointer++;
			total++;
			x++;
			if (x>=40) {
				out_pointer+=0x58;
				y+=2;
				if (y>14) {
					y=0;
					out_pointer-=(0x400-0x28);
//					printf("%d %x\n",y,address+(y/2)*0x80);
				}
				x=0;
			}
		}

		if (total>=end) break;
	}

	return 0;
}
