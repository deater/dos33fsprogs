#include <stdio.h>

#include "6502_emulate.h"


static void test_adc(void) {
	int i,j;

	/* carry in 0 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			C=0;
			A=i;
			adc(j);
			if (A!=((i+j)&0xff)) {
				printf("ADC: Error!  %d+%d should be %d, not %d\n",i,j,i+j,A);
			}
			if (C!=(((i+j)>>8)&0x1)) {
				printf("ADC: Error!  Carry should be %d, not %d\n",((i+j)>>8)&0x1,C);
			}
			if ((A==0) && (Z!=1)) printf("ADC error, zflag wrong\n");
			if ((A!=0) && (Z!=0)) printf("ADC error, zflag wrong\n");

		}
	}

	/* carry in 1 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			C=1;
			A=i;
			adc(j);
			if (A!=((i+j+1)&0xff)) {
				printf("ADC: Error!  %d+%d should be %d, not %d\n",i,j,i+j+1,A);
			}
			if (C!=(((i+j+1)>>8)&0x1)) {
				printf("ADC: Error!  Carry should be %d, not %d\n",((i+j+1)>>8)&0x1,C);
			}
			if ((A==0) && (Z!=1)) printf("ADC error, zflag wrong\n");
			if ((A!=0) && (Z!=0)) printf("ADC error, zflag wrong\n");
		}
	}
}

static void test_sbc(void) {
	int i,j;

	/* carry in 1 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			C=1;
			A=i;
			sbc(j);
			if (A!=((i-j-0)&0xff)) {
				printf("SBC: Error!  %d-%d should be %d, not %d\n",i,j,i-j-0,A);
			}
			if (C==(((i-j-0)>>8)&0x1)) {
				printf("SBC: Error!  Carry should be %d, not %d\n",((i-j-0)>>8)&0x1,C);
			}
			if ((A==0) && (Z!=1)) printf("SBC error, zflag wrong\n");
			if ((A!=0) && (Z!=0)) printf("SBC error, zflag wrong\n");
		}
	}

	/* carry in 0 */
	for(i=0;i<256;i++) {
		for(j=0;j<256;j++) {
			C=0;
			A=i;
			sbc(j);
			if (A!=((i-j-1)&0xff)) {
				printf("SBC: Error!  %d-%d should be %d, not %d\n",i,j,i-j-1,A);
			}
			if (C==(((i-j-1)>>8)&0x1)) {
				printf("SBC: Error!  Carry should be %d, not %d\n",((i-j-1)>>8)&0x1,C);
			}
			if ((A==0) && (Z!=1)) printf("SBC error, zflag wrong\n");
			if ((A!=0) && (Z!=0)) printf("SBC error, zflag wrong\n");
		}
	}


}

int main(int argc, char **argv) {

	test_adc();
	test_sbc();

	return 0;

}
