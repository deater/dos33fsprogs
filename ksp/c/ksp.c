#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

void home(void) {
	printf("%c[2J%c[1;1H",27,27);
}

void htabvtab(int x,int y) {
	printf("%c[%d;%dH",27,y,x);
}

void centerprint(int y, char *string) {

	int x;

	x=(40-strlen(string))/2;

	htabvtab(x,y);
	printf("%s",string);
	fflush(stdout);

}

void print_funny_saying(int y) {

	int z;

	htabvtab(1,y);
	printf("                                                       ");
	fflush(stdout);

	z=rand()%8;

	switch(z) {
		case 0:	centerprint(y,"Adding Extraneous Ks"); break;
		case 1: centerprint(y,"Locating Jeb"); break;
		case 2: centerprint(y,"Breaking Quicksaves"); break;
		case 3: centerprint(y,"Patching Conics"); break;
		case 4: centerprint(y,"Spinning up Duna"); break;
		case 5: centerprint(y,"Warming up the 6502"); break;
		case 6: centerprint(y,"Preparing explosions"); break;
		case 7: centerprint(y,"Unleashing the Kraken"); break;
	}


}

int main(int argc, char **argv) {

	int x,y,z;

	home();

	for(y=0;y<20;y++) {
		for(x=0;x<39;x++) {
			printf("*");
		}
		printf("\n");
	}

	/* load squad */

	/* draw bar */
	htabvtab(4,21);
	printf("..............................");
	fflush(stdout);
	z=2;
	for(x=0;x<32;x++) {
		/* if (x==16) load loading */

		htabvtab(4+x,21);
		printf("#");
		fflush(stdout);
		z=z+1;
		if (z==3) {
			print_funny_saying(22);
			z=0;
		}
		usleep(250000);
	}

	home();
	/* load title */
	/* play music */


	return 0;

}
