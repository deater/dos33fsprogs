#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i,len,rv,a;
	unsigned char string[BUFSIZ];
	unsigned char out[BUFSIZ];

	rv=read(0,string,BUFSIZ);
	if (rv<=0) return -1;

	len=rv;
	printf("Len=%d\n",len);
	for(i=0;i<len;i++) {
		out[i]=' '+(string[i]>>2);
	}
	for(i=0;i<len;i+=2) {
		a=(string[i]&3)<<2;
		a|=(string[i+1]&3);
		out[len+i/2]=' '+a;
	}
	out[len+len/2+1]=0;
	printf("%s",out);

	return 0;
}
