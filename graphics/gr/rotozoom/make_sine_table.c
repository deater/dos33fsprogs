#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PI 3.14159265358979323846264

int main(int argc, char **argv) {

	int num=16,i;
	short temp;
	double s;
	int sh,sl;

	if (argc>1) {
		num=atoi(argv[1]);
	}

	for(i=0;i<num;i++) {
		s=sin(2.0*PI*(double)i/(double)num);
		temp=s*256;
		sl=temp&0xff;
		sh=(temp>>8)&0xff;

		printf("\t.byte $%02X,$%02X ; %lf\n",sh,sl,
			s);

	}

	return 0;
}
