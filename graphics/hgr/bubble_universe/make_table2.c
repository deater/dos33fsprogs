/* Bubble table */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>

#define PI 3.14159265358979323846264

int main(int argc, char **argv) {

	int i,t;
	double d;

// in other words, scaled to 46+/-256/2pi. and shifted by 2*46 
// the shift is there to remove the offset from u and v 
// being sums of 2 sins and 2 coses.
// Building in the offset means my coordinates are all positive
//cos_t    .char    round(cos((range(256)-92)*2.0*pi/256)*256.0/2.0/pi+46)
//sin_t    .char    round(sin((range(256)-92)*2.0*pi/256)*256.0/2.0/pi+46)



	int sine_table[256];
	int cos_table[256];

	for(i=0;i<256;i++) {
		d=round(sin((i-92)*2.0*PI/256.0)*256.0/2.0/PI+46);
		sine_table[i]=(int)d;
	}

	printf("sin_t:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) printf("\t.byte\t");
		t=sine_table[i];
		printf("$%02X",t&0xff);
		if (i%16!=15) printf(",");
		else printf("\n");
	}

	for(i=0;i<256;i++) {
		d=round(cos((i-92)*2.0*PI/256.0)*256.0/2.0/PI+46);
		cos_table[i]=(int)d;
	}

	printf("cos_t:\n");
	for(i=0;i<256;i++) {
		if (i%16==0) printf("\t.byte\t");
		t=cos_table[i];
		printf("$%02X",t&0xff);
		if (i%16!=15) printf(",");
		else printf("\n");
	}



}
