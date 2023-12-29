#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <fcntl.h>

#include "6502_emulate.h"
#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,fd;

	grsim_init();

	home();

	hgr();
	/* Show all 280x192, no bottom text */
        soft_switch(MIXCLR);
        soft_switch(HISCR);

	fd=open("MERRY.BIN",O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x6000],8192);
	close(fd);

//	grsim_update();

//	while(1) {
//		ch=grsim_input();
//		if (ch) break;
//		usleep(100000);
//	}

	fd=open("BALLC.BIN",O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x4000],8192);
	close(fd);

	/*	  0     1     2     3     4     5     6     7
	00	= $2000 $2400 $2800 $2c00 $3000 $3400 $3800 $3c00
	08	= $2080 $2480 $2880 $2c80 $3080 $3480 $3880 $3c80
	16	= $2100 $2500 $2900 $2d00 $3100 $3500 $3900 $3d00
	24	= $2180 $2580 $2980 $2d80 $3180 $3580 $3980 $3d80
	32	= $2200 $2600 $2a00 $2e00 $3200 $3600 $3a00 $3e00
	40	= $2280 $2680 $2a80 $2e80 $3280 $3680 $3a80 $3e80
	48	= $2300 $2700 $2b00 $2f00 $3300 $3700 $3b00 $3f00
	56	= $2380 $2780 $2b80 $2f80 $3380 $3780 $3b80 $3f80
	-----
	64	= $2028 $2428 $2828 $2c28 $3028 $3428 $3828 $3c28
	72	= $20a8 $24a8 $28a8 $2ca8 $30a8 $34a8 $38a8 $3ca8
	80	= $2128 $2528 $2928 $2d28 $3128 $3528 $3928 $3d28
	88	= $21a8 $25a8 $29a8 $2da8 $31a8 $35a8 $39a8 $3da8
	96	= $2228 $2628 $2a28 $2e28 $3228 $3628 $3a28 $3e28
	104	= $22a8 $26a8 $2aa8 $2ea8 $32a8 $36a8 $3aa8 $3ea8
	112	= $2328 $2728 $2b28 $2f28 $3328 $3728 $3b28 $3f28
	120	= $23a8 $27a8 $2ba8 $2fa8 $33a8 $37a8 $3ba8 $3fa8
	-----
	128	= $2050 $2450 $2850 $2c50 $3050 $3450 $3850 $3c50
	136	= $20d0 $24d0 $28d0 $2cd0 $30d0 $34d0 $38d0 $3cd0
	144	= $2150 $2550 $2950 $2d50 $3150 $3550 $3950 $3d50
	152	= $21d0 $25d0 $29d0 $2dd0 $31d0 $35d0 $39d0 $3dd0
	160	= $2250 $2650 $2a50 $2e50 $3250 $3650 $3a50 $3e50
	168	= $22d0 $26d0 $2ad0 $2ed0 $32d0 $36d0 $3ad0 $3ed0
	176	= $2350 $2750 $2b50 $2f50 $3350 $3750 $3b50 $3f50
	184	= $23d0 $27d0 $2bd0 $2fd0 $33d0 $37d0 $3bd0 $3fd0
	-----
	*/


	int count=0;

#define HIGH	0x00
#define CURRENT	0x01
#define NEXT	0x02
#define INL	0xfc
#define INH	0xfd
#define OUTL	0xfe
#define OUTH	0xff

//ram[y_indirect(OUTL,y)]

scroll_loop:

	ram[OUTH]=0x40;
	ram[OUTL]=0x00;
	ram[INH]=0x60;
	ram[INL]=0x00;
left_one_loop:
//	printf("%d %02x:%02x\n",count,ram[OUTH],ram[OUTL]);

	for(Y=0;Y<40;Y++) {
		ram[CURRENT]=ram[y_indirect(OUTL,Y)];
		ram[NEXT]=ram[y_indirect(OUTL,Y+1)];
		if ((count%7==2) || (count%7==6)) {
			ram[HIGH]=ram[NEXT]&0x80;
		}
		else {
			ram[HIGH]=ram[CURRENT]&0x80;
		}
		if (Y==39) ram[NEXT]=ram[y_indirect(INL,0)];

		A=ram[NEXT];
		and(0x3);
		asl();
		asl();
		asl();
		asl();
		asl();
		ram[NEXT]=A;

		A=ram[CURRENT];
		lsr();
		lsr();			// current>>=2;
		and(0x1f);		// current&=0x1f;
		ora_mem(HIGH);
		ora_mem(NEXT);
		ram[y_indirect(OUTL,Y)]=A;
	}

	for(Y=0;Y<40;Y++) {
		ram[CURRENT]=ram[y_indirect(INL,Y)];
		ram[NEXT]=ram[y_indirect(INL,Y+1)];
		if ((count%7==2) ||(count%7==6)) {
			ram[HIGH]=ram[NEXT]&0x80;
		}
		else {
			ram[HIGH]=ram[CURRENT]&0x80;
		}

		A=ram[NEXT];
		and(0x3);
		asl();
		asl();
		asl();
		asl();
		asl();
		ram[NEXT]=A;

		A=ram[CURRENT];
		lsr();
		lsr();			// current>>=2;
		and(0x1f);		// current&=0x1f;
		ora_mem(HIGH);
		ora_mem(NEXT);
		ram[y_indirect(INL,Y)]=A;
	}



	clc();
	A=ram[INL];
	adc(0x80);
	ram[INL]=A;
	A=ram[INH];
	adc(0x0);
	ram[INH]=A;

	clc();
	A=ram[OUTL];
	adc(0x80);
	ram[OUTL]=A;
	A=ram[OUTH];
	adc(0x0);
	ram[OUTH]=A;

	if (A!=0x60) goto left_one_loop;

	grsim_update();
	ch=grsim_input();
	if (ch) goto scroll_done;
	usleep(17000);	// 60Hz = 17ms
	count++;
	if (count==140) goto scroll_done;

	goto scroll_loop;
scroll_done:

	while(1) {
		ch=grsim_input();
		if (ch) break;
	}
	return 0;
}
