#include <stdio.h>

int main(int argc, char **argv) {

	int t=0,out;

	while(1) {
		out=((t>>7)|t|(t>>6))*10+4*((t&(t>>13))|t>>6);

		out=(out>>4);
		out=(out<<4);
		printf("%c",out);
		t++;
	}

	return 0;
}
