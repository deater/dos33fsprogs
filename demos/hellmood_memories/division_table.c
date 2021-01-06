#include <stdio.h>

int main(int argc, char **argv) {

	int yy;

	for(yy=10;yy<58;yy++) {
		printf("$%02X,",0x3d5/yy);
	}

	return 0;
}
