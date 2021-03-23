/* Convert 16x16 PNGs to 8+128 text for use in AppleII Basic bot loader */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

static int color_count=0;
static int colors[16];

static int find_color(int which) {
	int i;

	for(i=0;i<color_count;i++) {
		if (colors[i]==which) {
//			printf("Found %d at %d\n",which,i);
			return i;
		}
	}

	/* not found */
	colors[color_count]=which;
//	printf("New %d at %d\n",which,color_count);
	color_count++;

	return color_count-1;
}

int main(int argc, char **argv) {

	int i = 0, row,col;
	unsigned char in[1024];
	int op=0;
	int color;

	unsigned char *image;
	int xsize,ysize;

	if (argc<2) {
		fprintf(stderr,"Usage:\t%s INFILE\n\n",argv[0]);
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	memset(in,0,sizeof(in));

	memset(colors,0,sizeof(colors));

	for(row=0;row<ysize;row+=2) {
		for(i=0;i<2;i++) {
			for(col=0;col<xsize;col++) {
				if (i==0) {
					color=find_color(image[row/2*xsize+col]&0xf);
				}
				else {
					color=find_color(image[row/2*xsize+col]>>4);
				}
				in[op]=color;
				op++;
			}
		}
	}

	printf("Raw Image was %d bytes, %d colors\n",op,color_count);

#if 0
	for(i=0;i<color_count;i++) {
		printf("Color %d = %d (%c)\n",i,colors[i],colors[i]+35);
	}

	for(i=0;i<op;i++) {
		printf("%d,",in[i]);
		if (i%16==15) printf("\n");
	}
#endif
	for(i=0;i<8;i++) printf("%c",colors[i]+35);

	for(i=0;i<op;i+=2) printf("%c",((in[i+1]<<3)+in[i])+35);

	printf("\n");

	return 0;
}
