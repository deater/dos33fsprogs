#include <stdio.h>
#include <math.h>

#define PI 3.14159265358979323846264338327950

int main(int argc, char **argv) {

	double d;
	int i,r;

	for(i=0;i<16;i++) {

		d=(((double)i)*2.0*PI)/16.0;

		r=32*sin(d);

		printf("%i, %02X\n",i,r);

	}

	return 0;
}
