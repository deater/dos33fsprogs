#include <stdio.h>

int main(int argc, char **argv) {

	int result;
	int ch;

	while(1) {
		result=getchar();
		if (result<0) break;
		if (result==0) break;

		ch=result&0x7f;

		if (ch=='\r') {
			putchar('\n');
		}
		else {
			putchar(ch);
		}

	}

	return 0;
}
