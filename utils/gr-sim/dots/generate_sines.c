#include <stdio.h>
#include <math.h>

int generate_1024=0;
//double sin_max=256.0;
double sin_max=128.0;


int main(int argc, char **argv) {

	int i;
	double s,angle;

	if (generate_1024) {
		printf("int16_t sin1024[]={\n");
		for(i=0;i<1024;i++) {
			angle=(i/1024.0)*(2.0*3.1415926535897932384);
			s=sin(angle)*sin_max;
			printf("%d,",(int)s);
			if (i%16==15) printf("\n");
		}
		printf("};\n");
	} else {
		if (sin_max<200) {
			printf("int8_t sin256[]={\n");
		}
		else {
			printf("int16_t sin256[]={\n");
		}
		for(i=0;i<256;i++) {
			angle=(i/256.0)*(2.0*3.1415926535897932384);
			s=sin(angle)*sin_max;
			if ( ((int)s)>=((int)sin_max) ) s=s-1;
			printf("%d,",(int)s);
			if (i%16==15) printf("\n");
		}
		printf("};\n");
	}

	return 0;
}
