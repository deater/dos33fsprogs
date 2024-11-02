#include <stdio.h>

static unsigned short hires_lookup[256];

static void generate_lookup(void) {

	int y;

	int base=0x2000;

	int offset1[8]={0x00,0x80,0x100,0x180,0x200,0x280,0x300,0x380};
	int offset2[8]={0x00,0x400,0x800,0xc00,0x1000,0x1400,0x1800,0x1c00};
	int off1;
	int off2;
	for(y=0;y<192;y++) {
		if (y<64) off1=offset1[y/8];
		else if (y<128) off1=offset1[(y-64)/8]+0x28;
		else off1=offset1[(y-128)/8]+0x50;
		off2=offset2[y&7];
		hires_lookup[y]=base+off1+off2;
	}

	return;
}

int main(int argc, char **argv) {

	int i;
	generate_lookup();

//	for(i=0;i<192;i++) {
//		printf("$%04X\n",hires_lookup[i]);
//	}

	for(i=0;i<192;i++) {
		printf("\tlda\t$%04X,Y\t\t; %d -> %d\n",
			hires_lookup[i+1],i+1,i);
		printf("\tsta\t$%04X,Y\n",
			hires_lookup[i]);
	}

	return 0;
}
