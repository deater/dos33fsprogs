#include <stdio.h>

int main(int argc, char **argv) {

	int i;
	int top;
	int bottom;
	int out;

	for(i=0;i<256;i++) {
		top=i&0x7c;
		bottom=i&3;
		out=(top>>2)|(bottom<<5);
		if (i%8==0) printf("\n.byte\t");
		printf("$%02X",out);
		if (i%8!=7) printf(",");
	}
	printf("\n");

	return 0;
}
