#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i,len,rv;
	char string[BUFSIZ];
	unsigned char a;

		rv=read(0,string,BUFSIZ);
		if (rv<=0) return -1;

		len=rv;
		printf("\"");
		for(i=0;i<len;i++) {
			printf("%c",'#'+(string[i]&0x3f));
		}
		printf(" ");
		for(i=0;i<len;i+=3) {
			a=(string[i]&0xc0)>>2;
			a|=(string[i+1]&0xc0)>>4;
			a|=(string[i+2]&0xc0)>>6;
			a+='#';
			printf("%c",a);
		}

		printf("\"\n");

	return 0;
}
