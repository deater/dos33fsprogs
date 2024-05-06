#include <stdio.h>

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;

	int inverse=0;

	while(1) {

		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) break;
		printf("%s",string);
	}

	return 0;
}
