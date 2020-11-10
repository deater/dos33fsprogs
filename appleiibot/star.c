#include <stdio.h>
#include <stdlib.h>

#define SIZE	10
#define REPEAT	100

int main(int argc, char **argv) {

	int i,j;
	double a,b,c;
	double x[SIZE],y[SIZE],z[SIZE];
	double speed=0.1;

	double outputx[SIZE][REPEAT];
	double outputy[SIZE][REPEAT];

	for(i=1;i<SIZE;i++) {
	for(j=1;j<REPEAT;j++) {
		a=x[i];
		b=y[i];
		c=z[i]*speed;
		x[i]=a+(a-140)*c;
		y[i]=b+(b-96)*c;
		z[i]=z[i]+speed;

		if ((x[i]<0) || (x[i]>279) || (y[i]<0) || (y[i]>191)) {
			x[i]=0;
			y[i]=0;
			i++;
			x[i]=rand()%279;
			y[i]=rand()%191;
			z[i]=0;
		}
		else {
//			outputx[i][j]=x[i];
//			outputy[i][j]=y[i];
//
		}
		printf("%i:%i: %.1f %.1f %.2f\n",i,j,x[i],y[i],z[i]);

	}
	}

//	for(i=1;i<SIZE;i++) {
//		for(j=1;j<REPEAT;j++) {
//			printf("%i:%i: %.1f %.1f\n",i,j,outputx[i][j],outputy[i][j]);
//		}
//	}
	return 0;
}
