#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	/* the Apple II "wait" routine is the following polynomial */
	/* x=(26+27A+5A^2)/2 us */
	/* we'd like to reverse it, get A for a given x in us */

	/* Use the quadratic formula */

	/* our value M so */
	/* a=(13-(M/2)) */
	/* b=(13.5) */
	/* c=(2.5) */

	/* x= (-b +/- sqrt(b*b-4*a*c))/2a */
	/* x= (-b +/- sqrt(b*b-4*a*c))/2a */

	double a,b,c,m,x1,x2;

	m=7000; /* 7ms, 7k us */

	if (argc>1) m=atoi(argv[1]);

	a=5.0/2.0;
	b=27.0/2.0;
	c=((26.0/2.0)-(m));

	x1=(-b+sqrt(b*b-4*a*c))/(2*a);
	x2=(-b-sqrt(b*b-4*a*c))/(2*a);

	printf("x1=%.2lf, x2=%.2lf\n",x1,x2);

	int q=50;
	printf("If A=50, result=%d us\n",
		(26+27*q+5*q*q)/2);

	return 0;
}
