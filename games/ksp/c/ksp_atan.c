#include <math.h>
#include <stdio.h>

#define PI 3.14159265358979323846264

int main(int argc, char **argv) {

	double theta;
	double x,y,a;

	for(theta=0;theta<360;theta+=1.0) {
		x=sin(theta*PI/180.0);
		y=cos(theta*PI/180.0);
		if (y<0) a=180.0+((atan(x/y))*180.0/PI);
		else a=(atan(x/y))*180.0/PI;
		printf("%lf x=%lf y=%lf atan(x/y)=%lf\n",
			theta,x,y,a);
//		printf("%lf %lf\n",x*600.0,y*600.0);

	}

	return 0;
}
