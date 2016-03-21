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

	printf("VAB"); // center and inverse?

	printf("How many stages (1-3)?\n");
	scanf("%d",&stages);

	for(s=1;s<=stages;s++) {
		printf("Stage %d\n",s);
		printf("How many tanks? (0-3)\n");
		printf("How many engines? (0-3)\n");
	}

	printf("How many parachutes? (0-3)\n");
	printf("How many struts? (0-10000)\n");


	home();

	printf("Astronaut Complex\n"); // center and inverse?

	printf("Available:\n");
	printf("1. Jebediah\tPilot\tS ***\tC ***\n");
	printf("2. Valentina\tPilot\tS ***\tC ***\n");
	printf("3. Kai\tEngineer\s ***\tC ***\n");
	printf("4. Kuroshin\tEngineer\s ***\tC ***\n");
	printf("5. Desktop\tScientist\s ***\tC ***\n");
	printf("6. Slashdot\tPilot\s ***\tC ***\n");
	printf("7. Zurgtroyd\tPilot\s ***\tC ***\n");

	printf("Select three astronauts\n"); // highlight and say correct?

	return 0;

}
