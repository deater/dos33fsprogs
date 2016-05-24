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

int main(int argc, char **argv) {

	int x,y,z;
	int stages;
	int s;

	home();

	printf("Astronaut Complex\n"); // center and inverse?

	printf("Available:\n");
	printf("1. Jebediah\tPilot\tS ***\tC ***\n");
	printf("2. Valentina\tPilot\tS ***\tC ***\n");
	printf("3. Kai\tEngineer\t ***\tC ***\n");
	printf("4. Kuroshin\tEngineer\t ***\tC ***\n");
	printf("5. Desktop\tScientist\t ***\tC ***\n");
	printf("6. Slashdot\tPilot\t ***\tC ***\n");
	printf("7. Zurgtroyd\tPilot\t ***\tC ***\n");

	printf("Select three astronauts\n"); // highlight and say correct?

	return 0;

}
