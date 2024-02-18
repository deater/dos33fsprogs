/* Bubble */

/* based on updated TIC-80 version by serato_fig */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#define NUM	20

#define PI	3.14159265358978323846264

uint8_t s=41;//s=41;
	// ; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28


uint8_t sine(uint8_t x) {

	return floor(s*sin((x-96)*PI*2/256.0)+48.5);

}

uint8_t cose(uint8_t x) {

	return floor(s*cos((x-96)*PI*2/256.0)+48.5);

}


int main(int argc, char **argv) {

	int ch;
	int i,j;


	uint8_t	u=0,v=0,t=0,a,b;

	uint8_t sines[256];
	uint8_t cosines[256];

	grsim_init();

	// HCOLOR=7
	hcolor_equals(7);


	for(i=0;i<256;i++) {
		sines[i]=sine(i);
		cosines[i]=cose(i);
	}

#if 0
	printf("sines:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) printf("\t.byte ");
		printf("$%02X",sines[i]);
		if (i%16==15) printf("\n");
		else printf(",");
	}
	printf("cosines:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) printf("\t.byte ");
		printf("$%02X",cosines[i]);
		if (i%16==15) printf("\n");
		else printf(",");
	}
#endif

	// HGR2:FOR I=0 TO N:RR=R*I:FOR J=0 TO N

	hgr();
	soft_switch(MIXCLR);
	while(1) {
		hclr();
		for(i=0;i<NUM;i++) {

			for(j=0;j<NUM;j++) {

				a=i*s+v;
				b=i+t+u;

				u=sines[a]+sines[b];
				v=cosines[a]+cosines[b];

			//	printf("%d %d\n",u,v);

				//HPLOT 32*U+140,32*V+96

				if (v>192) printf("V out of range %d\n",v);
				hplot(u+44,
					v);
			}


		}

		grsim_update();
		usleep(100000);

		ch=grsim_input();
		if (ch=='q') exit(0);

		t=t+1;

	}

	return 0;
}
