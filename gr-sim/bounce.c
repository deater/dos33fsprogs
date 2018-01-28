#include <stdio.h>

int main(int argc, char **argv) {

	double x,v0,g,t,d;

	x=10.0;
	d=0.0;
	v0=0;
	g=-9.8;

#define T	0.01

	for(t=0;t<10;t+=T) {

		x+=v0*T;
		v0+=g*T;

		if (x<0) v0=-v0;

		printf("%.2f %.2f\n",t,x);



	}

	return 0;
}
