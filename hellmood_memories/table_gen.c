#include <stdio.h>

int main(int argc, char **argv) {

	int x,y;

//	for(x=-32;x<32;x++) printf("$%02x,",(x*x)>>4);

	for(x=-32;x<32;x++) printf("$%02x,",(x*x*16/9)>>4);

	return 0;
}
