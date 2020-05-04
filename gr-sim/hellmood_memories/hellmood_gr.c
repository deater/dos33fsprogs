/* A Linux/SDL/C version of Hellmood's amazing 256B DOS Memories Demo */

/* See http://www.sizecoding.org/wiki/Memories for a rundown on how it works */

/* This is a conversion to C I did in an attempt to see how it works */
/* and also to see if I could port any of this to the Apple II */

/* x86 has amazing code density with powerful instructions */
/*	stos, mul, div, FPU, lots of 1-byte instructions */
/* and old x86 hardware made it really easy to program with limited code */
/*     VGA/MCGA Mode13h (320x200 256 colors linear framebuffer) */
/*     soundblaster MIDI with only a few out instructions */

/* Anyway this is a rough attempt to getting things going in C */
/* The last effect (ocean) is doing lots of sketchy stuff and */
/* depending a bit on undefined behavior so it's hit or miss */
/* whether it will work for you */

/* deater -- Vince Weaver -- vince@deater.net -- 23 April 2020 */

#include <stdio.h>
#include <unistd.h>

#include "gr-sim.h"
#include "tfv_zp.h"

static unsigned short frame;

#if 0
static unsigned short stack[128];
static unsigned short ax,bx,cx,dx,es;
static int cf=0,of=0,zf=0,sf=0;
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

/* unsigned multiply */
static void mul_16(unsigned short value) {
	unsigned int result;

	result=ax*value;

//	printf("%x*%x=%x ",value,ax,result);

	ax=result&0xffff;
	dx=result>>16;

//	printf("%x:%x x=%d y=%d\n",dx,ax,
//		dx&0xff,(dx>>8)&0xff);




	if (dx==0) {
		of=0;
		cf=0;
	}
	else {
		of=1;
		cf=1;
	}

}

/* 
static void imul(short value) {
	int result;

	result=ax*value;

	ax=result&0xffff;
	dx=result>>16;

}
*/



/* signed multiply */
static void imul_8(char value) {

	short result;
	char src;

	src=ax;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	ax=result;

	if (ax==(ax&0xff)) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}

/* signed multiply */
static void imul_16(short value) {

	int result;
	short src;

	src=ax;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	ax=(result&0xffff);
	dx=((result>>16)&0xffff);

	if (dx==0) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}

/* signed multiply */
static void imul_16_bx(short value) {

	int result;
	short src;

	src=bx;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	bx=(result&0xffff);

	if (bx==result) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}

/* signed multiply */
static void imul_16_dx(short value) {

	int result;
	short src;

	src=dx;

	result=src*value;

//	printf("imul: %d*%d=%d ",src,value,result);

	dx=(result&0xffff);

	if (dx==result) {
		cf=0;
		of=0;
	}
	else {
		cf=1;
		of=1;
	}

}





/* unsigned divide */
static void div_8(unsigned char value) {

	unsigned char r,q;
	unsigned int result,remainder;

//	printf("Dividing %d (%x) by %d (%x): ",ax,ax,value,value);

	if (value==0) {
		printf("Divide by zero!\n");
		return;
	}

	result=ax/value;
	remainder=ax%value;

	q=result;
	r=remainder;

//	printf("Result: q=%d r=%d\n",q,r);

	ax=(r<<8)|(q&0xff);

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
#endif

	/* tilted plane */
	/* DH=Y, DL=X */
static int fx0(int xx, int yy, int xprime) {
	return 0;
}
#if 0
	char ah,al,dh,dl;
	unsigned short temp;

	ax=0x1329;	// mov ax,0x1329	init

	al=ax&0xff; ah=(ax>>8)&0xff;
	dl=xprime; dh=yy;


	dh=dh+al;	// add dh,al	; prevent divide overflow
	div_8(dh);	// div dh	; reverse divide AL=C/Y'

	dx=((dh&0xff)<<8)|dl;

	temp=ax;
	ax=dx; dx=temp;	// xchg dx,ax	; DL=C/Y' AL=X

	dl=dx&0xff; dh=(dx>>8)&0xff;

	imul_8(dl);	// imul dl
	dx=dx-frame;	// sub dx,bp
	dl=dx&0xff;

	ah=(ax>>8)&0xff;
	ah=ah^dl;	// xor ah,dl
	al=ah;		// mov al,ah
	ax=((ah&0xff)<<8)|(al&0xff);

	ax&=0xff1c;	// and al,4+8+16

	return ax;
}

#endif
/* circles? */
/* DH=Y, DL=X */
static int fx1(int xx, int yy, int xprime) {

	signed short yyy,xxx;
	signed short color;

	yyy=yy-24;		/* align Y vertically */

	yyy=yyy*yyy;
	color=((yyy/32)&0xff);

	/* signed 8-bit multiply */
	xxx=xprime-20;
	xxx=(char)xxx*(char)xxx;
	color+=((xxx/32)&0xff);

	color+=frame;		/* offset color by time */
//	color&=0x18;		/* select special rings */
//	color&=0x18;		/* select special rings */

	return color;
}


/* checkers */
static int fx2(int xx, int yy, int xprime) {
	return 0;
}
#if 0
	int color;

	color=((yy&0xff)<<8) | (xprime&0xff);
	color=color-frame;		/* adjust with frame */
	color=((color>>8)&0xff)^(color&0xff); /* xor x and y */
	color|=0xdb;	/* or result with 0xdb */
	color+=0x13;	/* Map to yellow/grey */

	return color;

}
#endif

/* parallax checkerboard */
static int fx3(int xx,int yy,int xprime) {
	return 0;
}

#if 0
	dx=((yy&0xff)<<8) | (xprime&0xff);

	cx=frame;		// mov cx,bp ; set init point to time
	bx=-16;		// mov bx,-16 ; limit to 16 iterations
fx3L:
	cx=cx+(yy*320)+xx;	// add cx, di ; offset by screenpointer
	ax=819;		// mov ax,819 ; magic, related to Rrrola
	imul_16(cx);	// imul cx ; get X',Y' in DX
	cf=dx&1;	// ror dx,1 ; set carry flag on "hit"
	dx=dx>>1;
	if (cf) {
		dx|=0x8000;
	}
	else {
		dx&=0x7fff;
	}

	bx++;		// inc bx ; increment iteration count
	if (bx==0) zf=1;// does not affect carry flag
	else zf=0;
			// ja fx3L ; loop until "hit" or "iter=max"
			// jump above, if cf==0 and zf==0
	if ((cf==0) && (zf==0)) goto fx3L;

	ax=bx+31;	// lea ax,[bx+32] ; map value to standard gray scale
	//printf("%d %d\n",ax,bx);

	return ax;
}
#endif

/* sierpinski rotozoomer */
static int fx4(int xx, int yy, int xprime) {
	return 0;
}
#if 0
	unsigned char dl,dh,bh,al;

	dx=((yy&0xff)<<8) | (xprime&0xff);

	dl=dx&0xff;	dh=(dx>>8)&0xff;

	cx=frame-2048;	// lea cx,[bp-2048] ; center time to pass zero
	cx=cx<<3;	// sal cx,3 ; speed up by factor of 8!
	ax=(dh&0xff);	// movzx ax,dh ; get X into AL
			// movsx dx,dl ; get Y into DL
	if (dl&0x80) {
		dx|=0xff00;
	}
	else {
		dx&=0x00ff;
	}

	bx=ax;		// mov bx,ax   ; save X in BX
	imul_16_bx(cx);	// imul bx,cx  ; BX=X*T

	/* bl=bx&0xff;	*/ bh=(bx>>8)&0xff;
	dl=dx&0xff;	dh=(dx>>8)&0xff;

	bh=bh+dl;	// add bh,dl   ; bh=x*t/256+Y

	imul_16_dx(cx);	// imul dx,cx  ; dx=Y*T

	dl=dx&0xff;	dh=(dx>>8)&0xff;

			// sub al,dh   ; al=X-Y*T/256
	al=ax&0xff;	// ah=(ax>>8)&0xff;
	al=al-dh;

			// and al,bh   ; AL=(X-Y*T/256)&(x*T/256+Y)
	al=al&bh;
	al=al&252;	// and al,252  ; thicker sierpinksi
	if (al==0) zf=1;
	else zf=0;
	cf=0; of=0;
			// salc	       ; set pixel value to black
	if (cf==0) al=0;
	else al=0xff;

/* NOTE: remove the line below and the background becomes a rainbow */
	ax=al;
			// jnz fx4q    ; leave black if not sierpinksi
	if (zf==0) goto fx4q;

	ax=ax&0xff00;	// mov al,0x2a ; otherwise: a nice orange
	ax|=0x2a;
fx4q:
	;
	return ax;
}

#endif
/* raycast bent tunnel */
static int fx5(int xx, int yy, int xprime) {
	return 0;
}
#if 0
	unsigned char al,cl;
	unsigned short temp;

	dx=((yy&0xff)<<8) | (xprime&0xff);

	cx=cx&0xff00;
	cx|=(-9&0xff);	// mov cl,-9	; start with depth 9 (moves backwards)
fx5L:
	cl=cx&0xff;

	push(dx);	// push dx ; save DX, destroyed inside loop
	al=(dx>>8)&0xff;// mov al,dh ; get Y into AL
	al-=100;	// sub al,100 ; centering Y manually

	ax=ax&0xff00;
	ax|=(al&0xff);

	imul_8(cl);	// imul cl	; multiply AL=Y by current distance to get projection
			// xchg ax,dx ; gt X into AL while saving DX
	temp=ax;
	ax=dx;
	dx=temp;

	al=ax&0xff;
	al+=cl;		// add al,cl  ; add distance to projection (bend right)

	ax=ax&0xff00;
	ax|=(al&0xff);
	imul_8(cl);	// imul cl	; multiply AL=X by the current projection
	al=(dx>>8)&0xff;// mov al,dh  ; get projection(1) in AL
	al^=(ax>>8);	// xor al,ah ; combine with projection(2)
	al+=4;		// add al,4  ; center the walls around 0
	if (al&-8) {	// test al,-8 ; test if the wall is hit
		zf=0;
	}
	else {
		zf=1;
	}

	dx=pop();	// pop dx (restore dx)
	cx&=0xff00;
	cx|=(cl&0xff);
	cx--;
	if ((cx!=0) && (zf==1)) goto fx5L;
			// loopz fx5L (repeat until "hit" or "iter=max"

	cx=cx-frame;	// sub cx,bp ; offset depth by time
	al^=(cx&0xff);	// xor al,cl ; XOR pattern for texture
//	ah=al/6;
	al=al%6;	// aam 6	; irregular pattern with MOD 6
	al+=20;		// add al,20	; offset into grayscale pattern
	ax=al&0xff;

	return ax;
}
#endif

/* ocean night */
static int fx6(int xx, int yy, int xprime) {
	return 0;
}
#if 0
	char dh;
	double f;
	int edx;
	char scratch[64];

	dx=((yy&0xff)<<8) | (xprime&0xff);

	// bx coming in is the address of the effect
	// this is a guess, too lazy to hexdump
	bx=0x1d5;

	// si=?? based on sound playing?
	// ax (sky color) is ?

	dh=dx>>8;
			// sub dh,120 ; check if pixel in the sky
	dh=dh-120;
	sf=!!(dh&0x80);
			// js fx6q    ; quit if that's the case
	if (sf) goto fx6q;

	dx&=0xff;
	dx|=dh<<8;

		// mov [bx+si],dx	; move xy to memory location
		// fild word [bx+si]	; read as integer
		// fidivr dword [bx+si] ; reverse divide by constant
		// Divide m32int by ST(0) and store result in ST(0)
		// fstp dword [bx+si-1] ; store result as floating point
		// mov ax,[bx+si]	; get result into ax

	memcpy(&scratch[32],&dx,sizeof(short));
	f=dx;
	memcpy(&edx,&scratch[32],sizeof(int));
	f=f/edx;
	memcpy(&scratch[31],&f,sizeof(double));
	memcpy(&ax,&scratch[32],sizeof(short));




	ax+=frame;		// add ax,bp ; modify color by time
	ax&=0xff80;	// and al,128 ; threshold into two bands
	ax--;		// dec ax ; beautify colors to blue/black
fx6q:	;
	return ax;
}
#endif

int main(int argc, char **argv) {

	int color=0,which,xx,yy,xprime;
	int ch;

	grsim_init();

	gr();

	clear_screens();

	ram[DRAW_PAGE]=0;

	frame=0x13;

	while(1) {
		for(yy=0;yy<48;yy++) {
		for(xx=0;xx<40;xx++) {

//			xprime=xx*256/320;
			xprime=xx;
			/* rrolla multiply by 0xcccd trick */

			which=frame/512;
			switch (which&0xff) {
				case 1:	color=fx2(xx,yy,xprime); break;
				case 0:	color=fx1(xx,yy,xprime); break;
				case 2: color=fx0(xx,yy,xprime); break;
				case 3: color=fx3(xx,yy,xprime); break;
				case 4: color=fx4(xx,yy,xprime); break;
				case 5: color=fx5(xx,yy,xprime); break;
				case 6: color=fx6(xx,yy,xprime); break;
				case 7: return 0;
				default: printf("Trying effect %d\n",which);
			}
			color_equals(color&0xf);
			plot(xx,yy);
//			printf("plot %d,%d = %d\n",xx,yy,color&0xf);
//			write_framebuffer((es<<4)+((yy*320)+xx), color);

			/* 320*200=64000; / 3 = 21,333R1 */
			/* 65536 / 3 = 21845 R 1 */
			/* so wraps 3 times before updating screen? */
		}
		}

		grsim_update();

		usleep(30000);
		frame++;

		ch=grsim_input();
		if (ch=='q') return 0;
		if (ch==27) return 0;
	}

	return 0;
}
