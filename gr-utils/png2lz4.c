/*****************************************/
/* Converts a PNG to LZ4 compressed data */
/*****************************************/
/* Note, it ignores memory holes so only            */
/* safe to load high and copy to the right location */


#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <fcntl.h>

#include "loadpng.h"

#include "lz4.h"
#include "lz4hc.h"


#define OUTPUT_C	0
#define OUTPUT_ASM	1
#define OUTPUT_RAW	2

static int gr_offsets[24]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4A8,0x528,0x5A8,0x628,0x6A8,0x728,0x7A8,
	0x450,0x4D0,0x550,0x5D0,0x650,0x6D0,0x750,0x7D0,
};

static int gr_lz4(int out_type, char *varname, int xsize, int ysize,
		unsigned char *image) {

	unsigned char gr[1024];
	unsigned char output[2048];
	int x,y;
	int size,count=0;

	/* our image pointer is not-interleaved, but it does */
	/* have the top/bottom pixels properly packed for us */

	memset(gr,0,1024);

	if ((xsize!=40) && (ysize!=48)) {
		fprintf(stderr,"Error, wrong file size\n");
		return -1;
	}

	/* Copy our image into raw interleaved GR format */
	for(y=0;y<24;y++) {
		for(x=0;x<40;x++) {
			gr[(gr_offsets[y]-0x400)+x]=
				image[(y*xsize)+x];
		}
	}

	/* Fill in holes */
	/* Fill with last color in line for extra compression? */
	for(x=0x478;x<0x480;x++) gr[x-0x400]=gr[0x477-0x400];
	for(x=0x578;x<0x580;x++) gr[x-0x400]=gr[0x577-0x400];
	for(x=0x678;x<0x680;x++) gr[x-0x400]=gr[0x677-0x400];
	for(x=0x778;x<0x780;x++) gr[x-0x400]=gr[0x777-0x400];

	/* Now lz4 compress the thing */

	size=LZ4_compress_HC ((char *)gr,// src
			      (char *)output,	// dest
			      1024,	// src size
			      2048,	// src capacity
			      16);	// compression level


	/* Note, unlike the on-disk format we do *not* */
	/* have to skip 11 bytes at front or 8 bytes at end */
	/* also, we write the 16-bit size (little endian) at front */

	if (out_type==OUTPUT_C) {
		fprintf(stdout,"unsigned char %s[]={",varname);
		printf("\t0x%02X,0x%02X,\n",(size)&0xff,
				((size)>>8)&0xff);
		for(x=0;x<size;x++) {
			if (count%16==0) {
				printf("\n\t");
			}
			printf("0x%02X,",output[x]);
			count++;
		}
		printf("\n};\n");
	}
	else if (out_type==OUTPUT_ASM) {
//		int blargh;
//		blargh=open("blargh",O_CREAT|O_WRONLY,0777);
//		write(blargh,gr,1024);
//		close(blargh);

		fprintf(stdout,"%s:\n",varname);

		// size includes this size value
		printf("\t.byte $%02X,$%02X",(size+2)&0xff,
				((size+2)>>8)&0xff);
		for(x=0;x<size;x++) {
			if (count%16==0) {
				printf("\n\t.byte ");
			}
			else {
				printf(",");
			}
			printf("$%02X",output[x]);
			count++;
		}
	}
	else if (out_type==OUTPUT_RAW) {
		write(1,output,size);
	}
	else {
		return -1;
	}

	return (size+2);
}


/* Converts a PNG to LZ4 compressed data */

int main(int argc, char **argv) {

	unsigned char *image;
	int xsize,ysize;
	int size=0;
	int out_type=OUTPUT_C;

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s type INFILE varname\n\n",argv[0]);
		fprintf(stderr,"\ttype: c or asm or raw\n");
		fprintf(stderr,"\tvarname: label for graphic\n");
		fprintf(stderr,"\n");

		exit(-1);
	}

	if (!strcmp(argv[1],"c")) {
		out_type=OUTPUT_C;
	}
	else if (!strcmp(argv[1],"asm")) {
		out_type=OUTPUT_ASM;
	}
	else if (!strcmp(argv[1],"raw")) {
		out_type=OUTPUT_RAW;
	}

	if (loadpng(argv[2],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	printf("\n");

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	size=gr_lz4(out_type,argv[3],
		xsize,ysize,image);

	if (size<0) {
		return -1;
	}

	fprintf(stderr,"Size %d bytes\n",size);

	return 0;
}

