#include <stdio.h>


static int gr_offsets[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

#define X_OFFSET	13

int main(int argc, char **argv) {

	int i,j;

	for(i=0;i<96;i++) {
		printf("; %d\n",i*2);
		printf("\tbit\tPAGE0\t; 4\n");
		printf("smc%03d:\tlda\t#$00\t; 2\n",i*2);
		for(j=0;j<14;j++) {
			printf("\tsta\t$%3x\t; 4\n",
				gr_offsets[i/4]+0x400+j+X_OFFSET);
		}
		printf("\tlda\tTEMP\t; 3\n");
		printf("\n");

		printf("; %d\n",(i*2)+1);
		printf("\tbit\tPAGE1\t; 4\n");
		printf("smc%03d:\tlda\t#$00\t; 2\n",(i*2)+1);
		for(j=0;j<14;j++) {
			printf("\tsta\t$%3x\t; 4\n",
				gr_offsets[i/4]+j+X_OFFSET);
		}
		printf("\tlda\tTEMP\t; 3\n");
		printf("\n");
	}


	printf("y_lookup_h:\n");
	for(i=32;i<32+128;i++) {
		if (i%8==0) printf(".byte\t");
		printf(">(smc%03d+1)",i);
		if (i%8!=7) printf(",");
		else printf("\n");
	}

	printf("y_lookup_l:\n");
	for(i=32;i<32+128;i++) {
		if (i%8==0) printf(".byte\t");
		printf("<(smc%03d+1)",i);
		if (i%8!=7) printf(",");
		else printf("\n");
	}
	return 0;
}
