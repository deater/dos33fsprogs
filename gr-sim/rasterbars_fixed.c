#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"

static int row_color[40];

#define ELEMENTS	64

int fixed_sin[ELEMENTS][2]={
{0x00,0x00}, // 0.000000
{0x00,0x19}, // 0.098017
{0x00,0x31}, // 0.195090
{0x00,0x4A}, // 0.290285
{0x00,0x61}, // 0.382683
{0x00,0x78}, // 0.471397
{0x00,0x8E}, // 0.555570
{0x00,0xA2}, // 0.634393
{0x00,0xB5}, // 0.707107
{0x00,0xC5}, // 0.773010
{0x00,0xD4}, // 0.831470
{0x00,0xE1}, // 0.881921
{0x00,0xEC}, // 0.923880
{0x00,0xF4}, // 0.956940
{0x00,0xFB}, // 0.980785
{0x00,0xFE}, // 0.995185
{0x01,0x00}, // 1.000000
{0x00,0xFE}, // 0.995185
{0x00,0xFB}, // 0.980785
{0x00,0xF4}, // 0.956940
{0x00,0xEC}, // 0.923880
{0x00,0xE1}, // 0.881921
{0x00,0xD4}, // 0.831470
{0x00,0xC5}, // 0.773010
{0x00,0xB5}, // 0.707107
{0x00,0xA2}, // 0.634393
{0x00,0x8E}, // 0.555570
{0x00,0x78}, // 0.471397
{0x00,0x61}, // 0.382683
{0x00,0x4A}, // 0.290285
{0x00,0x31}, // 0.195090
{0x00,0x19}, // 0.098017
{0x00,0x00}, // 0.000000
{0xFF,0xE7}, // -0.098017
{0xFF,0xCF}, // -0.195090
{0xFF,0xB6}, // -0.290285
{0xFF,0x9F}, // -0.382683
{0xFF,0x88}, // -0.471397
{0xFF,0x72}, // -0.555570
{0xFF,0x5E}, // -0.634393
{0xFF,0x4B}, // -0.707107
{0xFF,0x3B}, // -0.773010
{0xFF,0x2C}, // -0.831470
{0xFF,0x1F}, // -0.881921
{0xFF,0x14}, // -0.923880
{0xFF,0x0C}, // -0.956940
{0xFF,0x05}, // -0.980785
{0xFF,0x02}, // -0.995185
{0xFF,0x00}, // -1.000000
{0xFF,0x02}, // -0.995185
{0xFF,0x05}, // -0.980785
{0xFF,0x0C}, // -0.956940
{0xFF,0x14}, // -0.923880
{0xFF,0x1F}, // -0.881921
{0xFF,0x2C}, // -0.831470
{0xFF,0x3B}, // -0.773010
{0xFF,0x4B}, // -0.707107
{0xFF,0x5E}, // -0.634393
{0xFF,0x72}, // -0.555570
{0xFF,0x88}, // -0.471397
{0xFF,0x9F}, // -0.382683
{0xFF,0xB6}, // -0.290285
{0xFF,0xCF}, // -0.195090
{0xFF,0xE7}, // -0.098017
};

int set_row_color(int offset, int color) {

	int y,s=0;

	short x;

	offset&=(ELEMENTS-1);

	x=(fixed_sin[offset][0]<<8) | (fixed_sin[offset][1]&0xff);

	y=x>>4;

	if (y<0) s=-1; else if (y==0) s=0; else s=1;

//	printf("Offset=%d Result=%hd y=%d,%d s=%d\n",offset,x,y,y-s,s);

	row_color[y+18]=color;
	row_color[y-s+18]=color;

	return 0;
}

int main(int argc, char **argv) {

	int ch,i=0,j;

	grsim_init();

	gr();
	clear_screens();

	while(1) {

		/* clear old colors */
		for(j=0;j<40;j++) row_color[j]=0;

		gr();

		set_row_color(i+7,14);	// aqua
		set_row_color(i+6,6);		// med-blue
		set_row_color(i+5,12);	// light-green
		set_row_color(i+4,4);		// green
		set_row_color(i+3,13);	// yellow
		set_row_color(i+2,9);		// orange
		set_row_color(i+1,11);	// pink
		set_row_color(i+0.0,1);		// red

		for(j=0;j<40;j++) {
			if (row_color[j]) {
				color_equals(row_color[j]);
				hlin(0,0,40,j);
			}
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(100000);

		i++;
		if (i>ELEMENTS-1) i=0;

//		printf("\n");
	}

	return 0;
}
