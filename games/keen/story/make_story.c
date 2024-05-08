#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;

	int inverse=0;
	int count,i,length;

	while(1) {

		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) break;

		if (result[0]=='#') {
			if (strstr(string,"inverse")) inverse=1;
			if (strstr(string,"normal")) inverse=0;
			continue;
		}

		count=0;

		length=strlen(string);

		if (inverse) {
			putchar(' '&0x3f);
		}
		else {
			putchar(' '|0x80);
		}

		for(i=0;i<length;i++) {

			if (string[i]=='\n') continue;

			if (inverse) {
				putchar(string[i]&0x3f);
			}
			else {
				putchar(string[i]|0x80);
			}
		}
		for(i=0;i<(40-length);i++) {
			if (inverse) {
				putchar(' '&0x3f);
			}
			else {
				putchar(' '|0x80);
			}


		}
	}

	return 0;
}
