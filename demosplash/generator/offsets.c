#include <stdio.h>

#define NUMBER 128

//#define START	32
#define START	40

int main(int argc, char **argv) {

	int i;

	printf("y_lookup_h:\n");

	for(i=0;i<NUMBER;i++) {
		if (i%8==0) printf(".byte\t");
		//printf(">(smc%3d+1)",i+START);
		printf(">($%4X)",0x9000+(i+START)*49+4);
		if (i%8!=7) printf(",");
		else printf("\n");
	}
	printf("y_lookup_l:\n");
	for(i=0;i<NUMBER;i++) {
		if (i%8==0) printf(".byte\t");
		//printf("<(smc%3d+1)",i+START);
		printf("<($%4X)",0x9000+(i+START)*49+4);
		if (i%8!=7) printf(",");
		else printf("\n");
	}

	return 0;
}
