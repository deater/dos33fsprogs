#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <math.h>

//#include "../gr-sim.h"
//#include "../tfv_zp.h"

unsigned char ram[40][48];


int hlin(int color,int x1, int x2, int y) {

	int j;

	for(j=x1;j<x2;j++) ram[j][y]=color;

	return 0;
}

int main(int argc,char **argv) {

	int xx,yy,temp;
	int total_bytes=0;
	int y,j,color,old,run;
	double pi=3.14,f,e,m,n,s,t,q,r;
	double a[64*48],b[64*48];

//	grsim_init();

//	gr();

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



//	clear_screens();
//	soft_switch(MIXCLR);

//	ram[DRAW_PAGE]=0;

//	while(1) {
	j=0;
	for(e=0;e<63;e++) {
		for(y=0;y<48;y++) {
			s=20-a[j];
			t=20-b[j];
			q=20+a[j];
			r=20+b[j];

			/* re-draw background */
			color=0;
			hlin(color,12,27,y);

			color=1;
			m=s; n=t;
			if (q<r) { m=q; n=r;}
			hlin(color,m,n,y);

			color=2;
			if (r<s) { t=r; q=s;}
			hlin(color,t,q,y);

			j++;

		}
//		grsim_update();

		printf("; Frame %d\n",(int)e);
		for(yy=0;yy<24;yy++) {
			old=0xff; run=0;
			printf(".byte ");
			for(xx=12;xx<27;xx++) {
				temp=(ram[xx][(yy*2)+1]<<4)+
						(ram[xx][(yy*2)]);
				if (temp!=old) {
					if (xx!=12) printf(",");
					printf("$%02X",temp);
					total_bytes++;
					old=temp;
				}
			}
			printf("\n");
		}


		/* approximate 50Hz sleep */
//		usleep(20000);
//		usleep(40000);

//		ch=grsim_input();
//		if (ch==27) {
//			return 0;
//		}
	}

	printf("; Total bytes = %d\n",total_bytes);

//	}

	return 0;
}
