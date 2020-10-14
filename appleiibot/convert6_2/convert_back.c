#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i,a,x,len;
	char buf[BUFSIZ];
	char out[BUFSIZ];

	len=read(0,buf,BUFSIZ);

	i=1;
	while(buf[i]!='\"') {
		if (buf[i]==' ') len=i;
		buf[i]-='#';
		i++;
	}

//	for(i=1;i<len;i++) out[i-1]=buf[i];

	x=0;
	for(i=1;i<len;i+=3) {
		a=buf[len+x+1];
		out[i]=buf[i]|((a<<2)&0xc0);
		out[i+1]=buf[i+1]|((a<<4)&0xc0);
		out[i+2]=buf[i+2]|((a<<6)&0xc0);
		x++;
	}

	write(1,out+1,len);

	return 0;
}


