/* Bubble */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#define NUM	32

static double fixed_to_float(int8_t hi, uint8_t lo) {

	int temp=(hi<<8)|lo;

	return temp/256.0;

}

static void float_to_fixed(double input, int8_t *hi, uint8_t *lo) {

	int temp;

	if (input>255) printf("float_to_fixed: %lf too big\n",input);
	if (input<-255) printf("float_to_fixed: %lf too small\n",input);

	temp=input*256;

	*hi=temp>>8;
	*lo=temp&0xff;

	return;

}

static void fixed_add(int8_t add1h,uint8_t add1l,
			int8_t add2h,uint8_t add2l,
			int8_t *outh,uint8_t *outl) {

	int a1,a2,s;

	a1=(add1h<<8)|add1l;
	a2=(add2h<<8)|add2l;

	s=a1+a2;

	*outh=(s>>8)&0xff;
	*outl=(s&0xff);

}




int main(int argc, char **argv) {

	int ch;
	int i,j;
	double r,u=0;

	int8_t  th,xh,rxh,ivh,vh,uh,rh[NUM];
	uint8_t tl,xl,rxl,ivl,vl,ul,rl[NUM];

	grsim_init();

	// HCOLOR=7
	hcolor_equals(7);

	// N=200:R=6.28/235:T=0:SZ=200:SW=280/SZ:SH=SCRH/SZ
	r=6.28/256.0;
	th=0; tl=0;
	uh=0; ul=0;
	vh=0; vl=0;
	xh=0; xl=0;
	rxh=0; rxl=0;

	for(i=0;i<NUM;i++) {
		float_to_fixed(r*i,&rh[i],&rl[i]);
	}

	// HGR2:FOR I=0 TO N:RR=R*I:FOR J=0 TO N

	hgr();
	soft_switch(MIXCLR);
	while(1) {
		hclr();
		for(i=0;i<NUM;i++) {

			for(j=0;j<NUM;j++) {

				fixed_add(rh[i],rl[i],xh,xl,&rxh,&rxl);

				fixed_add(i,0,vh,vl,&ivh,&ivl);

				//U=SIN(I+V)+SIN(RR+X)
				u=sin(fixed_to_float(ivh,ivl)) +
					sin(fixed_to_float(rxh,rxl));
				//V=COS(I+V)+COS(RR+X)
				float_to_fixed(
					(cos(fixed_to_float(ivh,ivl)) +
					cos(fixed_to_float(rxh,rxl))),
					&vh,&vl);

				// X=U+T
				//float_to_fixed( (u+fixed_to_float(th,tl)),&xh,&xl);

				fixed_add(uh,ul,th,tl,&xh,&xl);

				//HPLOT 32*U+140,32*V+96
				hplot(48*u+140,48*fixed_to_float(vh,vl)+96);
			}


		}

		grsim_update();
		usleep(100000);

		ch=grsim_input();
		if (ch=='q') exit(0);

		//t=t+(1.0/32.0);
		// 1/2 1/4 1/8 1/16 | 1/32 1/64 1/128 1/256
		if (tl>=0xf8) th=th+1;
		tl=tl+0x08;
//		printf("%x %x\n",th,tl);
	}

	return 0;
}
