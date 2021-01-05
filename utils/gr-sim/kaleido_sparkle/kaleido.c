/* Based on code from "32 BASIC Programs for the Apple Computer" 	*/
/*			by Tom Rugg and Phil Feldman			*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

static int r[11];
static int xx,yy,j,aa,b,x2,y2,n;

static void tooo(void) {

	color_equals(r[n]);
	basic_plot(x2,y2);
	grsim_update();
	return;
}

static void noo(void) {
	//int t;
	int w;

	// 900
	color_equals(r[0]);
	basic_plot(xx,yy);
	grsim_update();
	if (j==1) return;
	// 920
	w=j/2;
	//t=j-w-1;

	// 930
	for(n=1;n<=w;n++) {
		if (xx==aa) {
			y2=yy; x2=xx+n; tooo();
			x2=xx-n;		tooo();
			continue;
		}
		if (yy==b) {
			x2=xx; y2=yy+n; tooo();
			y2=yy-n;		tooo();
			continue;
		}
		y2=yy;
		if (xx<aa) {
			x2=xx+n;	tooo();
		}
		else {
			x2=xx-n; tooo();
		}
		// 990
		x2=xx;
		if (yy<b) {
			y2=yy+n; tooo();
		}
		else {
			y2=yy-n; tooo();
		}
	}

	return;

}

int main(int argc, char **argv) {

	int ch;
	int p,d,m,k,l;

	grsim_init();

	// 120
	home();
	gr();
	// 125
	p=19;

	// 130
	aa=p; b=p; d=-1;

	// 135
	m=15;

label150:

	// 150
	for(j=0;j<=10;j++) {
		r[j]=rand()%m;
	}

	// 180
	d=-d; k=1; l=p;
	if (d<=0) {
		k=p;l=1;
	}
	// 200
	for(j=k;j<=l;j+=d) {
		xx=aa+j; yy=b;	noo();
		xx=aa-j;		noo();
		xx=aa; yy=b+j;	noo();
		yy=b-j;		noo();
		xx=aa+j;yy=b+j;	noo();
		xx=aa-j;yy=b-j;	noo();
		yy=b+j;		noo();
		xx=aa+j; yy=b-j;	noo();
	}

	for(j=1;j<10;j++) {
		ch=grsim_input();
		if (ch=='q') exit(0);
		if (ch==' ') {
			while(grsim_input()!=' ') usleep(10000);
		}
		usleep(10000);
	}

	goto label150;

	return 0;
}
