#include <stdio.h>

int main(int argc, char **argv) {

	int x,z;
	int real[256][64];
	int six[256][64];

	/* actual */
	for(z=1;z<64;z++) {
		for(x=-128;x<128;x++) {
			real[x+128][z]=x/z;
//			printf("%02X ",x/z);
		}
//		printf("\n");
	}

	/* 6502 */

	int XX,AA;

	for(z=1;z<64;z++) {
		for(x=0;x<128;x++) {
			XX=0;
			AA=x;
			while(1) {
				AA=AA-z;
				if (AA<0) {
					six[x+128][z]=XX;
					six[128-x][z]=-XX;
					break;
				}
				XX++;
			}
		}
//		printf("\n");
	}

	/* compare */
	for(z=1;z<64;z++) {
		for(x=0;x<256;x++) {
			if ((six[x][z]&0xff)!=(real[x][z]&0xff)) {
				printf("Mismatch at x=%d,z=%d, x/z (6502)%d!=(real)%d\n",
					x-128,z,six[x][z],real[x][z]);
			}
		}
//		printf("\n");
	}

	return 0;
}
