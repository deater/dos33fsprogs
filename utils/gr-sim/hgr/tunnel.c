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

int main(int argc, char **argv) {

	int	star_x[NUM_STARS];
	int	star_y[NUM_STARS];
	int	star_z[NUM_STARS];

// 20,200,36,  2500, 2,  3
//800,200,50,100000,10,100

	int	num_stars=NUM_STARS;
	double	radius=320.0;
	double	num_points=NUM_POINTS;
	double	max_z=2500;
	double	min_z=10;
	double	z_speed=10;

	int ch,i,star_count;
	double x,y,p;
	double pi2=6.28;

	grsim_init();

	home();

	hgr();
	soft_switch(MIXCLR);	// Full screen

	hcolor_equals(3);


	double angle=0,amplitude_angle=0,horizontal_angle=0,vertical_angle = 0;

	for (i = 0; i < num_stars; i++) {
		star_x[i]=0;
		star_y[i]=0;
		star_z[i] = min_z + ((max_z - min_z) / num_stars) * i + 1;
	}


	while(1) {

//#define AMP_MUL	300
#define AMP_MUL 64

		/* Process Starfield */
		for (star_count = 0; star_count < num_stars; star_count++) {
			star_z[star_count] -= z_speed;

			if (star_z[star_count] <= min_z) {
				star_z[star_count] = (max_z-min_z);

				// 100 + +/-64 + +/-64
				star_x[star_count] = (140 +
					AMP_MUL * sin(amplitude_angle)) *
					sin(angle) +
					AMP_MUL * sin(horizontal_angle);

				star_y[star_count] = (96 +
					AMP_MUL *
					sin(amplitude_angle)) *
					cos(angle) +
					AMP_MUL * sin(vertical_angle);

			}
		}





#if 0
		angle += 0.01;
		amplitude_angle += .0086;
		horizontal_angle += .003;
		vertical_angle += 0.0043;
#endif


		angle += 0.01;
		amplitude_angle += .0086;
		horizontal_angle += .003;
		vertical_angle += 0.0043;





	hgr();

		/* Draw Starfield */
		for (star_count = 0; star_count < num_stars; star_count++) {

	                for (p = 0; p < num_points; p++) {
				x = (280 >> 1) + 280 *
					(star_x[star_count] +
					radius *
					sin(p * pi2 / num_points))
					/ star_z[star_count];

				y = (192 >> 1) - 192 *
					(star_y[star_count] +
					radius *
					cos(p * pi2 / num_points))
					/ star_z[star_count];

				if ((x>0)&&(x<279)&&(y>0)&&(y<191)) {

//if (star_z[star_count] < max_z * .9) {
					hplot(x,y);
//}
if (star_z[star_count] < max_z * .7) {
//if ((star_z[star_count]/256)%2==0) {
//if ((star_count>>2)%2==0) {
					hplot(x+1,y);
//					hplot(x,y+1);
}
				}
				else {
//					printf("Out of range %lf %lf\n",x,y);
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
