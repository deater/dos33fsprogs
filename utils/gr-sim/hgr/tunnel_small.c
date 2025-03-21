#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"


//		hcolor_equals(color_group*4);
//		hplot(x_even_older,y_even_older);
//		hplot_to(x_old,y_old);

#define NUM_STARS	20
#define	NUM_POINTS	32

#define MIN_Z		10
#define MAX_Z		2500

#define	Z_SPEED		10
#define RADIUS		320

#define AMP_MUL 64

static short star_x[NUM_STARS];
static short star_y[NUM_STARS];
static int star_z[NUM_STARS];

int main(int argc, char **argv) {

	int ch,i,star_count;
	double x,y,p;
	double pi2=6.28;

	grsim_init();

	home();
	hgr();
	soft_switch(MIXCLR);	// Full screen
	hcolor_equals(3);

	double angle=0,amplitude_angle=0,horizontal_angle=0,vertical_angle= 0;

	short int zadd = ((MAX_Z - MIN_Z) / NUM_STARS);
	short int current_z=MIN_Z+1;

	for (i = 0; i < NUM_STARS; i++) {
		star_x[i]=0;
		star_y[i]=0;
		star_z[i] = current_z;
		printf("%d %d\n",i,star_z[i]);
		current_z+=zadd;
	}


	for(i=0;i<255;i++) {
	//	printf("%d: %d %lf\n",i,i*10,
	//		RADIUS*1.0/i*10);
		printf("%d, ",(int)(RADIUS*1.0/i*10));
	}
	printf("\n");

	/* Lookup tables needed */
	// AMP_MUL * sin (amplitude_angle)
	// sin(angle)
	// AMP_MUL * sin(horizontal_angle)
	// AMP_MUL * sin(vertical_angle)
	// cos(angle)

	while(1) {

		/* Process Starfield */
		for (star_count = 0; star_count < NUM_STARS; star_count++) {
			star_z[star_count] -= Z_SPEED;

			if (star_z[star_count] <= MIN_Z) {
				star_z[star_count] = (MAX_Z-MIN_Z);

				// 100 + +/-64 + +/-64
				star_x[star_count] = (140 +
					AMP_MUL * sin(amplitude_angle)) *
					sin(angle) +
					AMP_MUL * sin(horizontal_angle);

				star_y[star_count] = (96 +
					AMP_MUL * sin(amplitude_angle)) *
					sin(angle)+ //cos(angle) +
					AMP_MUL * sin(vertical_angle);

				printf("New: %d %d\n",
					star_x[star_count],
					star_y[star_count]);
			}
		}

#if 0
		angle += 0.01;
		amplitude_angle += .0086;	// 730
		horizontal_angle += .003;	// 2094
		vertical_angle += 0.0043;	// 1461
						// .025 is 2pi/256
#endif
		angle += 0.012;
		amplitude_angle += .005;	// 730
		horizontal_angle -= .005;	// 2094
		vertical_angle += 0.005;	// 1461
						// .025 is 2pi/256
						// .0102 is 2pi/512
						// .005  is 2pi/1024
		hgr();

		/* Draw Circles */
		for (star_count = 0; star_count < NUM_STARS; star_count++) {

	                for (p = 0; p < NUM_POINTS; p++) {
				x = (280 >> 1) + 280 *
					(star_x[star_count] +
					RADIUS *
					sin(p * pi2 / NUM_POINTS))
					/ star_z[star_count];

				y = (192 >> 1) - 192 *
					(star_y[star_count] +
					RADIUS *
					cos(p * pi2 / NUM_POINTS))
					/ star_z[star_count];

				if ((x>0)&&(x<279)&&(y>0)&&(y<191)) {

					hplot(x,y);

					if (star_z[star_count] < MAX_Z * .7) {
						hplot(x+1,y);
					}
				}
			}
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(30000);
	}

	return 0;
}
