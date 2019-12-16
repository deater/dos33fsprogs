#include <stdio.h>

#include <math.h>

int main(int argc, char **argv) {

	int i,s;

	for(s=4;s<16;s++) {
		printf("sine_table%d:",s);
		for(i=0;i<128;i++) {
			if (i%16==0) printf("\n.byte\t");
			printf("%2d",s+8+(15-s)+
				(int)round(s*sin(i*2*3.14159265/128.0)));
			if (i%16!=15) printf(",");
		}
		printf("\n");
	}

	return 0;
}
