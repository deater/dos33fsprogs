/* Based on code from "32 BASIC Programs for the Apple Computer" 	*/
/*			by Tom Rugg and Phil Feldman			*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch;
	int j,k;
	int t;
	int r,w,c,m,n,l;
	int x,y;

#define S 19
	int a[S+1],b[S+1];

	grsim_init();

	// 120
	gr();
	// 125

	// 130
	x=19,y=19;

label140:
	// 140
	t=rand()%16;

	// 150
	for(j=0;j<=S;j++) {
		a[j]=j;
		b[j]=j;
	}
	// 160+170
	for(j=0;j<=S;j++) {
		r=rand()%(S+1);
		w=a[j];
		a[j]=a[r];
		a[r]=w;
	}
	// 180+190
	for(j=0;j<=S;j++) {
		r=rand()%(S+1);
		w=b[j];
		b[j]=b[r];
		b[r]=w;
	}
	// 200
	for(j=0;j<=S;j++) {
		for(k=0;k<=S;k++) {
			// 210
			r=a[j];
			w=b[k];
			c=r+w+t;
			// 220
			color_equals(c);
			// 240
			if (x+r>40) {
				printf("ERROR! %d %d\n",x,r);
				return -1;
			}
			plot(x+r,y+w);
			plot(x+r,y-w);
			plot(x-r,y-w);
			plot(x-r,y+w);
			plot(x+w,y+r);
			plot(x+w,y-r);
			plot(x-w,y-r);
			plot(x-w,y+r);
			grsim_update();
	//320
		}
	}
	// 350
	for(j=1;j<10;j++) {
		ch=grsim_input();
		if (ch=='q') exit(0);
		if (ch==' ') {
			while(grsim_input()!=' ') usleep(10000);
		}
		usleep(10000);
	}

	// 400
	m=15;
	// 405
	n=(random()%21)+10;
	// 410
	for(j=1;j<=n;j++) {
		r=(random()%22)+1;
		w=random()%m;
		color_equals(w);
		for(l=(y-S);l<=(y+S);l+=(r/4)+1) {
			for(k=(x-S);k<=(x+S);k+=r) {
				plot(k,l);
			}
		}
	}
	goto label140;

	return 0;
}
