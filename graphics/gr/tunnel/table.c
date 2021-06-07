#include <stdio.h>

int main(int argc, char **argv) {

	double x,y;

	for(y=0;y<1;y+=1.0/7.0) {
		printf("%.2lf: ",y);
		for(x=2.0+y;x<=9.0+y;x++) {
			printf("%.2lf ",40/x);
		}
		printf("\n");
	}

	printf("\n");

	for(y=0;y<1;y+=1.0/7.0) {
		for(x=2.0+y;x<=9.0+y;x++) {
//			printf("%.2lf ",40/x);
			printf("%.1lf ",(40/x) - 40/(x+1));
		}
		printf("\n");
	}

	return 0;
}
