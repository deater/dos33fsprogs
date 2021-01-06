#include <stdio.h>

int main(int argc, char **argv) {

	unsigned int m1,m2;

	m1=0x1;
	m2=0x1;
	printf("%x * %x = %x\n",m1,m2,m1*m2);

	m1=0x1;
	m2=0xff;
	printf("%x * %x = %x\n",m1,m2,m1*m2);

	m1=0xff;
	m2=0x1;
	printf("%x * %x = %x\n",m1,m2,m1*m2);

	m1=0xff;
	m2=0xff;
	printf("%x * %x = %x\n",m1,m2,m1*m2);


	return 0;
}
