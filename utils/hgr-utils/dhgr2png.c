/* Convert an Apple IIe double-hires memory capture to a PNG */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

#include <sys/stat.h>

#include <png.h>

#define VERSION "0.0.1"

#define PAL_LENGTH	16	// PNG_MAX_PALETTE_LENGTH

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

/* not only flipped, but oddly rotated by 1 as well? */
unsigned char flip_bits[16]={
	0,		// 0000 -> 0000	black
	2,		// 0001 -> 0010 dark blue
	4,		// 0010 -> 0100 dark green
	6,		// 0011 -> 0110 med blue
	8,		// 0100 -> 1000 brown
	10,		// 0101 -> 1010 grey2
	12,		// 0110 -> 1100 green
	14,		// 0111 -> 1110 aqua
	1,		// 1000 -> 0001 magenta
	3,		// 1001 -> 0011 purple
	5,		// 1010 -> 0101 grey1
	7,		// 1011 -> 0111 light blue
	9,		// 1100 -> 1001 orange
	11,		// 1101 -> 1011 pink
	13,		// 1110 -> 1101 yellow
	15,		// 1111 -> 1111 white
};

static void print_help(char *name,int version) {

	printf("%s\n",VERSION);

	if (version) exit(1);

	printf("Usage: %s FILENAME.BIN [FILENAME.AUX] OUTPUT\n",name);
	printf("\twhere FILENAME.BIN is either a 16k aux/bin memory dump\n");
	printf("\tor else you have separate 8k bin/aux memory dumps\n");
	printf("\n");

	exit(1);
}


//unsigned char flip_bits[16]={0,8,4,0xc,2,0xA,6,0xE,1,9,5,0xD,3,0xb,7,0xf};
//unsigned char flip_bits[16]={0,1,2,3,4,5,7,8,9,10,11,12,13,14,15};
//char flip_bits[16]={0,8,1,9,2,10,3,11,4,12,5,13,6,14,7,15};

//unsigned char ab0[16]=
//	{0x00,0x08,0x44,0x4c,0x22,0x2a,0x66,0x6e,0x11,0x19,0x55,0x5d,0x33,0x3b,0x77,0x7f};

int main(int argc, char **argv) {

	int fd;
	char filename[256];
	unsigned char bin_screen[8192],aux_screen[8192];
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

	/* print arguments */
	if (argc<3) {
		print_help(argv[0],0);
	}

	/* Assume 3 or 4 arguments */
	/* if 3 arguments, it's 16k filename, output name */
	/* if 4 arguments, it's 8k bin, 8k aux, output name */

	/* FIXME: avoid accidentally over-writing?  Need -f to force? */


	/* if no name specified, make one from the input name */
//	if (argc<4) {
//		sprintf(filename,"%s.png",argv[1]);
//	}
//	else {
//		strncpy(filename,argv[3],256-1);
//	}

	struct stat input_stat;
	int bin_size,result;

	/* check if argv[1] is 16k */
	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"Error opening %s! %s\n",argv[1],strerror(errno));
		return -1;
	}
	result=fstat(fd,&input_stat);
	if (result<0) {
		fprintf(stderr,"Error statting!\n");
		return -1;
	}

	bin_size=input_stat.st_size;
	if (bin_size==16384) {
		read(fd,aux_screen,8192);
		read(fd,bin_screen,8192);
		close(fd);
		strncpy(filename,argv[2],256-1);
	}
	else if ((bin_size==8192) && (argc==4)) {
		/* assume next file has next 8k */
		fd=open(argv[2],O_RDONLY);
		if (fd<0) {
			printf("Error opening %s! %s\n",argv[2],strerror(errno));
			return -1;
		}
		result=fstat(fd,&input_stat);
		if (result<0) {
			fprintf(stderr,"Error statting!\n");
			return -1;
		}
		bin_size=input_stat.st_size;
		if (bin_size!=8192) {
			fprintf(stderr,"ERROR: File %s has unexpected size %d\n",
				argv[1],bin_size);
			return -1;
		}

		read(fd,aux_screen,8192);
		close(fd);
		strncpy(filename,argv[3],256-1);
	}
	else {
		fprintf(stderr,"ERROR: File %s has unexpected size %d\n",
			argv[1],bin_size);
		return -1;
	}



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

	/* 0: black */
        col=&palette[0]; col->red=0x00; col->green=0x00; col->blue=0x00;
        /* 1: magenta */
        col=&palette[1]; col->red=0xe3; col->green=0x1e; col->blue=0x60;
        /* 2: dark blue */
        col=&palette[2]; col->red=0x60; col->green=0x4e; col->blue=0xbd;
        /* 3: purple */
        col=&palette[3]; col->red=0xff; col->green=0x44; col->blue=0xfd;
        /* 4: dark green */
        col=&palette[4]; col->red=0x00; col->green=0xa3; col->blue=0x60;
        /* 5: grey 1 */
        col=&palette[5]; col->red=0x9c; col->green=0x9c; col->blue=0x9c;
        /* 6: medium blue */
        col=&palette[6]; col->red=0x14; col->green=0xcf; col->blue=0xfd;
        /* 7: light blue */
        col=&palette[7]; col->red=0xd0; col->green=0xc3; col->blue=0xff;
        /* 8: brown */
        col=&palette[8]; col->red=0x60; col->green=0x72; col->blue=0x03;
	/* 9: orange */
        col=&palette[9]; col->red=0xff; col->green=0x6a; col->blue=0x3c;
        /* 10: gray 2 */
        col=&palette[10]; col->red=0x9d; col->green=0x9d; col->blue=0x9d;
        /* 11: pink */
        col=&palette[11]; col->red=0xff; col->green=0xa0; col->blue=0xd0;
        /* 12: bright green */
        col=&palette[12]; col->red=0x14; col->green=0xf5; col->blue=0x3c;
        /* 13: yellow */
        col=&palette[13]; col->red=0xd0; col->green=0xdd; col->blue=0x8d;
        /* 14: aqua */
        col=&palette[14]; col->red=0x72; col->green=0xff; col->blue=0xd0;
        /* 15: white */
        col=&palette[15]; col->red=0xff; col->green=0xff; col->blue=0xff;



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

	/* AUX      MAIN     AUX      MAIN     */
	/* PBBBAAAA PDDCCCCB PFEEEEDD PGGGGFFF */

	unsigned char byte1,byte2,byte3,byte4;
	int colora,colorb,colorc,colord,colore,colorf,colorg;

	int out_ptr;
	for(y=0;y<height;y++) {
		out_ptr=0;
		for(x=0;x<20;x++) {
			byte1=aux_screen[hgr_offset(y)+x*2];
			byte2=bin_screen[hgr_offset(y)+x*2];
			byte3=aux_screen[hgr_offset(y)+x*2+1];
			byte4=bin_screen[hgr_offset(y)+x*2+1];

			colora=flip_bits[byte1&0xf];
			colorb=flip_bits[((byte1>>4)&0x7)|((byte2&0x1)<<3)];
			colorc=flip_bits[(byte2>>1)&0xf];
			colord=flip_bits[((byte2>>5)&0x3)|((byte3&3)<<2)];
			colore=flip_bits[(byte3>>2)&0xf];
			colorf=flip_bits[((byte3>>6)&0x1)|((byte4&0x7)<<1)];
			colorg=flip_bits[(byte4>>3)&0xf];

			/* double wide */
			row_pointers[y][out_ptr]=colora;
			out_ptr++;
			row_pointers[y][out_ptr]=colora;
			out_ptr++;

			/* double wide */
			row_pointers[y][out_ptr]=colorb;
			out_ptr++;
			row_pointers[y][out_ptr]=colorb;
			out_ptr++;

			row_pointers[y][out_ptr]=colorc;
			out_ptr++;
			row_pointers[y][out_ptr]=colorc;
			out_ptr++;

			row_pointers[y][out_ptr]=colord;
			out_ptr++;
			row_pointers[y][out_ptr]=colord;
			out_ptr++;

			row_pointers[y][out_ptr]=colore;
			out_ptr++;
			row_pointers[y][out_ptr]=colore;
			out_ptr++;

			row_pointers[y][out_ptr]=colorf;
			out_ptr++;
			row_pointers[y][out_ptr]=colorf;
			out_ptr++;

			row_pointers[y][out_ptr]=colorg;
			out_ptr++;
			row_pointers[y][out_ptr]=colorg;
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
