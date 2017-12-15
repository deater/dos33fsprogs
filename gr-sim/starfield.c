#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

#define NUMSTARS	64

struct star_type {
	double x;
	double y;
	double z;
};

static struct star_type stars[NUMSTARS];

int main(int argc, char **argv) {

	int ch,i;

	int spreadx=40;
	int spready=40;
	int spreadz=5;

	grsim_init();

	for(i=0;i<NUMSTARS;i++) {
		stars[i].x=(drand48()-0.5)*spreadx;
		stars[i].y=(drand48()-0.5)*spready;
		stars[i].z=((drand48())*spreadz)+0.1;
		printf("%.2lf,%2lf,%.2lf\n",stars[i].x,stars[i].y,stars[i].z);
	}
	gr();


	while(1) {
		gr();

		for(i=0;i<NUMSTARS;i++) {
			if (stars[i].z<2) color_equals(15);
			else if (stars[i].z<3) color_equals(7);
			else color_equals(5);
			basic_plot(stars[i].x/stars[i].z+20,
					stars[i].y/stars[i].z+20);
		}

		for(i=0;i<NUMSTARS;i++) {
			stars[i].z+=-0.125;
			if (stars[i].z<0) {
				stars[i].x=(drand48()-0.5)*spreadx;
				stars[i].y=(drand48()-0.5)*spready;
				stars[i].z=((drand48())*spreadz)+0.1;
			}
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(30000);
	}

	return 0;
}
