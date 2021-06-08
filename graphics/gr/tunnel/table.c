#include <stdio.h>

int main(int argc, char **argv) {

	double x,y;

	// 6.2 FLOAT POINT

	// 2 3 4 5 6 7 8
	// 2.1 3.1 4.1 5.1 6.1
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

	// 6.2 FLOAT POINT

	// 2 3 4 5 6 7 8
	// 2.1 3.1 4.1 5.1 6.1
	int q;
	for(y=0;y<7;y++) {
		q=y*0x24;
		for(x=0x200+q;x<=0x900+q;x+=0x100) {
			printf("%.0lf,",0x2800/x);
		}
		printf("\n");
	}

	printf("\n");


	y=7;
	q=0;
yloop:
	x=0x200+q;
xloop:
	printf("%02X,",(int)(0x2800/x));

	x=x+0x100;
	if (x<0xA00+q) goto xloop;

	printf("\n");
	q=q+0x24;
	y=y-1;
	if (y>=0) goto yloop;

	printf("\n");


	return 0;
}

// 40/(2+I+J/7)
// 0.1 0.2 0.3 ... 0.7
// 1.0 1.1
