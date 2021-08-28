#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result,*pointer;

	while(1) {

		pointer=fgets(string,BUFSIZ,stdin);
		if (pointer==NULL) break;

		if (string[0]=='#') continue;

		result=strtok(string," .,\"\t?!");
		while(1) {
			if (result!=NULL) printf("%s\n",result);
			else break;
			result=strtok(NULL," .,\"\t?!");
		}

//		printf("%s",string);

	}

	return 0;
}
