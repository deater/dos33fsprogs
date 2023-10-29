#include <stdio.h>

int main(int argc, char **argv) {

	int i,high_bit,temp;

	printf("left_lookup_main:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) {
			printf(".byte ");
		}

		high_bit=i&0x80;

		temp=i&0x7f;
		temp>>=2;
		temp|=high_bit;

		printf("$%02X",temp);

		if (i%16!=15) {
			printf(",");
		}
		else {
			printf("\n");
		}

	}

	printf("left_lookup_next:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) {
			printf(".byte ");
		}

		temp=i&0x3;
		temp<<=5;

		printf("$%02X",temp);

		if (i%16!=15) {
			printf(",");
		}
		else {
			printf("\n");
		}

	}
	return 0;
}
