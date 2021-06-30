#include <stdio.h>

int main(int argc, char **argv) {

	int	x,y,c;

	printf("; color test\n");
	printf("CLS\t0\n");
	for(x=0;x<16;x++) {
		for(y=0;y<16;y++) {
			c=(x*16)+y;
			printf("DRECT\t0x%x\t0x%x\t",c,c);
			printf("%d\t%d\t%d\t%d\n",
				x*14,y*8,(x+1)*14,(y+1)*8);
		}
	}
	printf("END\n");

	return 0;
}
