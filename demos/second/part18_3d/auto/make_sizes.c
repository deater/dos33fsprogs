#include <stdio.h>

// ./make_sizes  | sort -k 7 -n -r

int main(int argc, char **argv) {

	int x,y;

	for(x=40;x>0;x--) {
		for(y=48;y>0;y--) {
			printf("{ %d , %d },\t// %d\n",x,y,x*y);
		}
	}

	return 0;
}
