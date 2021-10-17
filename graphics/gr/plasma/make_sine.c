#include <stdio.h>
#include <math.h>

#define PI 3.14159265358979323846264338327950

int main(int argc, char **argv) {

	double d;
	int i,r;
	unsigned char c;

#if 0
	for(i=0;i<16;i++) {

		d=(((double)i)*2.0*PI)/16.0;

		r=32*sin(d);

		printf("%i, %02X\n",i,r);

	}
#endif
	for(i=0;i<64;i++) {

		d=(((double)i)*2.0*PI)/64.0;

		r=32*sin(d);

		c=r;

		printf("$%02X,",c);

	}
	printf("\n");


	return 0;
}
