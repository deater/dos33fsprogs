#include <stdio.h>
#include <math.h>
#include <stdint.h>

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

/* Note, this isn't the actual numbering used on Apple II */
#define COLOR_BLACK	0
#define COLOR_GREEN	1
#define COLOR_PURPLE	2
#define COLOR_ORANGE	3
#define COLOR_BLUE	4
#define COLOR_WHITE	5

static int pal_rgb[6][3]={
	{0x00,0x00,0x00},	// black
	{0x1b,0xcb,0x01},	// green
	{0xe4,0x34,0xfe},	// purple
	{0xcd,0x5b,0x01},	// orange
	{0x1b,0x9a,0xfe},	// blue
	{0x00,0x00,0x00},	// white
};

static char qualifiers[9][32]={
	"",
	"Darkest",
	"Dark",
	"LightDark",
	"",
	"Darklight",
	"Light",
	"Lightest"
	"",
};

static int do_gradient(char *name,uint32_t cr, uint32_t cg, uint32_t cb) {

	int c,x;
	int r,g,b;

	for(x=1;x<8;x++) {
		r=0;
		g=0;
		b=0;
		for(c=0;c<16;c++) {
			if (gradient[x][c]==0) {
			}
			if (gradient[x][c]==1) {
				r=r+2*(cr*cr);
				g=g+2*(cg*cg);
				b=b+2*(cb*cb);
			}
			if (gradient[x][c]==2) {
				r=r+2*(0xff*0xff);
				g=g+2*(0xff*0xff);
				b=b+2*(0xff*0xff);
			}
		}
		printf("%4d %4d %4d ",
			(int)sqrt(r/32.0),
			(int)sqrt(g/32.0),
			(int)sqrt(b/32.0));
		if (qualifiers[x][0]) printf("%s ",qualifiers[x]);
		printf("%s\n",name);

	}

	return 0;
}

static int do_stripe(char *name,uint32_t cr1, uint32_t cg1, uint32_t cb1,
	uint32_t cr2, uint32_t cg2, uint32_t cb2) {

	int r,g,b;

	r=0;
	g=0;
	b=0;


	r=r+2*(cr1*cr1);
	g=g+2*(cg1*cg1);
	b=b+2*(cb1*cb1);

	r=r+2*(cr2*cr2);
	g=g+2*(cg2*cg2);
	b=b+2*(cb2*cb2);

	printf("%4d %4d %4d ",
			(int)sqrt(r/4.0),
			(int)sqrt(g/4.0),
			(int)sqrt(b/4.0));
	printf("%s\n",name);

	return 0;
}


int main(int argc, char **argv) {

	printf("GIMP Palette\n");
	printf("Name: Hires Gradient Total\n");
	printf("Columns: 7\n");
	printf("#\n");



	do_gradient("Orange",pal_rgb[COLOR_ORANGE][0],
			pal_rgb[COLOR_ORANGE][1],
			pal_rgb[COLOR_ORANGE][2]);
	do_gradient("Blue",pal_rgb[COLOR_BLUE][0],
			pal_rgb[COLOR_BLUE][1],
			pal_rgb[COLOR_BLUE][2]);

	do_gradient("Purple",
			pal_rgb[COLOR_PURPLE][0],
			pal_rgb[COLOR_PURPLE][1],
			pal_rgb[COLOR_PURPLE][2]);
	do_gradient("Green",
			pal_rgb[COLOR_GREEN][0],
			pal_rgb[COLOR_GREEN][1],
			pal_rgb[COLOR_GREEN][2]);
	do_gradient("Grey",
			pal_rgb[COLOR_WHITE][0],
			pal_rgb[COLOR_WHITE][1],
			pal_rgb[COLOR_WHITE][2]);

	do_stripe("PurpleGreen",
			pal_rgb[COLOR_GREEN][0],
			pal_rgb[COLOR_GREEN][1],
			pal_rgb[COLOR_GREEN][2],
			pal_rgb[COLOR_PURPLE][0],
			pal_rgb[COLOR_PURPLE][1],
			pal_rgb[COLOR_PURPLE][2]);

	do_stripe("OrangeGreen",
			pal_rgb[COLOR_GREEN][0],
			pal_rgb[COLOR_GREEN][1],
			pal_rgb[COLOR_GREEN][2],
			pal_rgb[COLOR_ORANGE][0],
			pal_rgb[COLOR_ORANGE][1],
			pal_rgb[COLOR_ORANGE][2]);

	do_stripe("BlueGreen",
			pal_rgb[COLOR_GREEN][0],
			pal_rgb[COLOR_GREEN][1],
			pal_rgb[COLOR_GREEN][2],
			pal_rgb[COLOR_BLUE][0],
			pal_rgb[COLOR_BLUE][1],
			pal_rgb[COLOR_BLUE][2]);

	do_stripe("PurpleBlue",
			pal_rgb[COLOR_PURPLE][0],
			pal_rgb[COLOR_PURPLE][1],
			pal_rgb[COLOR_PURPLE][2],
			pal_rgb[COLOR_BLUE][0],
			pal_rgb[COLOR_BLUE][1],
			pal_rgb[COLOR_BLUE][2]);

	do_stripe("OrangeBlue",
			pal_rgb[COLOR_ORANGE][0],
			pal_rgb[COLOR_ORANGE][1],
			pal_rgb[COLOR_ORANGE][2],
			pal_rgb[COLOR_BLUE][0],
			pal_rgb[COLOR_BLUE][1],
			pal_rgb[COLOR_BLUE][2]);


	/* hard-code black and white */
	printf("%4d %4d %4d Black\n",0,0,0);
	printf("%4d %4d %4d White\n",255,255,255);

	return 0;
}

/*
114 26 127  Darkest Green
161 36 179  Dark Green
197 45 219  LightDark Green
228 52 254  Green
235 135 254 Darklight Green
241 184 254 Light Green
248 222 254 Lightest Green
13 101 0    Darkest Purple
19 143 0    Dark Purple
23 175 0    Lightdark Purple
27 203 1    Purple
129 217 127 Darklight Purple
181 230 180 Light Purple
221 243 220 Lightest Purple
*/
