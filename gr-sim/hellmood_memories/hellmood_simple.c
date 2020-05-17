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

#include <SDL.h>

static unsigned short frame;

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

#if 0

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

#endif

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
	/* tilted plane */
	/* DH=Y, DL=X */
static int fx0(int xx, int yy, int xprime) {

	unsigned short scaled;
	int color;

	yy=yy+0x29;	// add dh,al	; prevent divide overflow
	scaled=((0x1329/yy)&0xff);	// div dh	; reverse divide AL=C/Y'

	color=((signed char)(xprime&0xff))*((signed char)(scaled&0xff));

	scaled-=frame;

	color=(color>>8)&0xff;
	color^=(scaled&0xff);
	color&=0x1c;			// map colors

	return color;
}

/* circles? */
/* DH=Y, DL=X */
static int fx1(int xx, int yy, int xprime) {

	signed short yyy,xxx;
	signed short color;

	yyy=yy-100;		/* align Y vertically */

	yyy=yyy*yyy;
	color=((yyy/256)&0xff);

	/* signed 8-bit multiply */
	xxx=(char)xprime*(char)xprime;
	color+=((xxx/256)&0xff);

	color+=frame;		/* offset color by time */
	color&=0x18;		/* select special rings */

	return color;
}

/* checkers */
static int fx2(int xx, int yy, int xprime) {
	int color;

	color=((yy&0xff)<<8) | (xprime&0xff);
	color=color-frame;		/* adjust with frame */
	color=((color>>8)&0xff)^(color&0xff); /* xor x and y */
	color|=0xdb;	/* or result with 0xdb */
	color+=0x13;	/* Map to yellow/grey */

	return color;

}


/* parallax checkerboard */
static int fx3(int xx,int yy,int xprime) {

	unsigned short color;

	cx=frame;		// mov cx,bp ; set init point to time
	bx=-16;		// mov bx,-16 ; limit to 16 iterations
fx3L:
	cx=cx+(yy*320)+xx;	// add cx, di ; offset by screenpointer
//	ax=0x333;		// mov ax,819 ; magic, related to Rrrola
	ax=0xcccd/64;
	imul_16(cx);	// imul cx ; get X',Y' in DX

	bx++;		// inc bx ; increment iteration count

			// check bottom bit of top word of multiply
			// ja fx3L ; loop until "hit" or "iter=max"
			// jump above, if cf==0 and zf==0

	if ((bx!=0) && ((dx&1)==0)) goto fx3L;

	color=bx+31;	// lea ax,[bx+32] ; map value to standard gray scale
	//printf("%d %d\n",ax,bx);

	return color;
}

/* sierpinski rotozoomer */
static int fx4(int xx, int yy, int xprime) {

	unsigned char dh,bh;
	unsigned short color,t,xsext;
	int temp;

	t=frame-2048;	// lea cx,[bp-2048] ; center time to pass zero
	t=t<<3;	// sal cx,3 ; speed up by factor of 8!

	/* sign extend X */
	xsext=xprime;	// get X into DL
	if (xsext&0x80) xsext|=0xff00;
	else xsext&=0x00ff;

	temp=yy*t;			// temp=Y*T
	bh=(temp>>8)+xsext;		// bh=((y*t)/256)+X

	temp=xsext*t;			// temp=X*T
	dh=(temp>>8)&0xff;		// dh=(X*T/256)

	color=(yy-dh)&bh;		// color=(Y-(X*T/256))&(Y*T/256+X)

			// and al,252  ; thicker sierpinksi
	if ((color&252)==0) {
		color=0x2a;	// otherwise: a nice orange
	}
	else {
		color=0;	//  leave black if not sierpinksi
	}

	return color;
}


/* raycast bent tunnel */
static int fx5(int xx, int yy, int xprime) {

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

/* ocean night */
static int fx6(int xx, int yy, int xprime) {
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




/* raycast bent tunnel */
/* no multiply */
static int fx7(int xx, int yy, int xprime) {

#if 0
	unsigned char al,ah,bl,bh,cl,dl,dh,tb=0;
	unsigned short bp;

//	dx=((yy&0xff)<<8) | (xprime&0xff);

	// dx=y
	// bp=x

	dh=0;
	dl=yy;		// xor dx,dx
	bp=xprime;

	cl=80;		// mov cl,80
	ch=0;		// mov ch,0
	ah=0;		// xor ax,ax
	al=0;
	bh=0;		// xor bx,bx
	bx=0;

L:
	ch=ch-dh;	// sub ch,dh 		ah/ch = x
	ah=ah-0-cf;	// sbb ah,0
	ch=ch+cl;	// add ch,cl		bend with depth
	ah=ah+0+cf;	// adc ah,0

	bl=bl-dl;	// sub bl,dl		bh/bl=y
	bh=bh-0-cf;	// sbb bh,0
	bl=bl+cl;	// add bl,cl		bend with depth
	bh=bh+0+cf;	// adc bh,0
	bl=bl+cl;	// add bl,cl		bend with depth
	bh=bh+0+cf;	// adc bh,0

	al=bh;		// mov al,bh		leave ah,bh untouched
	al=al^ah;	// xor al,ah		geometry check
	al+=4;		// add al,4		geometry check
			// test al,8		geometry check
			// jnz Q
	if (al&8!=0) goto Q;

	cl--;		// dec cl
	if (cl!=0) goto L;

	if ((cl!=0) && (zf==1)) goto L; // loopz L

Q:
	cl=cl-frame;	// probably the timer sub cl,[0x46c]
	al=al^cl;	// xor al,cl
			// aam 6
	al=al+20;	// add al,20
			// stosb
#endif

	return ax;
}

int main(int argc, char **argv) {

	int color=0,which,xx,yy,xprime;

	set_vga_pal();

	mode13h_graphics_init();

//	frame=0x13;
	es=0xa000-10;

	frame=3*512;

	while(1) {
		for(yy=0;yy<200;yy++) {
		for(xx=0;xx<320;xx++) {

			xprime=xx*256/320;
			/* rrolla multiply by 0xcccd trick */

			which=frame/512;
			switch (which&0x7) {
				case 0:	color=fx2(xx,yy,xprime); break;
				case 1:	color=fx1(xx,yy,xprime); break;
				case 2: color=fx0(xx,yy,xprime); break;
				case 3: color=fx3(xx,yy,xprime); break;
				case 4: color=fx4(xx,yy,xprime); break;
				case 5: color=fx5(xx,yy,xprime); break;
				case 6: color=fx6(xx,yy,xprime); break;
				case 7: color=fx7(xx,yy,xprime); break;
				default: printf("Trying effect %d\n",which);
			}
			write_framebuffer((es<<4)+((yy*320)+xx), color);

			/* 320*200=64000; / 3 = 21,333R1 */
			/* 65536 / 3 = 21845 R 1 */
			/* so wraps 3 times before updating screen? */
		}
		}

		mode13h_graphics_update(framebuffer,&pal);

		usleep(10000);
		frame++;

		if (graphics_input()) {
			return 0;
		}
	}

	return 0;
}
