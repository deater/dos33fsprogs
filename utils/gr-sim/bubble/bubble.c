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

int8_t fsinh[256];

double sine(int8_t fh, uint8_t fl) {

	double f;
	int i;
	int i1,i2;
	int8_t sh;
	uint8_t sl;

//	f=(fh<<8)|fl;
//	f=f/256.0;

//	i=f;

	i=(fh<<8)|fl;

	// /6.28,  0=0, 6.28=0xff

	// .035
	//		 = .5 .25 .125 .0625 .03125
	// 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28

	//	8.8 * 8.8 = 16.16

//	i=(i/6.28);

//	i=(i/8.0);

//	i=i*0.15625;

//	i=(i*0x28)>>8;

	i1=i<<5;
	i2=i<<3;

	i=(i1+i2)>>8;

	i=i&0xff;

//	i=i&0xff;

//	f=(fsinh[i]/128.0);

	sl=fsinh[i];
	if (sl&0x80) sh=0xff;
	else sh=0x00;
	sl=sl<<1;

	f=fixed_to_float(sh,sl);

	return f;

//	f=fixed_to_float(fh,fl);
//	return sin(f);


}

double cose(int8_t fh, uint8_t fl) {

	int8_t temph;
	uint8_t templ;

//	double f;
//	int i;

//	i=(fh<<8)|fl;

//	i=((i>>4)+64)&0xff;

//	f=(fh<<8)|fl;
//	f=f/256.0;
//	i=f/6.28;

//	i=(i+64)&0xff;

//	f=(fsinh[i]/128.0);

//	return f;

//	1.57 is roughly 0x0192 in 8.8

	fixed_add(fh,fl,0x1,0x92,&temph,&templ);

	return sine(temph,templ);


}


int main(int argc, char **argv) {

	int ch;
	int i,j;
	double r;

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

	for(i=0;i<256;i++) {
		fsinh[i]=(128*sin(6.28*i/256.0));
	}
//	for(i=0;i<256;i++) printf("%d\n",fsinh[i]);

	for(i=0;i<NUM;i++) {
		float_to_fixed(r*i,&rh[i],&rl[i]);
	}

#if 0
	printf("rh:\n");
	printf(".byte\t");
	for(i=0;i<NUM;i++) {
		printf("$%02X,",rh[i]);
	}
	printf("\n");

	printf("rl:\n");
	printf(".byte\t");
	for(i=0;i<NUM;i++) {
		printf("$%02X,",rl[i]);
	}
	printf("\n");

	printf("sin:\n");
	printf(".byte\t");
	for(i=0;i<256;i++) {
		printf("$%02X,",(fsinh[i]&0xff));
	}
	printf("\n");


#endif

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
				float_to_fixed(
					sine(ivh,ivl) +
					sine(rxh,rxl),
					&uh,&ul);

				//V=COS(I+V)+COS(RR+X)
				float_to_fixed(
					cose(ivh,ivl) +
					cose(rxh,rxl),
					&vh,&vl);

				// X=U+T
				//float_to_fixed( (u+fixed_to_float(th,tl)),
				//		&xh,&xl);

				fixed_add(uh,ul,th,tl,&xh,&xl);

				//HPLOT 32*U+140,32*V+96
				hplot(48*fixed_to_float(uh,ul)+140,
					48*fixed_to_float(vh,vl)+96);
			}


		}

		grsim_update();
		usleep(100000);

		ch=grsim_input();
		if (ch=='q') exit(0);

		//t=t+(1.0/32.0);
		// 1/2 1/4 1/8 1/16 | 1/32 1/64 1/128 1/256

		fixed_add(th,tl,0,0x8,&th,&tl);

//		printf("%x %x\n",th,tl);
	}

	return 0;
}
