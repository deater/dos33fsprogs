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


int main(int argc, char **argv) {

	int ch;
	int n,i,j;
	double r,rr,t,xx=0,u=0,v=0;//,sz,sw,sh;

	grsim_init();

	printf("XX=%lf\n",xx);

	// HCOLOR=7
	hcolor_equals(7);

	// N=200:R=6.28/235:T=0:SZ=200:SW=280/SZ:SH=SCRH/SZ
	n=32;	r=6.28/235.0;
	t=0;

	// HGR2:FOR I=0 TO N:RR=R*I:FOR J=0 TO N

	hgr();
	soft_switch(MIXCLR);
	while(1) {
		hclr();

		clear_screens();
		for(i=0;i<n;i++) {
			rr=r*i;
			for(j=0;j<n;j++) {
				//U=SIN(I+V)+SIN(RR+X)
				u=sin(i+v)+sin(rr+xx);
				//V=COS(I+V)+COS(RR+X)
				v=cos(i+v)+cos(rr+xx);
				// X=U+T
				xx=u+t;
				//HPLOT 32*U+140,32*V+96
				hplot(48*u+140,48*v+96);
			}


		}
			grsim_update();
			usleep(100000);

			ch=grsim_input();
			if (ch=='q') exit(0);
		t=t+.025;

	}

	return 0;
}
