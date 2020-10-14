#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i,a,len;
	char buf[BUFSIZ];
	char out[BUFSIZ];

	len=read(0,buf,BUFSIZ)-2;
	len/=2;

	i=1;
	while(buf[i]!='\"') {
		a=buf[i]<<3;
		a^=buf[i+len];
		out[i-1]=a;
		i++;
	}

	write(1,out,len);

	return 0;
}


