#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <math.h>

#include "8086_emulator.h"
#include "vga_emulator.h"

#include "../gr-sim.h"
#include "../tfv_zp.h"

#include "sin1024.h"

#define	MAXDOTS	1024

#define BOTTOM 8000

#define SKIP		2

#define FRAME_SKIP	7

static int write_frame=-1;

static short gravitybottom=BOTTOM;

static short bpmin=30000;
static short bpmax=-30000;
static short gravity=0;
static short dotnum=0;
static short gravityd=16;

//???,-1280,-960,-640,-320};

static short rows[200];

//dot dw	MAXDOTS dup(0,0,0,0,0,0,0,0) ;x,y,z,oldposshadow,oldpos,-,-,-

static struct {
	short	x;	// 0
	short	y;	// 2
	short	z;	// 4
	short	old1;	// 6 oldpos shadow
	short	old2;	// 8 oldpos
	short	old3;	// 10
	short	old4;	// 12
	short	yadd;	// 14
} dot[MAXDOTS];

static short rotsin=0;
static short rotcos=0;

static char *bgpic;

static int depthtable1[128];
static int depthtable2[128];
static int depthtable3[128];

static unsigned char depthtable1_bytes[512];
static unsigned char depthtable2_bytes[512];
static unsigned char depthtable3_bytes[512];

static int shadow[40][48];
static int ball[40][48];
FILE *output;

static void drawdots(void) {
	int temp32;
	int yy;

				//	CBEG
	ax=0xa000;			// mov	ax,0a000h
	es=ax;				// mov	es,ax
	ax=cs;				// mov	ax,cs
	ds=ax;				// mov	ds,ax

	/* why [2]? */
	fs=bgpic[2];			// mov	fs,cs:_bgpic[2]
	cx=dotnum;			// mov	cx,cs:_dotnum
	si=0;				// mov	si,OFFSET dot

label1:
	push(cx);			// push	cx
	ax=dot[si].x;			// mov	ax,ds:[si+0] ;X
	imul_16(rotsin);		// imul	ds:_rotsin
	ax=ax;				// mov	ax,ax
	cx=dx;				// mov	cx,dx
	ax=dot[si].z;			// mov	ax,ds:[si+4] ;Z
	imul_16(rotcos);		// imul	ds:_rotcos
	ax=ax-bx;			// sub	ax,bx
	dx=dx-cx;			// sub	dx,cx
	bp=dx;				// mov	bp,dx
	bp=bp+9000;			// add	bp,9000

	ax=dot[si].x;			// mov	ax,ds:[si+0] ;X
	imul_16(rotcos);		// imul	ds:_rotcos
	bx=ax;				// mov	bx,ax
	cx=dx;				// mov	cx,dx
	ax=dot[si].z;			// mov	ax,ds:[si+4] ;Z
	imul_16(rotsin);		// imul	ds:_rotsin

	temp32=ax+bx;			// add	ax,bx
	ax=ax+bx;			//
	dx=dx+cx;			// adc	dx,cx
	if (temp32&(1<<16)) dx=dx+1;


//	printf("Before: ax=0x%04X dx=%04X\n",ax,dx);
	ax=(ax>>8)|(dx<<8);		// shrd	ax,dx,8
	dx=sar(dx,8);			// sar	dx,8
//	printf("After: ax=0x%04X dx=%04X\n",ax,dx);

	bx=ax;				// mov	bx,ax
	cx=dx;				// mov	cx,dx
	ax=(ax>>3)|(dx<<13);		// shrd	ax,dx,3

	dx=sar(dx,3);			// sar	dx,3
	temp32=ax+bx;			// add	ax,bx
	ax=ax+bx;
	dx=dx+cx;			// adc	dx,cx
	if (temp32&(1<<16)) dx=dx+1;

	temp32=(dx<<16)|(ax&0xfffff);
	idiv_16(bp);			// idiv bp
	ax=ax+160;			// add	ax,160
	push(ax);			// push	ax

	/* if off end of screen, no need for shadow */

	if (ax>319) goto label2;	// cmp	ax,319

					// ja	@@2
	/**********/
	/* shadow */
	/**********/

	ax=0;				// xor	ax,ax
	dx=8;				// mov	dx,8
	idiv_16(bp);			// idiv	bp
	ax=ax+100;			// add	ax,100

	/* if shadow off screen, don't draw */
	if (ax>199) goto label2;	// cmp	ax,199
					// ja	@@2
	bx=ax;				// mov	bx,ax

	// not needed, it's a C array
	//bx=bx<<1;			// shl	bx,1
	bx=rows[bx];			// mov	bx,ds:_rows[bx]
	ax=pop();			// pop	ax
	bx=bx+ax;			// add	bx,ax
	push(ax);			// push	ax

//	printf("Drawing shadow at %d,%d\n",bx%320,bx/320);



	/* erase old shadow (?)*/
	di=dot[si].old1;		// mov	di,ds:[si+6]

	yy=((di/320)*48)/200;
	if (yy>23) color_equals(5);
	else color_equals(0);
	plot( (di%320)/8,yy);

	//ax=bgpic[di];			// mov	ax,fs:[di]
	//framebuffer[di]=ax;		// mov	es:[di],ax

//	framebuffer[di]=bgpic[di];
//	framebuffer[di+1]=bgpic[di+1];
	framebuffer_write(di,bgpic[di]);
	framebuffer_write(di+1,bgpic[di+1]);



	/* draw new shadow (?) */
//	ax=87+87*256;			// mov	ax,87+87*256
//	framebuffer[bx]=ax;		// mov	word ptr es:[bx],ax

//	framebuffer[bx]=87;
//	framebuffer[bx+1]=87;
	framebuffer_write(bx,87);
	framebuffer_write(bx+1,87);

//	bx/320 -> 200     200->48  *48/200

	yy=((bx/320)*48)/200;
	color_equals(0);
	plot( (bx%320)/8,yy);

	shadow[(bx%320)/8][yy]=1;

//	printf("0,%d,%d\n",(bx%320)/8,yy);

//	printf("Plotting at %d,%d\n",(bx%320)/8,(bx/320)/5);

	/* save this to erase next time */
	dot[si].old1=bx;		// mov	ds:[si+6],bx

	/********/
	/* ball */
	/********/
//	ax=gravity;			// mov	ax,ds:_gravity
//	dot[si].yadd+=ax;		// add	ds:[si+14],ax

//	if (si==100) printf("Gravity: %hd (%04x)  Yadd: %hd (%04x)\n",
//			gravity,gravity,dot[si].yadd,dot[si].yadd);

	dot[si].yadd+=gravity;

//	if (si==100) printf("\tyadd after yadd+=gravity: %hd (%04x)\n",
//			dot[si].yadd,dot[si].yadd);

//	ax=dot[si].y;			// mov	ax,ds:[si+2] ;Y
//	ax+=dot[si].yadd;		// add	ax,ds:[si+14]
	ax=dot[si].y+dot[si].yadd;

//	if (si==100) printf("\tax=y+yadd: %hu (%04x) = "
//			"%hd (%04x) + %hd (%04x)\n",
//			ax,ax,dot[si].y,dot[si].y,dot[si].yadd,dot[si].yadd);

//	if (si==100) printf("\tcomparing if (ax<gravitybottom): "
//			"%hu < %hd\n",ax,gravitybottom);


	temp32=ax;
	if (temp32&0x8000) temp32|=0xffff0000;
	if (temp32<gravitybottom) goto label4; //cmp	ax,ds:_gravitybottom
					// jl	@@4

//	if (si==100) printf("\twas greater than (not less)\n");

	push(ax);			// push	ax

//	ax=dot[si].yadd;		// mov	ax,ds:[si+14]
//	ax=-ax;				// neg	ax
	ax=-dot[si].yadd;

//	if (si==100) printf("\tax is -yadd: %hu %x\n",ax,ax);

//	if (si==100) printf("\tabout to multiply gravityd*ax: "
//			"%hd (%x) * %hu (%x)\n",gravityd,gravityd,
//			ax,ax);
	imul_16(gravityd);		// imul	cs:_gravityd

//	if (si==100) printf("\tresult dx:ax is %x:%x (%hu)\n",
//			dx,ax,ax);

	ax=sar(ax,4);			// sar	ax,4

//	if (si==100) printf("\tyadd=(ax>>4 is %x (%hu))\n",
//			ax,ax);
	dot[si].yadd=ax;		// mov	ds:[si+14],ax
	ax=pop();			// pop	ax
//	if (si==100) printf("\trestoring ax=%x, adding yadd %x\n",
//		ax,dot[si].yadd);

	ax+=dot[si].yadd;		// add	ax,ds:[si+14]

//	if (si==100) printf("\tax=%x\n",ax);

label4:
	dot[si].y=ax;			// mov	ds:[si+2],ax

//	if (si==100) printf("\tdot[si].y=%x\n",dot[si].y);

	if (ax&0x8000) {		// cwd
		dx=0xffff;
	}
	else {
		dx=0;
	}

//	if (si==100) printf("\tdx:ax = %04hx:%04hx\n",dx,ax);

	dx=(dx<<6)|(ax>>10);		// shld	dx,ax,6
	ax=ax<<6;			// shl	ax,6

//	if (si==100) printf("\tdx:ax <<6 = %04hx:%04hx, bp=%04hx\n",dx,ax,bp);

	idiv_16(bp);			// idiv	bp
//	if (si==100) printf("\tY ax=%d\n",ax);
	ax=ax+100;			// add	ax,100
	if (ax>199) goto label3;	// cmp	ax,199
					// ja	@@3
//	if (si==100) printf("\tdraw Y ax=%d\n",ax);
	bx=ax;				// mov	bx,ax

	// not needed, C array
	//bx=bx<<1;			// shl	bx,1
	bx=rows[bx];			// mov	bx,ds:_rows[bx]

	ax=pop();			// pop	ax
	bx=bx+ax;			// add	bx,ax

	di=dot[si].old2;		// mov	di,ds:[si+8]
//	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
//	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
//	framebuffer[di+2]=bgpic[di+2];
//	framebuffer[di+3]=bgpic[di+3];

	yy=((di/320)*48)/200;
	if (yy>23) color_equals(5);
	else color_equals(0);
	plot( (di%320)/8,yy);

	framebuffer_write(di,bgpic[di]);
	framebuffer_write(di+1,bgpic[di+1]);
	framebuffer_write(di+2,bgpic[di+2]);
	framebuffer_write(di+3,bgpic[di+3]);




	di=di+320;			// add	di,320
//	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
//	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
//	framebuffer[di+2]=bgpic[di+2];
//	framebuffer[di+3]=bgpic[di+3];

	framebuffer_write(di,bgpic[di]);
	framebuffer_write(di+1,bgpic[di+1]);
	framebuffer_write(di+2,bgpic[di+2]);
	framebuffer_write(di+3,bgpic[di+3]);


	di=di+320;			// add	di,320
//	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
//	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
//	framebuffer[di+2]=bgpic[di+2];
//	framebuffer[di+3]=bgpic[di+3];

	framebuffer_write(di,bgpic[di]);
	framebuffer_write(di+1,bgpic[di+1]);
	framebuffer_write(di+2,bgpic[di+2]);
	framebuffer_write(di+3,bgpic[di+3]);

				//;;	add	di,320
				//;;	mov	eax,fs:[di]
				//;;	mov	es:[di],eax

	bp=bp>>6;		// shr	bp,6
	bp=bp&(~3L);		// and	bp,not 3

	temp32=bp;
	if (temp32&0x8000) temp32|=0xffff0000;
	if (temp32>=bpmin) goto label_t1;	// cmp	bp,cs:_bpmin
					// jge	@@t1
	bpmin=bp;			// mov	cs:_bpmin,bp
label_t1:
	temp32=bp;
	if (temp32&0x8000) temp32|=0xffff0000;
	if (temp32<=bpmax) goto label_t2;	// cmp	bp,cs:_bpmax
					// jle	@@t2
	bpmax=bp;			// mov	cs:_bpmax,bp
label_t2:
//	eax=depthtable1[bp];		// mov	ax,word ptr ds:_depthtable1[bp]
					// mov	word ptr es:[bx+1],ax


	yy=((bx/320)*48)/200;
	color_equals(6);
	plot( (bx%320)/8,yy);

	ball[(bx%320)/8][yy]=1;

//	printf("6,%d,%d\n",(bx%320)/8,yy);

	framebuffer[bx+1]=depthtable1_bytes[bp];
	framebuffer[bx+2]=depthtable1_bytes[bp+1];

	//eax=depthtable2[bp];		// mov	eax,ds:_depthtable2[bp]
					// mov	dword ptr es:[bx+320],eax
	framebuffer[bx+320]=depthtable2_bytes[bp];
	framebuffer[bx+321]=depthtable2_bytes[bp+1];
	framebuffer[bx+322]=depthtable2_bytes[bp+2];
	framebuffer[bx+323]=depthtable2_bytes[bp+3];

//	eax=depthtable3[bp];	// mov	ax,word ptr ds:_depthtable3[bp]
				// mov	word ptr es:[bx+641],ax
	framebuffer[bx+641]=depthtable3_bytes[bp];
	framebuffer[bx+642]=depthtable3_bytes[bp+1];
	dot[si].old2=bx;	// mov	ds:[si+8],bx


//labelz:
	cx=pop();		// pop	cx
	si=si+SKIP;		// add	si,16	point to next dot
	cx=cx-SKIP;
	if (cx!=0) goto label1;	// loop	@@1
label0:
	return;
				// @@0:	CEND

label2:
	/* This is called when we are off the screen */
	/* erases old but didn't draw new */

	/* erase old dot */
	di=dot[si].old2;		// mov	di,ds:[si+8]


	yy=((di/320)*48)/200;
	if (yy>23) color_equals(5);
	else color_equals(0);
	plot( (di%320)/8,yy);

	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
	framebuffer[di+2]=bgpic[di+2];
	framebuffer[di+3]=bgpic[di+3];

	di=di+320;			// add	di,320

	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
	framebuffer[di+2]=bgpic[di+2];
	framebuffer[di+3]=bgpic[di+3];

	di=di+320;			// add  di,320

	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
	framebuffer[di+2]=bgpic[di+2];
	framebuffer[di+3]=bgpic[di+3];

	ax=(framebuffer[di]|(framebuffer[di+1]<<8));

	/* doing something to shadow here? */

	di=dot[si].old1;		// mov	di,ds:[si+6]
	dot[si].old1=ax;		// mov	ds:[si+6],ax

	framebuffer[di]=bgpic[di];	// mov	ax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],ax

	bx=pop();			// pop	bx
	cx=pop();			// pop	cx
	si=si+SKIP;			// add	si,16
	cx=cx-SKIP;			// loop	@@1
	if (cx!=0) goto label1;
	goto label0;			// jmp	@@0

label3:
	/* erase old dot */
	di=dot[si].old2;		// mov	di,ds:[si+8]

	yy=((di/320)*48)/200;
	if (yy>23) color_equals(5);
	else color_equals(0);
	plot( (di%320)/8,yy);

	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
	framebuffer[di+2]=bgpic[di+2];
	framebuffer[di+3]=bgpic[di+3];

	di=di+320;			// add	di,320

	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
	framebuffer[di+2]=bgpic[di+2];
	framebuffer[di+3]=bgpic[di+3];

	di=di+320;			// add	di,320

	framebuffer[di]=bgpic[di];	// mov	eax,fs:[di]
	framebuffer[di+1]=bgpic[di+1];	// mov	es:[di],eax
	framebuffer[di+2]=bgpic[di+2];
	framebuffer[di+3]=bgpic[di+3];

	bx=pop();			// pop	bx
	cx=pop();			// pop	cx
	si=si+SKIP;			// add	si,16
	cx=cx-SKIP;			// loop	@@1
	if (cx!=0) goto label1;
	goto label0;			// jmp	@@0

}

static void setpalette(char *pal) {

	int c;

	// push	bp
	// mov	bp,sp
	// push	si
	// push	di
	// push	ds
	// mov	si,[bp+6]
	// mov	ds,[bp+8]
					// mov	dx,3c8h
					// mov	al,0
	outp(0x3c8,0);			//out	dx,al

	for(c=0;c<768;c++) outp(0x3c9,pal[c]);
	grsim_update();
					// inc	dx
					//mov	cx,768
					//rep	outsb
					//	pop	ds
					//	pop	di
					//	pop	si
					//	pop	bp
					//	ret

}

//short face[]={
//	2248,-2306,0,		// from face.inc
//	30000,30000,30000
//};

/* wait for VGA border start */
static short dis_waitb(void) {

// descr: Waits for border start
// waitb_1 PROC NEAR
//        call    checkkeys

//        IFDEF INDEMO
//        sti
//        mov     ax,cs:copperframecount
//@@v:    cmp     cs:copperframecount,ax
//        je      @@v
//@@q:    mov     ax,cs:copperframecount
//       mov     cs:copperframecount,0
//        ELSE

//        mov     dx,3dah
//@@1:    in      al,dx
//        test    al,8
//        jnz     @@1
//@@2:    in      al,dx
//        test    al,8
 //       jz      @@2

  //      mov     ax,1 ;number of frames taken            ;TEMP!

//        ENDIF
//        ret
//waitb_1 ENDP


	/* approximate by 70Hz sleep */
	usleep(14286);

	return 1;
}

static short dis_exit(void) {
	return 0;
}

static short dis_indemo(void) {
	return 0;
}

//char far *vram=(char far *)0xa0000000L;
static unsigned char *vram=framebuffer;

static char pal[768];
static char pal2[768];

static short isin(short deg) {
	return(sin1024[deg&1023]);
}

static short icos(short deg) {
	return(sin1024[(deg+256)&1023]);
}

static void setborder(short color) {

	//printf("Setting border to %d\n",color);

	// to write attribute register:
	//	read/write address to $3c0
	//	data written to $3c0, read from $3c1
	// flip flop tracks if it's index/data, you reset that
	//	by reading $3da

	//mov	dx,3dah			// input status reg #1
	//in	al,dx			// resets index/addr flip-flop

	//mov	dx,3c0h			// attribute access
	//mov	al,11h+32		// $11=overscan (border color)
					// 32 is PAS bit
	//out	dx,al

	//mov	al,color
	//out	dx,al
}

static short cols[]={
0,0,0,
4,25,30,
8,40,45,
16,55,60};

static short dottaul[1024];

int main(int argc,char **argv) {

//	short timer=30000;
	short dropper,repeat;
	short frame=0;
	short rota=-1*64;
//	short fb=0;
	short rot=0,rots=0;
	short a,b,c,d,i,j=0;//,mode;
	short grav,gravd;
	short f=0;
	int ch;
	int xx,yy;
	unsigned char buffer[10];

	output=fopen("out","w");
	if (output==NULL) {
		fprintf(stderr,"error opening\n");
		exit(1);
	}

	//dis_partstart();

	dotnum=512;
	for(a=0;a<dotnum;a++) {
		dottaul[a]=a;
	}

	for(a=0;a<500;a++) {
		b=rand()%dotnum;
		c=rand()%dotnum;
		d=dottaul[b];
		dottaul[b]=dottaul[c];
		dottaul[c]=d;
	}

	dropper=22000;

	for(a=0;a<dotnum;a++) {
		dot[a].x=0;
		dot[a].y=2560-dropper;
		dot[a].z=0;
		dot[a].yadd=0;
	}
	//mode=7;
	grav=3;
	gravd=13;
	gravitybottom=8105;
	i=-1;

	for(a=0;a<500;a++) { // scramble
		b=rand()%dotnum;
		c=rand()%dotnum;
		d=dot[b].x; dot[b].x=dot[c].x; dot[c].x=d;
		d=dot[b].y; dot[b].y=dot[c].y; dot[c].y=d;
		d=dot[b].z; dot[b].z=dot[c].z; dot[c].z=d;
	}

	/* setup rows lookup table */
	for(a=0;a<200;a++) {
		rows[a]=a*320;
	}

//	set_default_pal();

//	mode13h_graphics_init("dots",2);

	grsim_init();

	gr();

	clear_screens();
	soft_switch(MIXCLR);

	ram[DRAW_PAGE]=0;

	color_equals(5);
	for(a=24;a<48;a++) hlin(0,0,40,a);


//	set mode 13h
//	_asm mov ax,13h
//	_asm int 10h

	/* set palette address to 0 */
	outp(0x3c8,0);

	/* set up colors for first 64 colors */
	for(a=0;a<16;a++) {
		for(b=0;b<4;b++) {
			c=100+a*9;
			outp(0x3c9,cols[b*3+0]);
			outp(0x3c9,cols[b*3+1]*c/256);
			outp(0x3c9,cols[b*3+2]*c/256);
		}
	}

	/* set palette for color 255 */
	outp(0x3c8,255);

	/* some sort of purplish color? */
	outp(0x3c9,31);
	outp(0x3c9,0);
	outp(0x3c9,15);


	/* set colors starting from 64 ... 164 */
	/* looks like a grey gradient of some sort */
	outp(0x3c8,64);

	for(a=0;a<100;a++) {
		c=64-256/(a+4);
		c=c*c/64;
		outp(0x3c9,c/4);
		outp(0x3c9,c/4);
		outp(0x3c9,c/4);
	}

	/* read out the VGA card's idea of palette (?) */
	outp(0x3c7,0);
	for(a=0;a<768;a++) pal[a]=inp(0x3c9);

	/* clear palette to all 0 */
	/* this lets up setup background while not visible */
	outp(0x3c8,0);
	for(a=0;a<768;a++) outp(0x3c9,0);

	/* put grey gradient on bottom half of screen? */
	for(a=0;a<100;a++) {
		memset(vram+(100+a)*320,a+64,320);
	}

	/* set up depth table? */
	/* this has further away balls a darker color */
	for(a=0;a<128;a++) {
		c=a-(43+20)/2;
		c=c*3/4;
		c+=8;
		if(c<0) c=0; else if(c>15) c=15;
		c=15-c;
		depthtable1[a]=0x202+0x04040404*c;
		depthtable2[a]=0x02030302+0x04040404*c;
		depthtable3[a]=0x202+0x04040404*c;
		//depthtable4[a]=0x02020302+0x04040404*c;
	}

	/* make a byte-wise copy of this */
	/* the original code just indexes byte-wise into integer data */
	/* which is a pain */
	for(a=0;a<128;a++) {
		depthtable1_bytes[(a*4)+0]=(depthtable1[a]>>0)&0xff;
		depthtable1_bytes[(a*4)+1]=(depthtable1[a]>>8)&0xff;
		depthtable1_bytes[(a*4)+2]=(depthtable1[a]>>16)&0xff;
		depthtable1_bytes[(a*4)+3]=(depthtable1[a]>>24)&0xff;

		depthtable2_bytes[(a*4)+0]=(depthtable2[a]>>0)&0xff;
		depthtable2_bytes[(a*4)+1]=(depthtable2[a]>>8)&0xff;
		depthtable2_bytes[(a*4)+2]=(depthtable2[a]>>16)&0xff;
		depthtable2_bytes[(a*4)+3]=(depthtable2[a]>>24)&0xff;

		depthtable3_bytes[(a*4)+0]=(depthtable3[a]>>0)&0xff;
		depthtable3_bytes[(a*4)+1]=(depthtable3[a]>>8)&0xff;
		depthtable3_bytes[(a*4)+2]=(depthtable3[a]>>16)&0xff;
		depthtable3_bytes[(a*4)+3]=(depthtable3[a]>>24)&0xff;



	}


	/* allocate space for background */
	//bgpic=halloc(64000L,1L);
	bgpic=calloc(65536L,1L);

	/* backup background */
	memcpy(bgpic,vram,64000);

	grsim_update();

	/* Fade back in from black to palette */
	a=0;
	for(b=64;b>=0;b--) {
		for(c=0;c<768;c++) {
			a=pal[c]-b;
			if(a<0) a=0;
			pal2[c]=a;
		}
		/* wait for retrace (delay) */
		dis_waitb();
		dis_waitb();
		outp(0x3c8,0);
		for(c=0;c<768;c++) outp(0x3c9,pal2[c]);
		grsim_update();
	}

	while(!dis_exit() && frame<2450) {

		for(xx=0;xx<40;xx++) {
			for(yy=0;yy<48;yy++) {
				shadow[xx][yy]=0;
				ball[xx][yy]=0;
			}
		}

		/* code sets border color */
		/* then waits for it to end, as a timing thing? */
		setborder(0);

		/* when not in demo this defaults to 1? */
		repeat=dis_waitb();

		if(frame>2300) setpalette(pal2);

		setborder(1);

		if(dis_indemo()) {
			/* ?? music synchronization? */
//			a=dis_musplus();
//			if(a>-4 && a<0) break;
		}

		repeat=1;

		while(repeat--) {

		frame++;
		if(frame==500) f=0;
		i=dottaul[j];
		j++; j%=dotnum;

		/* initial spin */
		if(frame<500) {
			dot[i].x=isin(f*11)*40;
			dot[i].y=icos(f*13)*10-dropper;
			dot[i].z=isin(f*17)*40;
			dot[i].yadd=0;
//			printf("%d: %d,%d,%d,%d\n",i,
//				dot[i].x,dot[i].y,dot[i].z,dot[i].yadd);
		}
		/* bouncing ring */
		else if(frame<900) {
			dot[i].x=icos(f*15)*55;
			dot[i].y=dropper;
			dot[i].z=isin(f*15)*55;
			dot[i].yadd=-260;
		}
		/* fountain */
		else if(frame<1700) {
			a=sin1024[frame&1023]/8;
			dot[i].x=icos(f*66)*a;
			dot[i].y=8000;
			dot[i].z=isin(f*66)*a;
			dot[i].yadd=-300;
		}
		/* swirling */
		else if(frame<2360) {
				/*
				a=rand()/128+32;
				dot[i].y=8000-a*80;
				b=rand()&1023;
				a+=rand()&31;
				dot[i].x=sin1024[b]*a/3+(a-50)*7;
				dot[i].z=sin1024[(b+256)&1023]*a/3+(a-40)*7;
				dot[i].yadd=300;
				if(frame>1640 && !(frame&31) && grav>-2) grav--;
				*/
			dot[i].x=rand()-16384;
			dot[i].y=8000-rand()/2;
			dot[i].z=rand()-16384;
			dot[i].yadd=0;
			if(frame>1900 && !(frame&31) && grav>0) grav--;
		}
		/* palette to white */
		else if(frame<2400) {
			a=frame-2360;
			for(b=0;b<768;b+=3) {
				c=pal[b+0]+a*3;
				if(c>63) c=63;
				pal2[b+0]=c;
				c=pal[b+1]+a*3;
				if(c>63) c=63;
				pal2[b+1]=c;
				c=pal[b+2]+a*4;
				if(c>63) c=63;
				pal2[b+2]=c;
			}
		}
		/* palette to black */
		else if(frame<2440) {
			a=frame-2400;
			for(b=0;b<768;b+=3) {
				c=63-a*2;
				if(c<0) c=0;
				pal2[b+0]=c;
				pal2[b+1]=c;
				pal2[b+2]=c;
			}
		}
		if(dropper>4000) dropper-=100;

		rotcos=icos(rot)*64; rotsin=isin(rot)*64;
		rots+=2;

		if(frame>1900) {
			rot+=rota/64;
			rota--;
		}
		else rot=isin(rots);

		f++;
		gravity=grav;
		gravityd=gravd;

		}


		drawdots();

		grsim_update();


//		fprintf(output,"Frame %d\n",frame);
//		fprintf(output,"\tShadow\n");

		write_frame++;
		if (write_frame==FRAME_SKIP ) {
			write_frame=0;
		}

		if (write_frame==0) {

#if 0
		int new_row=1;

		/* Shadow */
		buffer[0]=0xfe;
		fwrite(buffer,1,sizeof(char),output);
		for(yy=0;yy<48;yy++) {
			new_row=1;
			for(xx=0;xx<40;xx++) {
				if ((!ball[xx][yy]) && (shadow[xx][yy])) {
					if (new_row) {
						buffer[0]=(yy|0x40);
						fwrite(buffer,1,sizeof(char),output);
						new_row=0;
					}
					buffer[0]=(xx);
					fwrite(buffer,1,sizeof(char),output);
				}
			}
		}
		/* Balls */
		buffer[0]=0xfd;
		fwrite(buffer,1,sizeof(char),output);
		for(yy=0;yy<48;yy++) {
			new_row=1;
			for(xx=0;xx<40;xx++) {
				if (ball[xx][yy]) {
					if (new_row) {
						buffer[0]=(yy|0x40);
						fwrite(buffer,1,sizeof(char),output);
						new_row=0;
					}
					buffer[0]=xx;
					fwrite(buffer,1,sizeof(char),output);

				}
			}
		}

#endif

		int new_row=1;

		/* Shadow */
		buffer[0]=0xfe;
		fwrite(buffer,1,sizeof(char),output);
		for(yy=0;yy<24;yy++) {
			new_row=1;
			for(xx=0;xx<40;xx++) {
				/* cases: */
				/*   shadow        ball        action */
				/*  top bottom	top bottom            */
				/*   0    0      0    0          none */
				/*   0    0      0    1          none */
				/*   0    0      1    0          none */
				/*   0    0      1    1          none */
				/*   0    1      0    0          bot  1 */
				/*   0    1      0    1          none */
				/*   0    1      1    0          both 4 */
				/*   0    1      1    1          none */
				/*   1    0      0    0          top  2 */
				/*   1    0      0    1          both 5 */
				/*   1    0      1    0          none */
				/*   1    0      1    1          none */
				/*   1    1      0    0          both 3 */
				/*   1    1      0    1          both 3 */
				/*   1    1      1    0          both 3 */
				/*   1    1      1    1          none */

				/* case 1/4 */
				if ( (shadow[xx][yy*2]==0) &&
					(shadow[xx][(yy*2)+1]==1) ) {

					/* case 1 -- bottom */
					if ( (ball[xx][(yy*2)]==0) &&
						(ball[xx][(yy*2)+1]==0)) {

						if (new_row) {
							buffer[0]=yy;
							fwrite(buffer,1,
								sizeof(char),
								output);
							new_row=0;
						}

						buffer[0]=(xx|0x40);
						fwrite(buffer,1,sizeof(char),
							output);

					}

					/* case 4 -- both */
					if ( (ball[xx][(yy*2)]==1) &&
						(ball[xx][(yy*2)+1]==0) ) {

						if (new_row) {
							buffer[0]=yy;
							fwrite(buffer,1,
								sizeof(char),
								output);
							new_row=0;
						}

						buffer[0]=(xx|0xC0);
						fwrite(buffer,1,sizeof(char),
							output);

					}

				}
				/* case 2/5 */
				else if ( (shadow[xx][yy*2]==1) &&
					(shadow[xx][(yy*2)+1]==0) ) {

					/* case 2 -- top */
					if ( (ball[xx][(yy*2)]==0) &&
						(ball[xx][(yy*2)+1]==0) ) {

						if (new_row) {
							buffer[0]=yy;
							fwrite(buffer,1,
								sizeof(char),
								output);
							new_row=0;
						}

						buffer[0]=(xx|0x80);
						fwrite(buffer,1,sizeof(char),
							output);

					}

					/* case 5 -- both */
					if ( (ball[xx][(yy*2)]==0) &&
						(ball[xx][(yy*2)+1]==1) ) {

						if (new_row) {
							buffer[0]=yy;
							fwrite(buffer,1,
								sizeof(char),
								output);
							new_row=0;
						}

						buffer[0]=(xx|0xC0);
						fwrite(buffer,1,sizeof(char),
							output);

					}

				}
				/* case 3 */
				else if ( (shadow[xx][yy*2]==1) &&
					(shadow[xx][(yy*2)+1]==1) ) {

					/* case 2 -- top */
					if ( (ball[xx][(yy*2)]==1) &&
						(ball[xx][(yy*2)+1]==1) ) {
					}
					else {
						if (new_row) {
							buffer[0]=yy;
							fwrite(buffer,1,
								sizeof(char),
								output);
							new_row=0;
						}

						buffer[0]=(xx|0xc0);
						fwrite(buffer,1,sizeof(char),
							output);

					}

				}


			}
		}

		/* Balls */
		buffer[0]=0xfd;
		fwrite(buffer,1,sizeof(char),output);
		for(yy=0;yy<24;yy++) {
			new_row=1;
			for(xx=0;xx<40;xx++) {
				/* cases: */
				/*   shadow        ball        action */
				/*  top bottom	top bottom            */
				/*   X    X      0    0          none */
				/*   X    X      0    1          bot  1 */
				/*   X    X      1    0          top  2 */
				/*   X    X      1    1          both 3 */

				/* case 1 -- bottom */
				if ( (ball[xx][(yy*2)]==0) &&
					(ball[xx][(yy*2)+1]==1)) {

					if (new_row) {
						buffer[0]=yy;
						fwrite(buffer,1,sizeof(char),
								output);
						new_row=0;
					}

					buffer[0]=(xx|0x40);
					fwrite(buffer,1,sizeof(char),
							output);

				}
				/* case 2 -- top */
				else if ( (ball[xx][(yy*2)]==1) &&
						(ball[xx][(yy*2)+1]==0) ) {

					if (new_row) {
						buffer[0]=yy;
						fwrite(buffer,1,sizeof(char),
								output);
						new_row=0;
					}

					buffer[0]=(xx|0x80);
					fwrite(buffer,1,sizeof(char),
							output);

				}
				/* case 3 */
				else if ( (ball[xx][(yy*2)]==1) &&
						(ball[xx][(yy*2)+1]==1) ) {
					if (new_row) {
						buffer[0]=yy;
						fwrite(buffer,1,sizeof(char),
								output);
						new_row=0;
					}

					buffer[0]=(xx|0xc0);
					fwrite(buffer,1,sizeof(char),
							output);

				}

			}
		}


		}

//again:
		ch=grsim_input();
		if (ch==27) {
			return 0;
		}
//		else if (ch==0) goto again;

	}

	buffer[0]=0xff;
	fwrite(buffer,1,sizeof(char),output);

	fclose(output);

	return 0;
}
