#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

#include <png.h>

#define PAL_LENGTH	8	// PNG_MAX_PALETTE_LENGTH

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

	address=hgr_offset_table[temp]+temp2;

	return address;
}

#define COLOR_BLACK0	0
#define COLOR_GREEN	1
#define COLOR_PURPLE	2
#define COLOR_WHITE0	3

#define COLOR_BLACK1	4
#define COLOR_ORANGE	5
#define COLOR_BLUE	6
#define COLOR_WHITE1	7

// even = purple blue    01
// odd =  green  orange  10

//	ODD
//	0 0X 0	-> Black
//	0 0X 1  -> Black
//	0 1X 0  -> Green
//	0 1X 1  -> White
//	1 0X 0  -> Black
//	1 0X 1  -> Green
//	1 1X 0  -> White
//	1 1X 1	-> White


/* 000 00 00 -> black black black black */
/* 000 00 01 -> purpl black black black */
/* 000 00 10 -> black green black black */
/* 000 00 11 -> white white black black */

/* 000 01 00 -> black black purpl black */
/* 000 01 01 -> purpl purpl purpl black !!! */
/* 000 01 10 -> black white white black !!! */
/* 000 01 11 -> white white white black */

/* 000 10 00 -> black black black green */
/* 000 10 01 -> purpl black black green */
/* 000 10 10 -> black green green black */
/* 000 10 11 -> white white green green */

/* 000 11 00 -> black black white white */
/* 000 11 01 -> purpl purpl white white !!! */
/* 000 11 10 -> black white white white !!! */
/* 000 11 11 -> white white white white */


/*              even  odd */
/* 000 00 00 -> black black black black */
/* 000 00 01 -> purpl black black black */
/* 000 00 10 -> black green black black */
/* 000 00 11 -> white white black black */

/* 000 01 00 -> black black purpl black */
/* 000 01 01 -> purpl purpl purpl black !!! */
/* 000 01 10 -> black white white black !!! */
/* 000 01 11 -> white white white black */

// 00 00
// 00 01
// 00 10
// 00 11

// 01 00
// 01 01
// 01 10
// 01 11

// 10 00
// 10 01
// 10 10
// 10 11

// 11 00
// 11 01
// 11 10
// 11 11





// **
// 00 ->  KK
// 01 -> green
//	00 01 -> black purple     0 0
//	01 01 -> purple purple    1 0
//	10 01 -> black purple     0 0
//	11 01 -> purple purple    1 0
// 10 -> purple
//	00 10 -> black green
//	01 10 -> white black
//	10 10 -> green green
//	11 10 -> white green
// 11 -> WW


// 00 01 00  -> ?? KP ??
// 00 01 01  -> ?? KP ??
// 00 01 10  -> ?? KW ??
// 00 01 11  -> ?? KW ??

// 01 01 00  -> ?? PP ??
// 01 01 01  -> ?? PP ??
// 01 01 10  -> ?? PW ??
// 01 01 11  -> ?? PW ??

// 10 01 00  -> ?? KP ??
// 10 01 01  -> ?? KP ??
// 10 01 10  -> ?? KW ??
// 10 01 11  -> ?? KW ??







// even = purple blue
// odd =  green  orange

//	EVEN
//	0 X0 0	-> Black
//	0 X0 1  -> Black

//	0 X1 0  -> Black (green)
//	0 X1 1  -> White (green)

//	1 X0 0  -> Purple (purple)
//	1 X0 1  -> Purple (purple)

//	1 X1 0  -> White
//	1 X1 1	-> White


// 00
// 01
// 10
// 11

static int hgr_color_even(int high, int last, int current, int next) {

	if (!high) {
		if ((last==0) && (current==0)) return COLOR_BLACK0;
		if ((last==0) && (current==1)) {
			if (next==0) return COLOR_GREEN;
			else return COLOR_GREEN;
		}
		if ((last==1) && (current==0)) {
			if (next==0) return COLOR_PURPLE;
			else return COLOR_PURPLE;
		}
		if ((last==1) && (current==1)) return COLOR_WHITE0;
	}
	else {
		if ((last==0) && (current==0)) return COLOR_BLACK1;
		if ((last==0) && (current==1)) {
			if (next==0) return COLOR_ORANGE;
			else return COLOR_ORANGE;
		}
		if ((last==1) && (current==0)) {
			if (next==0) return COLOR_BLUE;
			else return COLOR_BLUE;
		}
		if ((last==1) && (current==1)) return COLOR_WHITE1;
	}
	return 0;
}


/*              even  odd */
/* 000 00 00 -> black black black black */
/* 000 00 01 -> purpl black black black */
/* 000 00 10 -> black green black black */
/* 000 00 11 -> white white black black */

/* 000 01 00 -> black black purpl black */
/* 000 01 01 -> purpl purpl purpl black !!! */
/* 000 01 10 -> black white white black !!! */
/* 000 01 11 -> white white white black */


//	ODD
//	0 0X 0	-> Black
//	0 0X 1  -> Black
//	0 1X 0  -> Green
//	0 1X 1  -> White
//	1 0X 0  -> Black
//	1 0X 1  -> Green
//	1 1X 0  -> White
//	1 1X 1	-> White

static int hgr_color_odd(int high, int last, int current, int next) {

	if (!high) {
		if ((last==0) && (current==0)) return COLOR_BLACK0;

		if ((last==0) && (current==1)) {
			if (next==0) return COLOR_GREEN;
			else return COLOR_GREEN;
		}
		if ((last==1) && (current==0)) {
			if (next==0) return COLOR_PURPLE;
			else return COLOR_PURPLE;
		}
		if ((last==1) && (current==1)) return COLOR_WHITE0;
	}
	else {
		if ((last==0) && (current==0)) return COLOR_BLACK1;
		if ((last==0) && (current==1)) {
			if (next==0) return COLOR_ORANGE;
			else return COLOR_ORANGE;
		}
		if ((last==1) && (current==0)) {
			if (next==0) return COLOR_BLUE;
			else return COLOR_BLUE;
		}
		if ((last==1) && (current==1)) return COLOR_WHITE1;
	}
	return 0;
}




int main(int argc, char **argv) {

	int fd;
	char filename[256];
	char screen[8192];
	FILE *output;
	int width=280,height=192,y,x;
	png_byte color_type=PNG_COLOR_TYPE_PALETTE;
	png_byte bit_depth=8;

	png_structp png_ptr;
	png_infop info_ptr;
//	int number_of_passes;
	png_bytep *row_pointers;
	png_colorp palette;
	png_color *col;

	if (argc<2) {
		fprintf(stderr,"Usage: hgr2 FILENAME OUTPUT\n");
		fprintf(stderr,"  where FILENAME is an 8k AppleII HIRES image\n\n");
		return -1;
	}

	if (argc<3) {
		sprintf(filename,"%s.png",argv[1]);
	}
	else {
		strncpy(filename,argv[2],256-1);
	}

	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		printf("Error opening %s! %s\n",argv[1],strerror(errno));
		return -1;
	}
	read(fd,screen,8192);
	close(fd);


	output = fopen(filename, "wb");
	if (output==NULL) {
		printf("Error opening %s, %s\n",filename,strerror(errno));
		return -1;
	}

	/* initialize */
	png_ptr = png_create_write_struct(
			PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

        if (png_ptr==NULL) {
		fprintf(stderr,"Error!  png_create_write_struct() failed\n");
		return -1;
	}

        info_ptr = png_create_info_struct(png_ptr);
        if (info_ptr==NULL) {
		fprintf(stderr,"Error!  png_create_info_struct() failed\n");
		return -1;
	}

//	setjmp(png_jmpbuf(png_ptr));

	png_init_io(png_ptr, output);

        /* write header */
//	setjmp(png_jmpbuf(png_ptr));

	png_set_IHDR(png_ptr, info_ptr, width, height,
			bit_depth, color_type, PNG_INTERLACE_NONE,
			PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

//	png_write_info(png_ptr, info_ptr);

	/* set palette */
	palette = (png_colorp)png_malloc(png_ptr,
		PAL_LENGTH * (sizeof (png_color)));

	/* 0: black 0 */
	col=&palette[0];
	col->red=0;
	col->green=0;
	col->blue=0;

	/* 1: green */
	col=&palette[1];
	col->red=0x1b;
	col->green=0xcb;
	col->blue=0x01;

	/* 2: purple */
	col=&palette[2];
	col->red=0xe4;
	col->green=0x34;
	col->blue=0xfe;

	/* 3: white0 */
	col=&palette[3];
	col->red=0xff;
	col->green=0xff;
	col->blue=0xff;

	/* 4: black1 */
	col=&palette[4];
	col->red=0;
	col->green=0;
	col->blue=0;

	/* 5: orange */
	col=&palette[5];
	col->red=0xcd;
	col->green=0x5b;
	col->blue=0x01;

	/* 6: blue */
	col=&palette[6];
	col->red=0x1b;
	col->green=0x9a;
	col->blue=0xfe;

	/* 7: white1 */
	col=&palette[7];
	col->red=0xff;
	col->green=0xff;
	col->blue=0xff;

	/* ... Set palette colors ... */
	png_set_PLTE(png_ptr, info_ptr, palette, PAL_LENGTH);

	png_write_info(png_ptr, info_ptr);



	row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * height);

	for(y=0;y<height;y++) {
		row_pointers[y]=malloc(width);
	}

	/*********************************************/
	/* do the actual conversion                  */
	/*********************************************/
	unsigned char byte1,byte2,byte3;
	int out_ptr,color1,color2,prev=0;
	for(y=0;y<height;y++) {
		out_ptr=0;
		for(x=0;x<20;x++) {
			byte1=screen[hgr_offset(y)+x*2];
			byte2=screen[hgr_offset(y)+x*2+1];
			if (x==19) byte3=0;
			else byte3=screen[hgr_offset(y)+x*2+2];

			/* 10 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte1&0x80,
					(byte1>>0)&0x1,
					(byte1>>1)&0x1,
					(byte1>>2)&0x1);
			color2=hgr_color_odd(byte1&0x80,
					(byte1>>0)&0x1,
					(byte1>>1)&0x1,
					(byte1>>2)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;

			/* 32 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte1&0x80,
					(byte1>>2)&0x1,
					(byte1>>3)&0x1,
					(byte1>>4)&0x1);
			color2=hgr_color_odd(byte1&0x80,
					(byte1>>2)&0x1,
					(byte1>>3)&0x1,
					(byte1>>4)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;

			/* 54 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte1&0x80,
					(byte1>>4)&0x1,
					(byte1>>5)&0x1,
					(byte1>>6)&0x1);
			color2=hgr_color_odd(byte1&0x80,
					(byte1>>4)&0x1,
					(byte1>>5)&0x1,
					(byte1>>6)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;

			/* 06 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte1&0x80,
					(byte1>>6)&0x1,
					(byte2>>0)&0x1,
					(byte2>>1)&0x1);
			color2=hgr_color_odd(byte2&0x80,
					(byte1>>6)&0x1,
					(byte2>>0)&0x1,
					(byte2>>1)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;


			/* 21 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte2&0x80,
					(byte2>>1)&0x1,
					(byte2>>2)&0x1,
					(byte2>>3)&0x1);
			color2=hgr_color_odd(byte2&0x80,
					(byte2>>1)&0x1,
					(byte2>>2)&0x1,
					(byte2>>3)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;

			/* 43 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte2&0x80,
					(byte2>>3)&0x1,
					(byte2>>4)&0x1,
					(byte2>>5)&0x1);
			color2=hgr_color_odd(byte2&0x80,
					(byte2>>3)&0x1,
					(byte2>>4)&0x1,
					(byte2>>5)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;

			/* 65 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte2&0x80,
					(byte2>>5)&0x1,
					(byte2>>6)&0x1,
					(byte3>>0)&0x1);
			color2=hgr_color_odd(byte2&0x80,
					(byte2>>5)&0x1,
					(byte2>>6)&0x1,
					(byte3>>0)&0x1);

			row_pointers[y][out_ptr]=color1;
			out_ptr++;
			row_pointers[y][out_ptr]=color2;
			out_ptr++;


		}
	}

        png_write_image(png_ptr, row_pointers);


	png_write_end(png_ptr, NULL);

	/* cleanup heap allocation */
	for (y=0; y<height; y++) {
		free(row_pointers[y]);
	}
	free(row_pointers);

	fclose(output);

	return 0;
}
