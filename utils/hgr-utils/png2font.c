/* Converts 280x192 8-bit PNG file with correct palette to an HGR compat font*/

#define VERSION "0.0.1"

#include <stdio.h>	/* For FILE I/O */
#include <string.h>	/* For strncmp */
#include <fcntl.h>	/* for open()  */
#include <unistd.h>	/* for lseek() */
#include <sys/stat.h>	/* for file modes */
#include <stdlib.h>	/* free() */

#include <png.h>

#define OUTPUT_ORIGINAL		0
#define OUTPUT_INTERLEAVE	1
#define OUTPUT_BINARY		2

static int debug=0;


static int print_fancy_byte(int value) {

	int i,reversed;

	/* 0001 0111 -> X011 1010 */
	/* 7654 3210 ->   01 2345 */
	reversed=0;
	for(i=0;i<8;i++) {
		reversed|=(1<<(i-2))*(!!(value&(1<<(7-i))));
	}

	printf("\t.byte $%02X\t; ",reversed);

	for(i=0;i<5;i++) {
		printf("%c",((1<<(4-i))&value)?'1':'0');
	}
	printf(" X");
	for(i=0;i<7;i++) {
		if (i==3) printf(" ");
		printf("%c",((1<<(6-i))&reversed)?'1':'0');
	}

	printf("\n");
	return 0;
}

static int print_interleave_byte(int value,int y) {

	int i,reversed;

	/* 0001 0111 -> X011 1010 */
	/* 7654 3210 ->   01 2345 */
	reversed=0;
	for(i=0;i<8;i++) {
		reversed|=(1<<(i-2))*(!!(value&(1<<(7-i))));
	}

	printf("\t.byte $%02X\t ; ",reversed);
	if ((y>0x20) && (y<0x7f)) printf("%c",y);
	printf("\n");

	return 0;

}
static int convert_color(int color) {

	int c=0;

	switch(color) {

		/* These use the questionable palette my older code used */
		/* Also handle the newer one */
		/* Bitflipped because HGR is backwards, woz is crazy */
		case 0x000000:	c=0; break;	/* black1 */
		case 0x1bcb01:	c=2; break;	/* bright green */
		case 0x14f53c:	c=2; break;	/* bright green */
		case 0xe434fe:	c=1; break;	/* magenta */
		case 0xe31e60:	c=1; break;	/* magenta */
		case 0xffffff:	c=3; break;	/* white1 */
		case 0xcd5b01:	c=6; break;	/* orange */
		case 0xff6a3c:	c=6; break;	/* orange */
		case 0x1b9afe:	c=5; break;	/* medium blue */
		case 0x14cffd:	c=5; break;	/* medium blue */

		case 0x010101:	c=4; break;	/* black2 */
		case 0xfefefe:	c=7; break;	/* white2 */

		default:
			fprintf(stderr,"Unknown color %x\n",color);
			break;
	}

	return c;
}



/* expects a PNG */
static int loadpng(char *filename,
		unsigned char **image_ptr, int *xsize, int *ysize) {

	int x,y;
	int color;
	FILE *infile;
	unsigned char *image,*out_ptr;
	int width, height;
	int a2_color;

	png_byte bit_depth;
	png_structp png_ptr;
	png_infop info_ptr;
	png_bytep *row_pointers;
	png_byte color_type;
	int row_bytes,bytes_per_pixel;

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

	if (width!=280) {
		fprintf(stderr,"Unknown width %d\n",width);
		return -1;
	}

	if (height!=192) {
		fprintf(stderr,"Unknown height %d\n",height);
		return -1;
	}

	image=calloc(width*height,sizeof(unsigned char));
	if (image==NULL) {
		fprintf(stderr,"Error allocating image\n");
		return -1;
	}

	if (debug) {
		fprintf(stderr,"PNG: width=%d height=%d depth=%d\n",
				width,height,bit_depth);
		if (color_type==PNG_COLOR_TYPE_RGB) {
			fprintf(stderr,"Type RGB\n");
		}
		else if (color_type==PNG_COLOR_TYPE_RGB_ALPHA) {
			fprintf(stderr,"Type RGBA\n");
		}
		else if (color_type==PNG_COLOR_TYPE_PALETTE) {
			fprintf(stderr,"Type palette\n");
		}
	}

	/* If palette, expand to RGB automatically */
	if (color_type == PNG_COLOR_TYPE_PALETTE) {
		png_set_expand(png_ptr);
	}

	png_read_update_info(png_ptr, info_ptr);


	row_bytes = png_get_rowbytes(png_ptr, info_ptr);
	// *pChannels = (int)png_get_channels(png_ptr, info_ptr);
	bytes_per_pixel=row_bytes/width;

	if (debug) {
		fprintf(stderr,"Rowbytes=%d bytes per pixel=%d\n",
				row_bytes,row_bytes/width);
	}

	row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * height);
	for (y=0; y<height; y++) {
		row_pointers[y] = (png_byte*)malloc(row_bytes);
	}

	png_read_image(png_ptr, row_pointers);

	png_read_end(png_ptr, NULL);

	fclose(infile);

	out_ptr=image;


	for(y=0;y<height;y++) {
		for(x=0;x<width;x++) {

			color=	(row_pointers[y][x*bytes_per_pixel]<<16)+
				(row_pointers[y][x*bytes_per_pixel+1]<<8)+
				(row_pointers[y][x*bytes_per_pixel+2]);
//			if (debug) {
//				fprintf(stderr,"%x ",color);
//			}

			a2_color=convert_color(color);

			if (debug) {
				fprintf(stderr,"%x",a2_color);
			}
			*out_ptr=a2_color;
			out_ptr++;
		}
		if (debug) fprintf(stderr,"\nNR: ");
	}


	*image_ptr=image;

	return 0;
}







/* Converts a PNG to RAW 8K Hires Image */


static void print_help(char *name,int version) {

	printf("\npng2hgr version %s\n",VERSION);

	if (version) exit(1);

	printf("\nUsage: %s [-b] [-i] PNGFILE\n\n",name);
	printf("\t[-b] binary output\n");
	printf("\t[-i] interleaved output\n");
	printf("\n");

	exit(1);
}

static unsigned char font_data[256][16];

int main(int argc, char **argv) {

	int xsize=0,ysize=0,temp;
	int c,x,y,row,col;
	unsigned char *image;

	char *filename;
	int output_type=OUTPUT_ORIGINAL;

	/* Parse command line arguments */

	while ( (c=getopt(argc, argv, "hvdib") ) != -1) {

		switch(c) {

                        case 'h':
                                print_help(argv[0],0);
				break;
                        case 'v':
                                print_help(argv[0],1);
				break;
                        case 'd':
				debug=1;
				break;
                        case 'i':
				output_type=OUTPUT_INTERLEAVE;
				break;
                        case 'b':
				output_type=OUTPUT_BINARY;
				break;
			default:
				print_help(argv[0],0);
				break;
		}
	}

	if (optind>=argc) {
		printf("ERROR: Was expecting filename!\n");
		exit(1);
	}

	filename=strdup(argv[optind]);

//	memset(apple2_image,0,8192);

	if (loadpng(filename,&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	/* for now, assume 5x8 font starting at 14,8 */
	for(row=0;row<4;row++) {
	for(col=0;col<32;col++) {
	for(y=0;y<8;y++) {
		temp=0;
		for(x=0;x<7;x++) {
			if (image[ (((row*8)+y+8)*280)+(col*7)+x+14]) {
				temp=temp|(1<<(6-x));
			}
		}
		font_data[(row*32)+col][y]=temp;
	}
	}
	}

//	fwrite(apple2_image,8192,sizeof(unsigned char),stdout);

	/* old-fashioned output */
	if (output_type==OUTPUT_ORIGINAL) {
		printf("hgr_font:\n");
		for(c=0x20;c<0x80;c++) {
			printf("; %c $%02X\n",c,c);
			for(y=0;y<8;y++) {
				print_fancy_byte(font_data[c][y]);
			}
		}
	}
	else if (output_type==OUTPUT_INTERLEAVE) {
		for(row=0;row<8;row++) {
			printf("CondensedRow%d:\n",row);
			for(y=0x19;y<0x80;y++) {
				print_interleave_byte(font_data[y][row],y);
			}
		}
	}
	else if (output_type==OUTPUT_BINARY) {
		fprintf(stderr,"ERROR!  Binary not implemented yet\n");
	}
	else {
		fprintf(stderr,"ERROR!  Unknown output\n");
	}
	return 0;
}
