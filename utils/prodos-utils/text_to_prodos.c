#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(int argc, char **argv) {

	FILE *fff;

	int result;

	if (argc<2) {
		fff=stdin;
	}
	else {
		fff=fopen(argv[1],"rb");
		if (fff==NULL) {
			fprintf(stderr,"Error opening %s: %s\n",
				argv[1],strerror(errno));
			return -1;
		}
	}

	while(1) {
		result=fgetc(fff);
		if (result<0) break;
		if (result=='\n') putchar('\r');
		else putchar(result);

	}

	return 0;
}
