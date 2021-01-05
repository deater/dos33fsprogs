/* Convert a 40x48d image into two, 40x48 images suitable of loading */
/* with my kfest18 based code, inteleaving at one scanline resolution */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <png.h>

#include "rle_common.h"

static int convert_color(int color,int which) {

	int hi,low;

	switch(color) {
		case 0x000000: hi=0; low=0; break;
		case 0xa01543: hi=1; low=0; break;
		case 0xe31e60: hi=1; low=1; break;
		case 0x433785: hi=2; low=0; break;
		case 0xae3b95: hi=2; low=1; break;
		case 0x604ebd: hi=2; low=2; break;
		case 0xb430b2: hi=3; low=0; break;
		case 0xf134bf: hi=3; low=1; break;
		case 0xc049df: hi=3; low=2; break;
		case 0xff44fd: hi=3; low=3; break;
		case 0x007343: hi=4; low=0; break;
		case 0xa07560: hi=4; low=1; break;
		case 0x437f95: hi=4; low=2; break;
		case 0xb47cbf: hi=4; low=3; break;
		case 0x00a360: hi=4; low=4; break;
		case 0x6e6e6e: hi=5; low=0; break;
		case 0xc27081: hi=5; low=1; break;
		case 0x817bad: hi=5; low=2; break;
		case 0xd378d2: hi=5; low=3; break;
		case 0x6e9f81: hi=5; low=4; break;
		case 0x9c9c9c: hi=5; low=5; break;
		case 0x0e92b2: hi=6; low=0; break;
		case 0xa193bf: hi=6; low=1; break;
		case 0x459cdf: hi=6; low=2; break;
		case 0xb49afd: hi=6; low=3; break;
		case 0x0ebabf: hi=6; low=4; break;
		case 0x6fb7d2: hi=6; low=5; break;
		case 0x14cffd: hi=6; low=6; break;
		case 0x9389b4: hi=7; low=0; break;
		case 0xd98bc0: hi=7; low=1; break;
		case 0xa194e0: hi=7; low=2; break;
		case 0xe892fe: hi=7; low=3; break;
		case 0x93b3c0: hi=7; low=4; break;
		case 0xb7b0d3: hi=7; low=5; break;
		case 0x93c9fe: hi=7; low=6; break;
		case 0xd0c3ff: hi=7; low=7; break;
		case 0x435002: hi=8; low=0; break;
		case 0xae5343: hi=8; low=1; break;
		case 0x606185: hi=8; low=2; break;
		case 0xc05db2: hi=8; low=3; break;
		case 0x438c43: hi=8; low=4; break;
		case 0x81886e: hi=8; low=5; break;
		case 0x45a7b2: hi=8; low=6; break;
		case 0xa19fb4: hi=8; low=7; break;
		case 0x607203: hi=8; low=8; break;
		case 0xb44a2a: hi=9; low=0; break;
		case 0xf14d50: hi=9; low=1; break;
		case 0xc05d8c: hi=9; low=2; break;
		case 0xff59b7: hi=9; low=3; break;
		case 0xb48950: hi=9; low=4; break;
		case 0xd38576: hi=9; low=5; break;
		case 0xb4a4b7: hi=9; low=6; break;
		case 0xe89cb9: hi=9; low=7; break;
		case 0xc06e2a: hi=9; low=8; break;
		case 0xff6a3c: hi=9; low=9; break;
#if 0
		case 0x6f6f6f: hi=10; low=0; break;
		case 0xc37182: hi=10; low=1; break;
		case 0x827bad: hi=10; low=2; break;
		case 0xd378d2: hi=10; low=3; break;
		case 0x6fa082: hi=10; low=4; break;
		case 0x9c9c9c: hi=10; low=5; break;
		case 0x6fb7d2: hi=10; low=6; break;
		case 0xb8b1d3: hi=10; low=7; break;
		case 0x82896f: hi=10; low=8; break;
		case 0xd38576: hi=10; low=9; break;
		case 0x9d9d9d: hi=10; low=10; break;
#endif
		case 0xb47193: hi=11; low=0; break;
		case 0xf173a1: hi=11; low=1; break;
		case 0xc07dc6: hi=11; low=2; break;
		case 0xff7ae7: hi=11; low=3; break;
		case 0xb4a1a1: hi=11; low=4; break;
		case 0xd39eb7: hi=11; low=5; break;
		case 0xb4b8e7: hi=11; low=6; break;
		case 0xe8b2e8: hi=11; low=7; break;
		case 0xc08a93: hi=11; low=8; break;
		case 0xff8799: hi=11; low=9; break;
		case 0xd39eb8: hi=11; low=10; break;
		case 0xffa0d0: hi=11; low=11; break;
		case 0x0ead2a: hi=12; low=0; break;
		case 0xa1ae50: hi=12; low=1; break;
		case 0x45b58c: hi=12; low=2; break;
		case 0xb4b3b7: hi=12; low=3; break;
		case 0x0ed050: hi=12; low=4; break;
		case 0x6fcd76: hi=12; low=5; break;
		case 0x14e2b7: hi=12; low=6; break;
		case 0x93ddb9: hi=12; low=7; break;
		case 0x45bf2a: hi=12; low=8; break;
		case 0xb4bc3c: hi=12; low=9; break;
//		case 0x6fcd76: hi=12; low=10; break;
		case 0xb4ce99: hi=12; low=11; break;
		case 0x14f53c: hi=12; low=12; break;
		case 0x939c63: hi=13; low=0; break;
		case 0xd99d78: hi=13; low=1; break;
		case 0xa1a5a6: hi=13; low=2; break;
		case 0xe8a3cc: hi=13; low=3; break;
		case 0x93c278: hi=13; low=4; break;
		case 0xb7bf94: hi=13; low=5; break;
		case 0x93d6cc: hi=13; low=6; break;
		case 0xd0d0ce: hi=13; low=7; break;
		case 0xa1af63: hi=13; low=8; break;
		case 0xe8ad6c: hi=13; low=9; break;
		case 0xb8bf95: hi=13; low=10; break;
		case 0xe8c0b1: hi=13; low=11; break;
		case 0x93e96c: hi=13; low=12; break;
		case 0xd0dd8d: hi=13; low=13; break;
		case 0x50b493: hi=14; low=0; break;
		case 0xb3b5a1: hi=14; low=1; break;
		case 0x69bcc6: hi=14; low=2; break;
		case 0xc5bae7: hi=14; low=3; break;
		case 0x50d6a1: hi=14; low=4; break;
		case 0x88d3b7: hi=14; low=5; break;
		case 0x51e8e7: hi=14; low=6; break;
		case 0xa7e2e8: hi=14; low=7; break;
		case 0x69c593: hi=14; low=8; break;
		case 0xc5c399: hi=14; low=9; break;
		case 0x89d3b8: hi=14; low=10; break;
		case 0xc5d4d0: hi=14; low=11; break;
		case 0x51fa99: hi=14; low=12; break;
		case 0xa7eeb1: hi=14; low=13; break;
		case 0x72ffd0: hi=14; low=14; break;
		case 0xb4b4b4: hi=15; low=0; break;
		case 0xf1b5c0: hi=15; low=1; break;
		case 0xc0bce0: hi=15; low=2; break;
		case 0xffbafe: hi=15; low=3; break;
		case 0xb4d6c0: hi=15; low=4; break;
		case 0xd3d3d3: hi=15; low=5; break;
		case 0xb4e8fe: hi=15; low=6; break;
		case 0xe8e2ff: hi=15; low=7; break;
		case 0xc0c5b4: hi=15; low=8; break;
		case 0xffc3b9: hi=15; low=9; break;
//		case 0xd3d3d3: hi=15; low=10; break;
		case 0xffd4e8: hi=15; low=11; break;
		case 0xb4fab9: hi=15; low=12; break;
		case 0xe8eece: hi=15; low=13; break;
		case 0xc5ffe8: hi=15; low=14; break;
		case 0xffffff: hi=15; low=15; break;


		default:
			printf("Unknown color %x\n",color);
			break;
	}

	if (which==0) return hi;
	else return low;
}



/* expects a PNG where the xsize is 40 */
int loadpng(char *filename, unsigned char **image_ptr, int *xsize, int *ysize,
		int high) {

	int x,y;
	int color;
	FILE *infile;
	int debug=0;
	unsigned char *image,*out_ptr;
	int width, height;
	int a2_color;

	png_byte bit_depth;
	png_structp png_ptr;
	png_infop info_ptr;
	png_bytep *row_pointers;
	png_byte color_type;
//	int number_of_passes;

	unsigned char header[8];

        /* open file and test for it being a png */
        infile = fopen(filename, "rb");
        if (infile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",filename);
		return -1;
	}

	/* Check the header */
        fread(header, 1, 8, infile);
        if (png_sig_cmp(header, 0, 8)) {
		fprintf(stderr,"Error!  %s is not a PNG file\n",filename);
		return -1;
	}

        /* initialize stuff */
        png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
        if (!png_ptr) {
		fprintf(stderr,"Error create_read_struct\n");
		exit(-1);
	}

        info_ptr = png_create_info_struct(png_ptr);
        if (!info_ptr) {
		fprintf(stderr,"Error png_create_info_struct\n");
		exit(-1);
	}

	png_init_io(png_ptr, infile);
	png_set_sig_bytes(png_ptr, 8);

	png_read_info(png_ptr, info_ptr);

	width = png_get_image_width(png_ptr, info_ptr);
	height = png_get_image_height(png_ptr, info_ptr);
	*xsize=width;
	*ysize=height;

	color_type = png_get_color_type(png_ptr, info_ptr);
	bit_depth = png_get_bit_depth(png_ptr, info_ptr);



	if (debug) {
		printf("PNG: width=%d height=%d depth=%d\n",width,height,bit_depth);
		if (color_type==PNG_COLOR_TYPE_RGB) printf("Type RGB\n");
		else if (color_type==PNG_COLOR_TYPE_RGB_ALPHA) printf("Type RGBA\n");
		else if (color_type==PNG_COLOR_TYPE_PALETTE) printf("Type palette\n");
	}

//        number_of_passes = png_set_interlace_handling(png_ptr);
	png_read_update_info(png_ptr, info_ptr);

	row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * height);
	for (y=0; y<height; y++) {
		row_pointers[y] = (png_byte*) malloc(png_get_rowbytes(png_ptr,info_ptr));
	}

	png_read_image(png_ptr, row_pointers);

	fclose(infile);

	image=calloc(width*height,sizeof(unsigned char));
	if (image==NULL) {
		fprintf(stderr,"Memory error!\n");
		return -1;
	}
	out_ptr=image;

	if (color_type==PNG_COLOR_TYPE_RGB_ALPHA) {
		for(y=0;y<height;y+=2) {
			for(x=0;x<width;x++) {

				/* top color */
				color=	(row_pointers[y][x*4]<<16)+
					(row_pointers[y][x*4+1]<<8)+
					(row_pointers[y][x*4+2]);
				if (debug) {
					printf("%x ",color);
				}

				a2_color=convert_color(color,high);

				/* bottom color */
				color=	(row_pointers[y+1][x*4]<<16)+
					(row_pointers[y+1][x*4+1]<<8)+
					(row_pointers[y+1][x*4+2]);
				if (debug) {
					printf("%x ",color);
				}

				a2_color|=(convert_color(color,high)<<4);

				*out_ptr=a2_color;
				out_ptr++;
			}
			if (debug) printf("\n");
		}
	}
	else if (color_type==PNG_COLOR_TYPE_PALETTE) {

		for(y=0;y<height;y+=2) {
			for(x=0;x<width;x++) {

				if (high) {
					/* top color */
					a2_color=row_pointers[y][x]/16;

					/* bottom color */
					color=row_pointers[y+1][x]/16;
				}
				else {
					/* top color */
					a2_color=row_pointers[y][x]%16;

					/* bottom color */
					color=row_pointers[y+1][x]%16;
				}

				a2_color|=(color<<4);

				if (debug) {
					printf("%x ",a2_color);
				}

				*out_ptr=a2_color;
				out_ptr++;
			}
			if (debug) printf("\n");
		}
	}
	else {
		printf("Unknown color type\n");
	}

	/* Stripe test image */
//	for(x=0;x<40;x++) for(y=0;y<40;y++) image[(y*width)+x]=y%16;

/*
	Addr		Row	/80	%40
	$400	0	0	0	0
	$428	28	16	0
	$450	50	32	0
	$480	80	2	1
	$4A8	a8	18	1
	$4D0	d0	34	1
	$500	100	3	2
	0,0 0,1 0,2....0,39 16,0 16,1 ....16,39 32,0..32,39, X X X X X X X X
*/

	*image_ptr=image;

	return 0;
}

/* Converts a PNG to RLE compressed data */

int main(int argc, char **argv) {

	unsigned char *image;
	int xsize,ysize;
	int size=0;
	int out_type=OUTPUT_C;
	char output_name[BUFSIZ];

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s type INFILE varname\n\n",argv[0]);
		fprintf(stderr,"\ttype: c or asm\n");
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

	if (loadpng(argv[2],&image,&xsize,&ysize,1)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	sprintf(output_name,"%s_low",argv[3]);
	size=rle_smaller(out_type,output_name,
		xsize,ysize,image);

	fprintf(stderr,"Size %d bytes\n",size);

	if (loadpng(argv[2],&image,&xsize,&ysize,0)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

//	size=rle_original(out_type,argv[3],
//		xsize,ysize,image);

	sprintf(output_name,"%s_high",argv[3]);
	size=rle_smaller(out_type,output_name,
		xsize,ysize,image);

	fprintf(stderr,"Size %d bytes\n",size);


	return 0;
}







