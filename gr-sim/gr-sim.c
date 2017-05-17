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
#define H2	0x2C
#define V2	0x2D
#define MASK	0x2E
#define COLOR	0x30
#define FIRST	0xF0

#define TEMP	0xFA


/* Soft Switches */
#define TXTCLR	0xc050
#define TXTSET	0xc051
#define	MIXCLR	0xc052
#define MIXSET	0xc053
#define	LOWSCR	0xc054
#define HISCR	0xc055
#define LORES	0xc056
#define HIRES	0xc057

static int text_mode=1;
static int text_page_1=1;
static int hires_on=0;
static int mixed_graphics=1;

static void soft_switch(unsigned short address) {

	switch(address) {
		case TXTCLR:	// $c050
			text_mode=0;
			break;
		case TXTSET:	// $c051
			text_mode=1;
			break;
		case MIXCLR:	// $c052
			mixed_graphics=0;
			break;
		case MIXSET:	// $c053
			mixed_graphics=1;
			break;
		case LOWSCR:	// $c054
			text_page_1=1;
			break;
		case LORES:	// $c056
			hires_on=0;
			break;
		case HIRES:	// $c057
			hires_on=1;
			break;
		default:
			fprintf(stderr,"Unknown soft switch %x\n",address);
			break;
	}
}

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

	if (text_mode) {
		for(y=0;y<YSIZE;y++) {
			for(j=0;j<PIXEL_Y_SCALE;j++) {
				for(x=0;x<XSIZE;x++) {
					for(i=0;i<PIXEL_X_SCALE;i++) {
						*t_pointer=color[15];
						t_pointer++;
					}
				}
			}
		}
	}
	else {
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



static void plot(void) {

	unsigned char c;

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

}


int basic_plot(unsigned char xcoord, unsigned char ycoord) {

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

	plot();

	return 0;
}


int basic_hlin(int x1, int x2, int at) {

	int i;

	for(i=x1;i<x2;i++) basic_plot(i,at);

	return 0;
}


static void bascalc(void) {
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

}

static void vtabz(void) {

	bascalc();

	a+=ram[WNDLFT];
	ram[BASL]=a;

}

static void vtab(void) {

	a=ram[CV];
	vtabz();
}

static void setwnd(void) {

	ram[WNDTOP]=a;
	a=0x0;
	ram[WNDLFT]=a;
	a=0x28;
	ram[WNDWDTH]=a;
	a=0x18;
	ram[WNDBTM]=a;
	a=0x17;
// TABV
	ram[CV]=a;
	vtab();
}

static void vline(void) {

	unsigned char s;

	// f828
vline_loop:
	s=a;
	plot();
	a=s;
	if (a<ram[V2]) {
		a++;
		goto vline_loop;
	}
}

static void clrtop(void) {

	// f836
	y=0x27;
	ram[V2]=y;
	y=0x27;
clrsc3:
	a=0x0;
	ram[COLOR]=a;
	vline();
	y--;
	if (y>0) goto clrsc3;
}

int gr(void) {

	// F390
	soft_switch(LORES);	// LDA SW.LORES
	soft_switch(MIXSET);	// LDA SW.MIXSET
	//JMP MON.SETGR

	// FB40
	soft_switch(TXTCLR);	// LDA	TXTCLR
	soft_switch(MIXSET);	// LDA	MIXSET

	clrtop();

	a=0x14;
	setwnd();

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

//	int xoffset=0;
//	int yoffset=0;

	unsigned char s;
//	int out_pointer;

	ram[GBASL]=0;	// input address
	ram[GBASH]=0;

	x=0;
	y=0;

	ram[BASL]=address&0xff;
	ram[BASH]=address>>8;

	ram[CV]=0;
	ram[CH]=rle_data[y_indirect(GBASL,y)];
	y++;
//	ysize=rle_data[1];
	y++;

	while(1) {
		a=rle_data[y_indirect(GBASL,y)];
		if (a==0xff) break;
		ram[TEMP]=a;

		y++;
		if (y==0) ram[GBASH]++;

		a=rle_data[y_indirect(GBASL,y)];
		y++;
		if (y==0) ram[GBASH]++;

		s=y;
		y=0;

		while(1) {
			ram[y_indirect(BASL,y)]=a;
			ram[BASL]++;
			if (ram[BASL]==0) ram[BASH]++;
			x++;
			if (x>=ram[CH]) {
				if (ram[BASL]>0xa7) ram[BASH]++;
				ram[BASL]+=0x58;
				ram[CV]+=2;
				if (ram[CV]>14) {
					ram[CV]=0;
					if (ram[BASL]<0xd8) {
						ram[BASL]=ram[BASL]-0xd8;
						ram[BASH]=ram[BASH]-0x4;
					}
					else {
						ram[BASL]=ram[BASL]-0xd8;
						ram[BASH]=ram[BASH]-0x3;
					}
				}
				x=0;
			}
			ram[TEMP]--;
			if (ram[TEMP]==0) break;
		}
		y=s;
	}

	return 0;
}

int basic_vlin(int y1, int y2, int at) {

	// f244

	// LINCOOR
	// GET "A,B AT C"
	// PUT SMALLER OF (A,B) IN FIRST,
        // AND LARGER  OF (A,B) IN H2 AND V2.
        // RETURN WITH (X) = C-VALUE.

	if (y1>y2) { ram[H2]=y1; ram[V2]=y1; ram[FIRST]=y2; }
	else       { ram[H2]=y2; ram[V2]=y2; ram[FIRST]=y1; }
	x=at;

	if (x>48) {
		fprintf(stderr,"Error!  AT too large %d!\n",x);
	}

//VLIN  JSR LINCOOR
//F244- 8A       2050        TXA          X-COORD IN Y-REG
//F245- A8       2060        TAY
//F246- C0 28    2070        CPY #40      X-COORD MUST BE < 40
//F248- B0 BC    2080        BCS GOERR    TOO LARGE
//F24A- A5 F0    2090        LDA FIRST    TOP END OF LINE IN A-REG
//F24C- 4C 28 F8 2100        JMP MON.VLINE     LET MONITOR DRAW LINE

	y=x;
	if (y>=40) {
		fprintf(stderr,"X value to big in vline %d\n",y);
		return -1;
	}
	a=ram[FIRST];

	vline();

//	for(i=y1;i<y2;i++) basic_plot(at,i);

	return 0;
}


short gr_addr_lookup[48]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

int grsim_put_sprite(unsigned char *sprite_data, int xpos, int ypos) {

	unsigned char i;
	unsigned char *ptr;
	short address;

	ptr=sprite_data;
	x=*ptr;
	ptr++;
	ram[CV]=*ptr;
	ptr++;

	while(1) {
		address=gr_addr_lookup[ypos/2];
		address+=xpos;
		for(i=0;i<x;i++) {
			a=*ptr;
			if (a==0) {
			}
			else if ((a&0xf0)==0) {
				ram[address]&=0xf0;
				ram[address]|=a;
			}
			else if ((a&0x0f)==0) {
				ram[address]&=0x0f;
				ram[address]|=a;
			}
			else {
				ram[address]=a;
			}
			ptr++;
			address++;
		}
		ypos++;
		ram[CV]--;
		if (ram[CV]==0) break;
	}

	return 0;
}

int gr_copy(short source, short dest) {

	short dest_addr,source_addr;
	int i,j;

	for(i=0;i<8;i++) {
		source_addr=gr_addr_lookup[i]+0x400;
		dest_addr=gr_addr_lookup[i];

		for(j=0;j<120;j++) {
			ram[dest_addr+j]=ram[source_addr+j];
		}
	}

	return 0;
}


int text(void) {
	// FB36

	soft_switch(LOWSCR);	// LDA LOWSCR ($c054)
	soft_switch(TXTSET);	// LDA TXTSET ($c051);
	a=0;

	setwnd();

	return 0;
}

int basic_htab(int x) {
	return 0;
}

int basic_vtab(int y) {
	return 0;
}

int basic_print(char *string) {
	return 0;
}

