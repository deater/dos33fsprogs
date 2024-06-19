#include <stdio.h>
#include <math.h>

int main(int argc, char **argv) {
	double x;

	for(x=0;x<25;x++) {

		printf("%.2lf %.2lf\n",x,5.0+5.0*sin(x*6.28/25));

	}
	return 0;
}
