#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <fcntl.h>

#include "gr-sim.h"

static int hgr_offset_table[48]={
        0x0000,0x0080,0x0100,0x0180,0x0200,0x0280,0x0300,0x0380,
        0x0028,0x00A8,0x0128,0x01A8,0x0228,0x02A8,0x0328,0x03A8,
        0x0050,0x00D0,0x0150,0x01D0,0x0250,0x02D0,0x0350,0x03D0,
};

static int hgr_offset(int y) {

        int temp,temp2,address;
        temp=y/8;
        temp2=y%8;

        temp2=temp2*0x400;

        address=hgr_offset_table[temp]+temp2+0x2000;

        return address;
}

// 0111 -> 1011
static int color_lookup[5][4]={
	{0,5,11,15},	// default   black/grey/lblue/white
	{0,2,6,14},	// green     black/dgreen/lgreen/yellow
	{0,1,3,11},	// blue	     black/dblue/medblue/lblue
	{0,8,9,13},	// red	     black/red/purple/pink
	{0,4,12,14},	// yellow    black/brown/orange/yellow
};

static int z=0x6000,left=0;
static int c=0;

static void reset_data(void) {
	z=0x6000;
	left=0;
	c=0;
}

static int get_next_color(int pal) {

	int current;

	if (left==0) {
		c=ram[z];
		z++;
		left=4;
	}

	current=c&0x3;
	left--;

//	printf("%x (%d): %x %x\n",z-1,left,c,color_lookup[pal][current]);

	c=c>>2;

	return color_lookup[pal][current];

}


void decode_image(int pal, int xstart, int xend) {

	/****************************************************/
	/* decompress */

	// AUX0         MAIN0    AUX1      MAIN1
	// PBBBAAAA    PDDCCCCB  PFEEEEDD  PGGGGFFF
	int x,y;
	int colors[7],aux0,main0,aux1,main1,addr;
	for(y=0;y<192;y++) {
		addr=hgr_offset(y);
		for(x=0;x<20;x++) {
			colors[0]=get_next_color(pal);
			colors[1]=get_next_color(pal);
			colors[2]=get_next_color(pal);
			colors[3]=get_next_color(pal);
			colors[4]=get_next_color(pal);
			colors[5]=get_next_color(pal);
			colors[6]=get_next_color(pal);

			if ((x<xstart) || (x>xend)) {
				aux0=0;
				main0=0;
				aux1=0;
				main1=0;
			}
			else {

			aux0=(colors[0])|((colors[1]&0x7)<<4);
			main0=(colors[1]>>3)|(colors[2]<<1)|((colors[3]&3)<<5);
			aux1=(colors[3]>>2)|(colors[4]<<2)|((colors[5]&1)<<6);
			main1=(colors[5]>>1)|(colors[6]<<3);
			}

			ram[addr+0x10000]=aux0;
			ram[addr]=main0;
			ram[addr+0x10000+1]=aux1;
			ram[addr+1]=main1;
			addr+=2;
		}
	}
}

static void wait_until_keypress(void) {
	int ch;

	while(1) {
		ch=grsim_input();
		if (ch) break;
		usleep(100000);
	}
}


int main(int argc, char **argv) {

	int fd;

	if (argc<1) {
		fprintf(stderr,"Usage: unpack4 FILENAME.4\n");
		fprintf(stderr,"  where FILENAME.4 is a 4-packed AppleII DHIRES image\n\n");
	}

	grsim_init();

	home();

	soft_switch(SET_GR);
	soft_switch(HIRES);
	soft_switch(FULLGR);
	soft_switch_write(AN3);
	soft_switch_write(EIGHTY_COLON);
	soft_switch_write(SET80_COL);

	soft_switch(SET_PAGE1);

	/* Load FILE */
	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		printf("Error opening!\n");
		return -1;
	}
	read(fd,&ram[0x6000],8192);
	close(fd);



	/* decode full */

	decode_image(0,0,100);
	grsim_update();
	wait_until_keypress();

	/* decode green1 */

	reset_data();
	decode_image(1,0,5);
	grsim_update();
	wait_until_keypress();

	/* decode green2 */

	reset_data();
	decode_image(1,0,10);
	grsim_update();
	wait_until_keypress();

	/* decode blue1 */

	reset_data();
	decode_image(2,4,10);
	grsim_update();
	wait_until_keypress();

	/* decode blue2 */

	reset_data();
	decode_image(2,4,15);
	grsim_update();
	wait_until_keypress();

	/* decode red1 */

	reset_data();
	decode_image(3,9,15);
	grsim_update();
	wait_until_keypress();

	/* decode red2 */

	reset_data();
	decode_image(3,9,20);
	grsim_update();
	wait_until_keypress();

	/* decode yellow1 */

	reset_data();
	decode_image(4,14,20);
	grsim_update();
	wait_until_keypress();






	return 0;
}
