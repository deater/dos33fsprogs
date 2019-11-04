#include <stdio.h>

#include <math.h>

#define ANGLE_STEPS	64

static int double_to_fixed(double d) {

        int temp;

        temp=d*4096;

	return temp;

}


int main(int argc, char **argv) {

	double angle;
	int i;

	printf("Sin\n");
	for(i=0;i<ANGLE_STEPS;i++) {
		angle=3.1415926535897932384*2.0*((double)i/(double)ANGLE_STEPS);
		printf("%d %lf %x\n",i,sin(angle),double_to_fixed(sin(angle)));
	}

	printf("Cos\n");
	for(i=0;i<ANGLE_STEPS;i++) {
		angle=3.1415926535897932384*2.0*((double)i/(double)ANGLE_STEPS);
		printf("%d %lf\n",i,cos(angle));
	}


	return 0;
}
