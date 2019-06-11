#include <stdio.h>


static int gr_offsets[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

#define X_OFFSET	13

int main(int argc, char **argv) {

	int i,j,lookup,address;

	for(i=0;i<96;i++) {
		lookup=i/4;

		printf("; %d\n",i*2);
		printf("\tbit\tPAGE0\t; 4\n");
		printf("smc%03d:\tlda\t#$00\t; 2\n",i*2);
		for(j=0;j<14;j++) {
			address=gr_offsets[lookup]+0x400+j+X_OFFSET;
			if (i<15) address=0xc00;
			if (i>77) address=0xc00;

			printf("\tsta\t$%3x\t; 4\n",address);

		}
		printf("\tlda\tTEMP\t; 3\n");
		printf("\n");

		lookup=i/4;
		if (i%4==3) lookup=(i+4)/4;
		if (i==95) lookup=0;


		printf("; %d\n",(i*2)+1);
		printf("\tbit\tPAGE1\t; 4\n");
		printf("smc%03d:\tlda\t#$00\t; 2\n",(i*2)+1);
		for(j=0;j<14;j++) {
			address=gr_offsets[lookup]+j+X_OFFSET;
			if (i<15) address=0xc00;
			if (i>77) address=0xc00;
			printf("\tsta\t$%3x\t; 4\n",address);
		}
		printf("\tlda\tTEMP\t; 3\n");
		printf("\n");
	}

#if 0
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
#endif
	return 0;
}
