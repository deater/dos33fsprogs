#include <stdio.h>
#include <math.h>

int gr_colors[16][3]={
	{  0,  0,  0},
	{227, 30, 96},
	{ 96, 78,189},
	{255, 68,253},
	{  0,163, 96},
	{156,156,156},
	{ 20,207,253},
	{208,195,255},
	{ 96,114,  3},
	{255,106, 60},
	{157,157,157},
	{255,160,208},
	{ 20,245, 60},
	{208,221,141},
	{114,255,208},
	{255,255,255},
};

int average(int col1, int col2) {

	double c1,c2,r1;

	c1=col1;
	c2=col2;

	c1=c1*c1;
	c2=c2*c2;

	r1=sqrt((c1+c2)/2.0);

//	printf("%lfx%lf=%lf %lf %lf\n",c1,c2,c1*c2,c1*c2/2.0,r1);

	return r1;

}

void gen_color(int col1, int col2) {

	printf("%d\t%d\t%d\tUntitled-%d-%d\n",
		average(gr_colors[col1][0],gr_colors[col2][0]),
		average(gr_colors[col1][1],gr_colors[col2][1]),
		average(gr_colors[col1][2],gr_colors[col2][2]),col1,col2);

	return;
}

void hex_color(int col1, int col2) {

	if (col1>=col2) 
	printf("\t\tcase 0x%02x%02x%02x: hi=%d; low=%d; break;\n",
		average(gr_colors[col1][0],gr_colors[col2][0]),
		average(gr_colors[col1][1],gr_colors[col2][1]),
		average(gr_colors[col1][2],gr_colors[col2][2]),col1,col2);

	return;
}


int main(int argc, char **argv) {

	int x,y;
#if 1
	printf("GIMP Palette\n");
	printf("Name: Apple II Lores Dither.gpl\n");
	printf("Columns: 16\n");
	printf("#\n");
	for(x=0;x<16;x++) {
		for(y=0;y<16;y++) {
			gen_color(x,y);
		}
	}
#else
	for(x=0;x<16;x++) {
		for(y=0;y<16;y++) {
			hex_color(x,y);
		}
	}
#endif
	return 0;
}
