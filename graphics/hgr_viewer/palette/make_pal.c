#include <stdio.h>
#include <math.h>

static int gradient[9][16]={
	{0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{1,0,1,0, 0,0,0,0, 0,1,0,1, 0,0,0,0},
	{1,0,1,0, 0,1,0,1, 1,0,1,0, 0,1,0,1},
	{0,1,0,1, 1,1,1,1, 1,0,1,0, 1,1,1,1},
	{1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1},
	{2,1,2,1, 1,1,1,1, 1,2,1,2, 1,1,1,1},
	{2,1,2,1, 2,1,2,1, 2,1,2,1, 2,1,2,1},
	{1,2,1,2, 2,2,2,2, 2,1,2,1, 2,2,2,2},
	{2,2,2,2, 2,2,2,2, 2,2,2,2, 2,2,2,2},
};

static int pal_rgb[6][3]={
	{0x00,0x00,0x00},	// black
	{0x1b,0xcb,0x01},	// green
	{0xe4,0x34,0xfe},	// purple
	{0xcd,0x5b,0x01},	// orange
	{0x1b,0x9a,0xfe},	// blue
	{0x00,0x00,0x00},	// white
};

int main(int argc, char **argv) {

	int which=3;
	int c,x;

	int r,g,b;

	for(x=0;x<9;x++) {
			r=0;
			g=0;
			b=0;
		for(c=0;c<16;c++) {
			if (gradient[x][c]==0) {
			}
			if (gradient[x][c]==1) {
				r=r+2*(pal_rgb[which][0]*pal_rgb[which][0]);
				g=g+2*(pal_rgb[which][1]*pal_rgb[which][1]);
				b=b+2*(pal_rgb[which][2]*pal_rgb[which][2]);
			}
			if (gradient[x][c]==2) {
				r=r+2*(0xff*0xff);
				g=g+2*(0xff*0xff);
				b=b+2*(0xff*0xff);
			}
		}
		printf("%d %d %d\n",(int)sqrt(r/32.0),(int)sqrt(g/32.0),(int)sqrt(b/32.0));
	}
	return 0;
}
