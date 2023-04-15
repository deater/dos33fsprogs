#include <stdio.h>
#include <unistd.h>

#define MAXSIZE 4096

int main(int argc, char **argv) {

	unsigned char in[MAXSIZE],a,b,c,d;
	int len,i;

	len=read(0,in,MAXSIZE);
	// 000000 001111 111122 222222
	// 012345 670123 456701 234567

	i=0;
	while(1) {
		a=(in[i]>>2)+' ';
		b=((in[i]&0x3)<<4)+(in[i+1]>>4)+' ';
		c=(in[i+1]&0xf<<2)+(in[i+2]>>6)+' ';
		d=(in[i+2]&0x3f)+' ';
		printf("%c%c%c%c",a,b,c,d);
		i=i+3;
		if (i>len) break;
	}
	printf("\n");
}
