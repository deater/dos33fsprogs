#include <stdio.h>

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;

	while(1) {
		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) break;
		printf("%s",result);
	}

	return 0;
}
