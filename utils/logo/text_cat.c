#include <stdio.h>

int main(int argc, char **argv) {

	int result;

	while(1) {
		result=getchar();
		if (result<0) break;

		putchar(result&0x7f);

	}

	return 0;
}
