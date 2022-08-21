#include <stdio.h>
#include <math.h>

#define DIVISIONS 8

int main(int argc, char **argv) {

	double diff=3.14159265358979/2/DIVISIONS;
	double offset=3.14159265358979/2/8/16;
	int i,j;

	for(j=0;j<16;j++) {
		printf("%d: ",j);
		for(i=0;i<DIVISIONS;i++) {
			printf("%.2lf ",80*sin((offset*j)+i*diff));
		}
		printf("\n");
	}

	return 0;
}
