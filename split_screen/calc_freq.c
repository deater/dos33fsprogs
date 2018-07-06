#include <stdio.h>

int main(int argc, char **argv) {

	int x,y,cycles,desired,range=10;

//	desired=3116;
//	desired=4152;
//	desired=5196;
//	desired=4547;
//	desired=9685;
	desired=236;


	printf("You want %d cycles\n",desired);
	for(x=0;x<255;x++) {
		for(y=0;y<255;y++) {
			cycles=1+5*y+y*(5*x+1);
			if (((cycles-desired)<range) && ((cycles-desired)>-range)) {
				printf("Try X=%d Y=%d cycles=%d\n",
					x,y,cycles);
			}
		}
	}
	return 0;
}
