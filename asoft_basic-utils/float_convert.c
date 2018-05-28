#include <stdio.h>

int main(int argc, char **argv) {

//	long long values[5]={0x84,0x80,0,0,0};			// 8
//	long long  values[5]={0x80,0xcc,0xcc,0xcc,0xcc};	// .8
	long long  values[5]={0x7c,0xf7,0x95,0x54,0xfa};	// .8
	long long exponent,mantissa,sign;
	long long integer;
	double fp=0;

	exponent=values[0]-0x80;

	sign=1;
	// below only true if packed */
//	sign=(values[1]&0x80)?-1:1;

	mantissa=((values[1]|0x80)<<24)|
		(values[2]<<16)|
		(values[3]<<8)|
		(values[4]);

	integer=mantissa>>(32-exponent);
	if (mantissa==0) {
		printf("DIV BY ZERO\n");
		return 0;
	}
	fp=(double)mantissa/(double)(1ULL<<32);

	printf("Sign=%lld Mantissa=%llx Exponent=%llx\n",sign,mantissa,exponent);
	printf("Integer=%lld fp=%lf\n",integer,fp);

	return 0;

}
