#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <math.h>

#include "../gr-sim.h"
#include "../tfv_zp.h"

int main(int argc,char **argv) {

	int ch,y,j;
	double pi=3.14,f,e,m,n,s,t,q,r;
	double a[64*48],b[64*48];

	grsim_init();

	gr();

	j=0;
	for(e=0;e<pi*2.0;e+=0.1) {
		m=15.0+cos(e)*12.0;
		n=pi-sin(e)*pi;
		for(y=0;y<48;y++) {
			f=(double)y*0.5/m-n;
			a[j]=8.0*cos(f);
			b[j]=8.0*sin(f);
			j++;
		}
	}



	clear_screens();
	soft_switch(MIXCLR);

	ram[DRAW_PAGE]=0;

	while(1) {
	j=0;
	for(e=1;e<63;e++) {
		for(y=0;y<48;y++) {
			s=20-a[j];
			t=20-b[j];
			q=20+a[j];
			r=20+b[j];

			/* re-draw background */
			color_equals(0);
			hlin(0,12,27,y);

			color_equals(1);
			m=s; n=t;
			if (q<r) { m=q; n=r;}
			hlin(0,m,n,y);

			color_equals(2);
			if (r<s) { t=r; q=s;}
			hlin(0,t,q,y);

			j++;

		}
		grsim_update();

		/* approximate 50Hz sleep */
//		usleep(20000);
		usleep(40000);

		ch=grsim_input();
		if (ch==27) {
			return 0;
		}
	}

	}

	return 0;
}
