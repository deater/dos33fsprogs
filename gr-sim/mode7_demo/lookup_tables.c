#include <stdio.h>

#include <math.h>

#define ANGLE_STEPS	16

int main(int argc, char **argv) {

	double angle;
	int i;

	printf("Sin\n");
	for(i=0;i<ANGLE_STEPS;i++) {
		angle=3.1415926535897932384*2.0*((double)i/(double)ANGLE_STEPS);
		printf("%d %lf\n",i,sin(angle));
	}

	printf("Cos\n");
	for(i=0;i<ANGLE_STEPS;i++) {
		angle=3.1415926535897932384*2.0*((double)i/(double)ANGLE_STEPS);
		printf("%d %lf\n",i,cos(angle));
	}


	return 0;
}
