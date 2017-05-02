/* Based on code from "32 BASIC Programs for the Apple Computer" 	*/
/*			by Tom Rugg and Phil Feldman			*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

static int r[11];
static int x,y,j,a,b,x2,y2,n;

static void tooo(void) {

	color_equals(r[n]);
	plot(x2,y2);
	grsim_update();
	return;
}

static void noo(void) {
	int t,w;

	// 900
	color_equals(r[0]);
	plot(x,y);
	grsim_update();
	if (j==1) return;
	// 920
	w=j/2;
	t=j-w-1;
	// 930
	for(n=1;n<=w;n++) {
		if (x==a) {
			y2=y; x2=x+n; tooo();
			x2=x-n;		tooo();
			continue;
		}
		if (y==b) {
			x2=x; y2=y+n; tooo();
			y2=y-n;		tooo();
			continue;
		}
		y2=y;
		if (x<a) {
			x2=x+n;	tooo();
		}
		else {
			x2=x-n; tooo();
		}
		// 990
		x2=x;
		if (y<b) {
			y2=y+n; tooo();
		}
		else {
			y2=y-n; tooo();
		}
	}

	return;

}

int main(int argc, char **argv) {

	int ch;
	int p,d,m,k,l;

	grsim_init();

	// 120
	gr();
	// 125
	p=19;

	// 130
	a=p; b=p; d=-1;

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
		x=a+j; y=b;	noo();
		x=a-j;		noo();
		x=a; y=b+j;	noo();
		y=b-j;		noo();
		x=a+j;y=b+j;	noo();
		x=a-j;y=b-j;	noo();
		y=b+j;		noo();
		x=a+j; y=b-j;	noo();
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
