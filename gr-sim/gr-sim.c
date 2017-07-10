#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <SDL.h>

#include "gr-sim.h"

#include "apple2_font.h"

/* 40x48 low-res mode	*/
#define GR_XSIZE	40
#define GR_YSIZE	48
#define PIXEL_X_SCALE	14
#define PIXEL_Y_SCALE	8

/* 40 column only for now */
#define TEXT_XSIZE	40
#define TEXT_YSIZE	24
#define TEXT_X_SCALE	14
#define TEXT_Y_SCALE	16

static int xsize=GR_XSIZE*PIXEL_X_SCALE;
static int ysize=GR_YSIZE*PIXEL_Y_SCALE;

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
#define	BAS2L	0x2A
#define BAS2H	0x2B
#define H2	0x2C
#define V2	0x2D
#define MASK	0x2E
#define COLOR	0x30
#define INVFLG	0x32
#define YSAV	0x34
#define YSAV1	0x35
#define CSWL	0x36
#define CSWH	0x37
#define FIRST	0xF0
#define SPEEDZ	0xF1
#define FLASH	0xF3
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
				return 27;
			case 'a'...'z':
			case 'A'...'Z':
				return keypressed;
			case SDLK_UP:
				return 11;
			case SDLK_DOWN:
				return 10;
			case SDLK_RIGHT:
				return 21;
			case SDLK_LEFT:
				return 8;
			default:
				printf("Unknown %d\n",keypressed);
				return keypressed;
			}
			break;


		case SDL_JOYBUTTONDOWN:
		case SDL_JOYAXISMOTION:
			printf("Joystick!\n");
			break;

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

static short gr_addr_lookup[24]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};


int grsim_update(void) {

	int x,y,i,j;
	int bit_set,ch,inverse,flash;
	unsigned int *t_pointer;
	int text_start,text_end,gr_start,gr_end;

	t_pointer=((Uint32 *)sdl_screen->pixels);

	text_start=0; text_end=0;
	gr_start=0;gr_end=GR_YSIZE;

	if (text_mode) {
		text_start=0; text_end=TEXT_YSIZE;
		gr_start=0; gr_end=0;
	}
	else if (mixed_graphics) {
		text_start=20; text_end=TEXT_YSIZE;
		gr_start=0; gr_end=40;
	}

	for(y=gr_start;y<gr_end;y++) {
		for(j=0;j<PIXEL_Y_SCALE;j++) {
			for(x=0;x<GR_XSIZE;x++) {
				for(i=0;i<PIXEL_X_SCALE;i++) {
					*t_pointer=color[scrn(x,y)];
					t_pointer++;
				}
			}
		}
	}


	for(y=text_start;y<text_end;y++) {
		for(j=0;j<TEXT_Y_SCALE;j++) {
			for(x=0;x<TEXT_XSIZE;x++) {
				ch=ram[gr_addr_lookup[y]+x];
	//			printf("%x ",ch);

				if (ch&0x80) {
					flash=0;
					inverse=0;
					ch=ch&0x7f;
				}
				else if (ch&0x40) {
					flash=1;
					inverse=0;
					ch=ch&0x3f;
				}
				else {
					inverse=1;
					flash=0;
					ch=ch&0x3f;
				}

				for(i=0;i<TEXT_X_SCALE;i++) {

		/* 14 x 16 */
		/* but font is 5x7 */

		/* FIXME: handle page2 */


		if (j>13) bit_set=0;
		else if (i>11) bit_set=0;
		else bit_set=(a2_font[ch][j/2])&(1<<(5-(i/2)));

		if (inverse) {
			if (bit_set) *t_pointer=color[0];
			else *t_pointer=color[15];
		}
		else if (flash) {
			if (bit_set) *t_pointer=color[9];
			else *t_pointer=color[0];
		}
		else {
			if (bit_set) *t_pointer=color[15];
			else *t_pointer=color[0];
		}

		t_pointer++;

				}
			}
		}
	}


	SDL_UpdateRect(sdl_screen, 0, 0, xsize, ysize);

	return 0;
}


void setnorm(void) {

	y=0xff;
	ram[INVFLG]=y;

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

	//FA62 RESET

	setnorm();

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

	for(i=x1;i<=x2;i++) basic_plot(i,at);

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
	/* fb5b */
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
	if (y<=0x80) goto clrsc3;
}

static void setgr(void) {

	// FB40
	// SETGR
	soft_switch(TXTCLR);	// LDA	TXTCLR
	soft_switch(MIXSET);	// LDA	MIXSET

	clrtop();

	a=0x14;
	setwnd();

}

int gr(void) {

	// F390
	soft_switch(LORES);	// LDA SW.LORES
	soft_switch(MIXSET);	// LDA SW.MIXSET
	//JMP MON.SETGR

	setgr();

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

	if (x>40) {
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



int grsim_put_sprite(unsigned char *sprite_data, int xpos, int ypos) {

	unsigned char i;
	unsigned char *ptr;
	short address;

	ptr=sprite_data;
	x=*ptr;
	ptr++;
	ram[CV]=*ptr;
	ptr++;

	ypos=ypos&0xfe;

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
		ypos+=2;
		ram[CV]--;
		if (ram[CV]==0) break;
	}

	return 0;
}

int gr_copy(short source, short dest) {

	short dest_addr,source_addr;
	int i,j,l;

	for(i=0;i<8;i++) {
		source_addr=gr_addr_lookup[i]+0x400;
		dest_addr=gr_addr_lookup[i];

		if (i<4) l=120;
		else l=80;

		for(j=0;j<l;j++) {
			ram[dest_addr+j]=ram[source_addr+j];
		}
	}

	return 0;
}

int gr_copy48(short source, short dest) {

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

static void scroll(void) {
	unsigned char s;

	// fc70

	a=ram[WNDTOP];
	s=a;
	vtabz();

	// SCRL1
scrl1:
	a=ram[BASL];
	ram[BAS2L]=a;
	a=ram[BASH];
	ram[BAS2H]=a;
	y=ram[WNDWDTH];
	y--;
	a=s;
	a+=1;
	if (a>=ram[WNDBTM]) {
		// SCRL3
		y=0;
		cleolz();
		vtab();
		return;
	}
	s=a;
	vtabz();
	// SCRL2
scrl2:
	a=ram[y_indirect(BASL,y)];
	ram[y_indirect(BAS2L,y)]=a;
	y--;
	if (y<0x80) goto scrl2;
	goto scrl1;
}

static void lf(void) {
	ram[CV]=ram[CV]+1;
	a=ram[CV];
	if (a<ram[WNDBTM]) {
		vtabz();
		return;
	}
	ram[CV]=ram[CV]-1;
	scroll();
}

static void cr(void) {
	a=0x00;
	ram[CH]=a;
	lf();
}



static void bell1(void) {
}

static void up(void) {

	a=ram[WNDTOP];
	if (a>ram[CV]) return;

	ram[CV]=ram[CV]-1;
	vtab();
}

static void bs(void) {

	ram[CH]=ram[CH]-1;

	/* still positive */
	if (ram[CH]<0x80) return;

	a=ram[WNDWDTH];
	ram[CH]=a;
	ram[CH]=ram[CH]-1;

	up();
}

static void storadv(void) {

	// fbf0

	y=ram[CH];
	ram[y_indirect(BASL,y)]=a;

	// advance

	ram[CH]=ram[CH]+1;
	a=ram[CH];
	if (a>=ram[WNDWDTH]) {
		cr();
	}

}

static void vidout(void) {
	// fbfd

	if (a>=0xa0) {
		storadv();
		return;
	}

	/* Control Characters */
	y=a;
	// if bit 7 is set then we set negative flag
	// BPL storadv
	if (a<0x80) {
		storadv();
		return;
	}

	/* carriage return */
	if (a==0x8d) {
		cr();
		return;
	}

	/* linefeed */
	if (a==0x8a) {
		lf();
		return;
	}

	/* backspace */
	if (a==0x88) {
		bs();
		return;
	}

	/* any other control code, beep */
	bell1();
	return;

}

static void vidwait(void) {
	// check if control-S being pressed

	vidout();
}

static void cout1(void) {

	unsigned char s;

	if (a<0xa0) {
	}
	else {
		a=a&ram[INVFLG];
	}
	// coutz
	ram[YSAV1]=y;
	s=a;

	vidwait();

	a=s;
	y=ram[YSAV1];

}

static void cout(void) {
	// FDED
	//	jmp (cswl)	custom handler
	cout1();
}

static void wait(void) {
}

static void outdo(void) {

	unsigned char s;

	/* Print char in the accumulator */
	a=a|0x80;		/* raw ascii has high bit on Apple II */
	if (a<0xa0) {
		/* skip if control char? */
	}
	else {
		a=a|ram[FLASH];
	}
	cout();
	a=a&0x7f;	// ?
	s=a;		// pha
	a=ram[SPEEDZ];
	wait(); 	// this is BASIC, slow down if speed set
	a=s;
}

static void crdo(void) {
	// DAFB
	a=13;	// carriage return
	outdo();
	a=a^0xff;		/* negate for some reason? */
}

void basic_htab(int xpos) {

	unsigned char s;

	// F7E7


	x=xpos;	// JSR GETBYT
	x--;	// DEX
	a=x;	// TXA
	while(a>=40) {
		s=a;	// PHA
		crdo();
		a=s;	// PLA
		a-=40;
	}
	ram[CH]=a;	// STA MON.CH

	// KRW for the win!

}

static void tabv(void) {

	// TABV
	// fb5b
	ram[CV]=a;
	vtab();
}

void basic_vtab(int ypos) {
	// f256
	x=ypos;
	x--;		/* base on zero */
	a=x;

	if (a>23) {
		fprintf(stderr,"Error, vtab %d too big\n",ypos);
		return;
	}
	tabv();
}

void basic_print(char *string) {

	int i;

	for(i=0;i<strlen(string);i++) {
		a=string[i];
		outdo();
	}

}

void basic_inverse(void) {
	// F277
	a=0x3f;
	x=0;
	ram[INVFLG]=a;
	ram[FLASH]=x;

	return;
}

void basic_normal(void) {
	// F273
	a=0xff;
	x=0;
	ram[INVFLG]=a;
	ram[FLASH]=x;

	return;
}


int hlin(int page, int x1, int x2, int at) {

	unsigned short addr;
	int i,hi;

	addr=gr_addr_lookup[at/2];
	hi=at&1;

	addr+=(page*4)<<8;

	for(i=x1;i<x2;i++) {
		if (hi) {
			ram[addr+i]=ram[addr+i]&0x0f;
			ram[addr+i]|=ram[COLOR]&0xf0;
		}
		else {
			ram[addr+i]=ram[addr+i]&0xf0;
			ram[addr+i]|=ram[COLOR]&0x0f;
		}

	}

	return 0;
}
