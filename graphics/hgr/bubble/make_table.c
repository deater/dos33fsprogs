/* Bubble table */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char **argv) {

	int i,t;
	double d;

	int sine_table[256];

	for(i=0;i<256;i++) {
		d=(256.0*sin(6.28*i/256.0));
		sine_table[i]=(int)d;
	}


	printf("sin_table_low:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) printf("\t.byte\t");
		t=sine_table[i];
		printf("$%02X",t&0xff);
		if (i%16!=15) printf(",");
		else printf("\n");
	}

	printf("sin_table_high:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) printf("\t.byte\t");
		t=sine_table[i];
		if (t&0x100) t=0xff;
		else t=0;
		printf("$%02X",t&0xff);
		if (i%16!=15) printf(",");
		else printf("\n");
	}


}
