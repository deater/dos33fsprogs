#include <stdio.h>
#include <string.h>

/* If doing cycle-counted code we don't want to cross pages */
/* in that case, skip bytes from 240-256 */
static int dont_page_cross=1;

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;

	int inverse=0;
	int count,i,length;
	int offset=0;

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
			offset++;
		}
		else {
			putchar(' '|0x80);
			offset++;
		}

		for(i=0;i<length;i++) {

			if (string[i]=='\n') continue;

			if (inverse) {
				putchar(string[i]&0x3f);
				offset++;
			}
			else {
				putchar(string[i]|0x80);
				offset++;
			}
		}
		for(i=0;i<(40-length);i++) {
			if (inverse) {
				putchar(' '&0x3f);
				offset++;
			}
			else {
				putchar(' '|0x80);
				offset++;
			}


		}

		if ((dont_page_cross) && ((offset%256)==240)) {
			for(i=0;i<16;i++) {
				if (inverse) {
					putchar(' '&0x3f);
					offset++;
				}
				else {
					putchar(' '|0x80);
					offset++;
				}
			}

		}

	}

	return 0;
}
