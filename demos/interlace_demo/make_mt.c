#include <stdio.h>

int main(int argc, char **argv) {

	int i,j;

	printf("movement_table:\n");
	for(i=0;i<123;i++) {
		printf("\t.byte\t$%02X\t; %d -> %d\n",i+1,i,i+1);
	}
	printf("\t.byte\t$%02X\t; %d -> %d\n",123+0x80,123,123+0x80);
	for(i=124;i<128;i++) {
		printf("\t.byte\t$%02X\t; %d -> %d\n",123,i,123);
	}

	printf("\t.byte\t$%02X\t; %d -> %d\n",0,128,0);
	for(i=129;i<256;i++) {
		printf("\t.byte\t$%02X\t; %d -> %d\n",i-1,i,i-1);
	}

	return 0;
}
