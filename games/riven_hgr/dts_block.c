#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	int disk,track,sector;
	int block;

	disk=atoi(argv[1]);
	track=atoi(argv[2]);
	sector=atoi(argv[3]);

	block=((disk+1)<<9)|(track<<3)|(sector>>1);

	printf("%d",block);

	return 0;
}
