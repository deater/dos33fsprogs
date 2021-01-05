/* Hellmood's Autumn demo */
/* trying to convert it to C because he says it's straightforward */

#include <stdio.h>

static short ax=0,bx=0,cx=0,dx=0,di=0,sp=0;
static short stack[64];
static int cf=0,newcf,ebp=0;
static signed char ah,al;

static void push(short value) {

	stack[sp]=value;
	sp++;
}

static short pop(void) {
	sp--;
	if (sp<0) {
		printf("Stack underflow!\n");
		return 0;
	}
	return stack[sp];
}

static int debug=0;

int main(int argc, char **argv) {



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
	push(cx);		// push   %cx
	cx=cx-dx;		// sub    %dx,%cx
	if (cx&0x8000) {
		cx=cx>>1;
		cx|=0x8000;
	}
	else {
		cx=cx>>1;
	}
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
	al=ax&0xff;
	ah=(ax&0xff)/0x29;
	al=(ax&0xff)%0x29;	// aam    $0x29
	ax=(ah<<8)|(al&0xff);
	al=al&0xfc;		// and    $0xfc,%al
	al=al^0x12;		// xor    $0x12,%al
	ax=(ah<<8)|(al&0xff);

	if ((dx&0x8000)!=0) goto label_108;
				// test   $0x80,%dh
				// jmp if zf==0 jne    0x108
	if ((cx&0xf000)!=0) goto label_108;
				// test   $0xf0,%ch
				// jmp if zf==0 jne    0x108


//put_pixel:
	push(ax);		//	push   %ax
	printf("Putpixel (%d) %d,%d = %d\n",bx>>8,cx,dx,ax&0xf);

				// and    $0xf,%al		; al = color
				// mov    $0xc,%ah		; ah = 0xc = putpixel
				// int    $0x10		; bh=page number, cx=x,dx=y
	ax=pop();		// pop    %ax


#if 0
check_keyboard:
	mov    $0x1,%ah
	int    $0x16
#endif
	//ax=0;
	goto label_108;		// je     0x108
}
