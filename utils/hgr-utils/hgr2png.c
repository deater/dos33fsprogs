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



// 00 always black
// 11 always white
//
//
// GREEN/ORANGE
// PURPLE/BLUE

//   EO
//00 01 00
//
//on screen	in memory
//00 00 00	0'0 00 00 00	$00
//
//what about EVEN
//                        O P                       PO
//01 01 00	0'0 00 10 10	$0A	KG GG KK  101 -> G
//01 01 01	0'0 10 10 10	$2A/42	KG GG GG  101 -> G
//01 01 10	0'0 01 10 10	$1A/26	KG GW WK  101 -> G
//01 01 11	0'0 11 10 10	$3A/58	KG GG WW  101 -> G

//what about ODD
//                     N T                           TN
//01 01 00	0'0 00 10 10	$0A	KG GG KK  010 -> G
//01 01 01	0'0 10 10 10	$2A/42	KG GG GG  010 -> G
//01 01 10	0'0 01 10 10	$1A/26	KG GW WK  011 -> W
//01 01 11	0'0 11 10 10	$3A/58	KG GW WW  011 -> W


//what about 11 01 01       10 10 11

//-----------------

//EVEN -- pass in prev, one
//		        O P                       PO
//00 01 00	0'0 00 10 00	$08	KK KG KK  001 -> K
//01 01 00	0'0 00 10 10	$0A	KG GG KK  101 -> G
//10 01 00	0'0 00 10 01	$09	PK KG KK  001 -> K
//11 01 00	0'0 00 10 11	$0B	WW GG KK  101 -> G
//
//00 10 00	0'0 00 01 00	$04	KK PK KK  010 -> P
//01 10 00	0'0 00 01 10	$06	KW WK KK  110 -> W
//10 10 00	0'0 00 01 01	$05	PP PK KK  010 -> P
//11 10 00	0'0 00 01 11	$07	WW WK KK  110 -> W

//ODD	-- page in two, next
//                     N T                           TN
//00 01 00	0'0 00 10 00	$08	KK KG KK  010 -> G
//00 01 01	0'0 10 10 00	$28/40	KK KG GG  010 -> G
//00 01 10	0'0 01 10 00	$18/24	KK KW WK  011 -> W
//00 01 11	0'0 11 10 00	$38/56	KK KW WW  011 -> W
//
//00 10 00	0'0 00 01 00	$04	KK PK KK  100 -> K
//00 10 01	0'0 10 01 00	$24/36	KK PK KG  100 -> K
//00 10 10	0'0 01 01 00	$14/20	KK PP PK  101 -> P
//00 10 11	0'0 11 01 00	$34/52	KK PP WW  101 -> P



//-------------------------------------------------------------

static int hgr_color_even(int high, int prev, int one, int two) {

	if (!high) {
		if ((one==0) && (two==0)) return COLOR_BLACK0;
		if ((one==1) && (two==1)) return COLOR_WHITE0;

		if ((prev==0) && (one==0)) return COLOR_BLACK0;
		// PURPLE
		if ((prev==0) && (one==1)) return COLOR_PURPLE;
		// GREEN
		if ((prev==1) && (one==0)) return COLOR_GREEN;
		if ((prev==1) && (one==1)) return COLOR_WHITE0;
	}
	else {
		if ((one==0) && (two==0)) return COLOR_BLACK1;
		if ((one==1) && (two==1)) return COLOR_WHITE1;

		if ((prev==0) && (one==0)) return COLOR_BLACK1;
		// BLUE
		if ((prev==0) && (one==1)) return COLOR_BLUE;
		// ORANGE
		if ((prev==1) && (one==0)) return COLOR_ORANGE;
		if ((prev==1) && (one==1)) return COLOR_WHITE1;
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

static int hgr_color_odd(int high, int one, int two, int next) {

	if (!high) {
		if ((one==0) && (two==0)) return COLOR_BLACK0;
		if ((one==1) && (two==1)) return COLOR_WHITE0;

		if ((two==0) && (next==0)) return COLOR_BLACK0;
		// Purple
		if ((two==0) && (next==1)) return COLOR_PURPLE;
		// Green
		if ((two==1) && (next==0)) return COLOR_GREEN;
		if ((two==1) && (next==1)) return COLOR_WHITE0;
	}
	else {
		if ((one==0) && (two==0)) return COLOR_BLACK1;
		if ((one==1) && (two==1)) return COLOR_WHITE1;

		if ((two==0) && (next==0)) return COLOR_BLACK1;
		if ((two==0) && (next==1)) return COLOR_BLUE;
		if ((two==1) && (next==0)) return COLOR_ORANGE;
		if ((two==1) && (next==1)) return COLOR_WHITE1;
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
	col->red=1;
	col->green=1;
	col->blue=1;

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
	col->red=0xfe;
	col->green=0xfe;
	col->blue=0xfe;

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
	unsigned char byte1,byte2,last_bit,next_bit;
	int out_ptr,color1,color2;
	for(y=0;y<height;y++) {
		out_ptr=0;
		last_bit=0;
		for(x=0;x<20;x++) {
			byte1=screen[hgr_offset(y)+x*2];
			byte2=screen[hgr_offset(y)+x*2+1];
			if (x==19) next_bit=0;
			else next_bit=(screen[hgr_offset(y)+x*2+2])&0x1;

			/* 10 */
			/* high bit, left_bit, middle_bit, right_bit */
			color1=hgr_color_even(byte1&0x80,
					last_bit,
					(byte1>>0)&0x1,
					(byte1>>1)&0x1);
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
					(byte1>>1)&0x1,
					(byte1>>2)&0x1,
					(byte1>>3)&0x1);
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
					(byte1>>3)&0x1,
					(byte1>>4)&0x1,
					(byte1>>5)&0x1);
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
					(byte1>>5)&0x1,
					(byte1>>6)&0x1,
					(byte2>>0)&0x1);
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
					(byte2>>0)&0x1,
					(byte2>>1)&0x1,
					(byte2>>2)&0x1);
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
					(byte2>>2)&0x1,
					(byte2>>3)&0x1,
					(byte2>>4)&0x1);
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
					(byte2>>4)&0x1,
					(byte2>>5)&0x1,
					(byte2>>6)&0x1);
			color2=hgr_color_odd(byte2&0x80,
					(byte2>>5)&0x1,
					(byte2>>6)&0x1,
					next_bit);

			last_bit=(byte2>>6)&0x1;

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
