#include <stdio.h>
#include <math.h>

int generate_1024=0;

int main(int argc, char **argv) {

	int i;
	double s,angle;

	if (generate_1024) {
		printf("int16_t sin1024[]={\n");
		for(i=0;i<1024;i++) {
			angle=(i/1024.0)*(2.0*3.1415926535897932384);
			s=sin(angle)*256.0;
			printf("%d,",(int)s);
			if (i%16==15) printf("\n");
		}
		printf("};\n");
	} else {
		printf("int16_t sin256[]={\n");
		for(i=0;i<256;i++) {
			angle=(i/256.0)*(2.0*3.1415926535897932384);
			s=sin(angle)*256.0;
			printf("%d,",(int)s);
			if (i%16==15) printf("\n");
		}
		printf("};\n");
	}

	return 0;
}
