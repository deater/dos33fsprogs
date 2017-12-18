#include <stdio.h>
#include <stdlib.h>
#include <string.h>


static int runlen[4]={0,0,0,0},last_color[4]={-1,-1,-1,-1};
static int new_size=0;

static unsigned char row[4][256];

static int rle_compress(int color, int j) {

	int need_comma=0;

	if ((color==last_color[j]) && (runlen[j]<255)) {
		runlen[j]++;
//		printf("Match %d %d\n",color,runlen[j]);
	}
	else {
		need_comma=1;
//		printf("Run of color %d length %d\n",
//			last_color[j],runlen[j]);
		if (runlen[j]==0) { // first color, skip
			need_comma=0;
		}
		else if (runlen[j]==1) {
			printf("$%02X",last_color[j]);
			new_size++;
		}
		else if (runlen[j]==2) {
			printf("$%02X,$%02X",last_color[j],last_color[j]);
			new_size+=2;
		}
		else if ((runlen[j]>2) && (runlen[j]<16)) {
			printf("$%02X,$%02X",0xa0 | (runlen[j]),
				last_color[j]);
			new_size+=2;
		}
		/* We could in theory compress up to 272 */
		/* but we leave it at 256 to make the decode easier */
		else if ((runlen[j]>15) && (runlen[j]<256)) {
			new_size+=3;
			printf("$%02X,$%02X,$%02X",0xa0,
				runlen[j],last_color[j]);
		}
		else if (runlen[j]>=256) {
			printf("Too big!\n");
			exit(1);
		}
		last_color[j]=color;
		runlen[j]=1;

	}
	return need_comma;
}

void plot(int x, int y, int color) {

	int half,odd;

	half=y/2;

	odd=y&1;

	if (odd) {
		row[half][x]=row[half][x]|(color<<4);
	}
	else {
		row[half][x]=row[half][x]|(color);
	}

}



int main(int argc, char **argv) {

	int length=0,x,y;
	int need_comma;

	memset(row,0,sizeof(row));
	length=255;

	/* 0 - 20 */
	plot(2,5,15);	plot(5,2,15);	plot(9,1,13);
	plot(12,3,15);	plot(13,5,15);	plot(16,5,15);	plot(17,2,15);

	plot(19,1,5);	plot(20,0,5);	plot(20,2,5);	plot(21,1,5);
	plot(20,1,15);

	/* 20-40 */
	plot(24,4,7);	plot(29,5,7);	plot(30,2,15);	plot(33,0,15);
	plot(35,2,5);

	/* 41-60 */
	plot(41,0,13);	plot(42,0,13);
			plot(42,1,13);	plot(43,1,13);
					plot(43,2,13);
					plot(43,3,13);
			plot(42,4,13);	plot(43,4,13);
	plot(41,5,13);	plot(42,5,13);

	plot(49,5,13);	plot(51,1,15); 	plot(51,2,15);
	plot(53,3,15);	plot(55,3,15);	plot(55,4,15);
	plot(57,0,1);	plot(57,1,1);

	/* Copy edges to make it wrap around */
	for(y=0;y<4;y++) {
		for(x=0;x<40;x++) {
			row[y][x+182]=row[y][x];
		}
	}

	printf("; Original size = %d bytes\n",length*4);

	printf("sky_background:\n");
	printf("; scroll_length:\n.byte %d\n",length);
	for(y=0;y<4;y++) {
		//printf("scroll_row%d:\n",y+1);
		printf("\t.byte ");
		for(x=0;x<256;x++) {
			need_comma=rle_compress(row[y][x],y);
			if ((need_comma)) {// && (x!=length-1)) 
				printf(",");
			}
			//last_color[y]=row[y][x];
		}
		rle_compress(-1,y);
		printf("\n");
	}
	printf("\t.byte $A1\n");
	new_size++;
	printf("; Compressed size = %d bytes\n",new_size);


	return 0;
}
