/* Converts 280x192 8-bit PNG file with correct palette to an HGR large font*/

/* Assume font is 14x16 in size */
/* Two rows of font for 32 chars total */
/* This is hardcoded now, maybe expand in future */

#define VERSION "0.0.1"

#include <stdio.h>	/* For FILE I/O */
#include <string.h>	/* For strncmp */
#include <fcntl.h>	/* for open()  */
#include <unistd.h>	/* for lseek() */
#include <sys/stat.h>	/* for file modes */
#include <stdlib.h>	/* free() */

#include <png.h>

#define OUTPUT_ORIGINAL		0
#define OUTPUT_ROWS		1
#define OUTPUT_BINARY		2
#define OUTPUT_FULL		3

static int debug=0;


static int shift(int value1, int value2, int left, int amount) {

	int out1=0,out2=0;
	int high1,high2;

	high1=value1&0x80;
	high2=value2&0x80;


	switch(amount) {
		case 0:	out1=value1; out2=value2; break;

		/* X6543210 Ydcba987 */
		/* X8765432 Y10dcba9 */
		/* Xa987654 Y3210dcb */
		/* Xcba9876 Y543210  */
		case 1: out1=out1<<2;


	}

	if (left) return out1;
	else return out2;

}


static int reverse_byte(int value) {
	/* 0001 0111 -> X011 1010 */
	/* 7654 3210 ->   01 2345 */
	int reversed=0,i;
	for(i=0;i<8;i++) {
		reversed|=(1<<(i))*(!!(value&(1<<(7-i))));
	}
//	printf("%x reversed is %x\n",value,reversed);
	return reversed;
}

static int print_fancy_bytes(int byte1,int byte2) {

	int i;

	printf(".byte $%02X,$%02X",byte1,byte2);
//		(reverse_byte((byte2))),
//		(reverse_byte((byte1))));
	printf("\t; ");

	for(i=0;i<8;i++) {
		if (byte1&(1<<i/*(7-i)*/)) printf("1");
		else printf(".");
	}
	for(i=0;i<8;i++) {
		if (byte2&(1<<i/*(7-i)*/)) printf("1");
		else printf(".");
	}

//		if (value&(1<<(15-i))) printf("1");
//		else printf(".");
//	}

#if 0
	int i,reversed;

	/* 001 01110 -> X011 1010 */
	/* 7654 3210 ->  012 3456 */
	reversed=0;
	for(i=0;i<8;i++) {
		reversed|=(1<<(i-1))*(!!(value&(1<<(7-i))));
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
#endif
	printf("\n");
	return 0;
}

#if 0
static int print_interleave_byte(int value,int y) {

	int i,reversed;

	/* 0001 0111 -> X011 1010 */
	/* 7654 3210 ->   01 2345 */
	reversed=0;
	for(i=0;i<8;i++) {
		reversed|=(1<<(i-1))*(!!(value&(1<<(7-i))));
	}

	printf("\t.byte $%02X\t ; ",reversed);
	if ((y>0x20) && (y<0x7f)) printf("%c",y);
	printf("\n");

	return 0;

}
#endif

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

static unsigned char font_data[32][16][2];

int main(int argc, char **argv) {

	int xsize=0,ysize=0,temp;
	int c,x,y,row,col;
	unsigned char *image;

	char *filename;
	int output_type=OUTPUT_ORIGINAL;

	int which;

	/* Parse command line arguments */

	while ( (c=getopt(argc, argv, "hvdfrb") ) != -1) {

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
                        case 'r':
				output_type=OUTPUT_ROWS;
				break;
			case 'b':
				output_type=OUTPUT_BINARY;
				break;
			case 'f':
				output_type=OUTPUT_FULL;
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

	int pal[2],color1=0,color2=0,byte1,byte2;
	/* for now, assume 14x16 font starting at 0,0 */
	for(row=0;row<2;row++) {
	for(col=0;col<16;col++) {
	for(y=0;y<16;y++) {
		temp=0;
		pal[0]=0,pal[1]=0;
		for(x=0;x<14;x+=2) {
			color1=image[ (((row*18)+y)*280)+(col*14)+x];
			color2=image[ (((row*18)+y)*280)+(col*14)+x+1];
			temp=temp<<2;
			switch(color1){
				case 0: if ((color2==0) || (color2==4)) temp|=0;
					else temp|=1;
					break;
				case 1: temp|=2; break;
				case 2: temp|=1; break;
				case 3: if ((color2==3) ||(color2==7)) temp|=3;
					else temp|=2;
					break;
				case 4: if ((color2==0) || (color2==4)) temp|=0;
					else temp|=1;
					pal[x/7]=1; break;
				case 5: temp|=2;
					pal[x/7]=1; break;
				case 6: temp|=1;
					pal[x/7]=1; break;
				case 7: if ((color2==3) || (color2==7)) temp|=3;
					else temp|=1;
					pal[x/7]=2; break;
			}
		}
		byte1=(reverse_byte(temp>>6)&0x7f)|pal[0]<<7;
		byte2=(reverse_byte(temp<<1)&0x7f)|pal[1]<<7;

		font_data[(row*16)+col][y][0]=byte1;
		font_data[(row*16)+col][y][1]=byte2;

	}
	}
	}

//	fwrite(apple2_image,8192,sizeof(unsigned char),stdout);

	/* old-fashioned output */
	if (output_type==OUTPUT_ORIGINAL) {
		printf("hgr_large_font:\n");
		for(c=0;c<32;c++) {
			printf("; %c $%02X\n",c+64,c);
			for(y=0;y<16;y++) {
				print_fancy_bytes(font_data[c][y][0],
							font_data[c][y][1]);
			}
		}
	}
	/* row based output */
	else if (output_type==OUTPUT_ROWS) {
		for(row=0;row<16;row++) {
			printf("large_font_row%d:\n",row);
			printf(".byte ");
			for(c=0;c<32;c++) {
				printf("$%02X,$%02X",
					font_data[c][row][0],
					font_data[c][row][1]);
				if (c!=31) printf(",");
			}
			printf("\n");
		}

	}
	/* full output */

	/* X6543210 Xdcba987 */
	/* X4321065 Xba987dc */
	/* X2106543 X987dcba */
	/* X0654321 X7cdba98 */



	else if (output_type==OUTPUT_FULL) {
		for(which=0;which<7;which++) {
			for(row=0;row<16;row++) {
				printf("large_font_%d_row%d:\n",which,row);
				printf(".byte ");
				for(c=0;c<32;c++) {
					printf("$%02X,$%02X",
						shift(font_data[c][row][0],
							font_data[c][row][1],
							0,which),
						shift(font_data[c][row][0],
							font_data[c][row][1],
							1,which));

					if (c!=31) printf(",");
				}
				printf("\n");
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
