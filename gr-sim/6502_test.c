#include <stdio.h>

#include "6502_emulate.h"


static void test_adc(void) {
	int i,j;

	/* carry in 0 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			c=0;
			a=i;
			adc(j);
			if (a!=((i+j)&0xff)) {
				printf("ADC: Error!  %d+%d should be %d, not %d\n",i,j,i+j,a);
			}
			if (c!=(((i+j)>>8)&0x1)) {
				printf("ADC: Error!  Carry should be %d, not %d\n",((i+j)>>8)&0x1,c);
			}
			if ((a==0) && (z!=1)) printf("ADC error, zflag wrong\n");
			if ((a!=0) && (z!=0)) printf("ADC error, zflag wrong\n");

		}
	}

	/* carry in 1 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			c=1;
			a=i;
			adc(j);
			if (a!=((i+j+1)&0xff)) {
				printf("ADC: Error!  %d+%d should be %d, not %d\n",i,j,i+j+1,a);
			}
			if (c!=(((i+j+1)>>8)&0x1)) {
				printf("ADC: Error!  Carry should be %d, not %d\n",((i+j+1)>>8)&0x1,c);
			}
			if ((a==0) && (z!=1)) printf("ADC error, zflag wrong\n");
			if ((a!=0) && (z!=0)) printf("ADC error, zflag wrong\n");
		}
	}
}

static void test_sbc(void) {
	int i,j;

	/* carry in 1 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			c=1;
			a=i;
			sbc(j);
			if (a!=((i-j-0)&0xff)) {
				printf("SBC: Error!  %d-%d should be %d, not %d\n",i,j,i-j-0,a);
			}
			if (c!=(((i-j-0)>>8)&0x1)) {
				printf("SBC: Error!  Carry should be %d, not %d\n",((i-j-0)>>8)&0x1,c);
			}
			if ((a==0) && (z!=1)) printf("SBC error, zflag wrong\n");
			if ((a!=0) && (z!=0)) printf("SBC error, zflag wrong\n");
		}
	}

	/* carry in 0 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			c=0;
			a=i;
			sbc(j);
			if (a!=((i-j-1)&0xff)) {
				printf("SBC: Error!  %d-%d should be %d, not %d\n",i,j,i-j-1,a);
			}
			if (c!=(((i-j-1)>>8)&0x1)) {
				printf("SBC: Error!  Carry should be %d, not %d\n",((i-j-1)>>8)&0x1,c);
			}
			if ((a==0) && (z!=1)) printf("SBC error, zflag wrong\n");
			if ((a!=0) && (z!=0)) printf("SBC error, zflag wrong\n");
		}
	}


}

int main(int argc, char **argv) {

	test_adc();
	test_sbc();

	return 0;

}
