#include <stdio.h>
#include <math.h>

int main(int argc, char **argv) {

	int i;
	int value;

	for(i=0;i<256;i++) {
		value=80.0+(sin(i*(2*3.141592653589)/256.0)*78.0);
		/* HACK to avoid jitter */
		if (value>157) value=157;
//		fprintf(stderr,"%d %d\n",i,value);
		putchar(value);
	}

	return 0;
}
