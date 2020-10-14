#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i,len,rv;
	unsigned char string[BUFSIZ];
	unsigned char out[BUFSIZ];

	rv=read(0,string,BUFSIZ);
	if (rv<=0) return -1;

	len=rv;
	printf("Len=%d\n",len);
	printf("\"");
	for(i=0;i<len;i++) {
		out[i]='@'+(string[i]>>4);
		out[i+len]='@'+(string[i]&0xf);
	}
	out[2*len]=0;
	printf("%s",out);
	printf("\"\n");

	return 0;
}
