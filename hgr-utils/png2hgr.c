/* Converts 140x192 8-bit PNG file with correct palette to Apple II HGR */

#define VERSION "0.0.1"

#include <stdio.h>	/* For FILE I/O */
#include <string.h>	/* For strncmp */
#include <fcntl.h>	/* for open()  */
#include <unistd.h>	/* for lseek() */
#include <sys/stat.h>	/* for file modes */
#include <stdlib.h>	/* free() */

#include <png.h>

#define OUTPUT_C	0
#define OUTPUT_ASM	1
#define OUTPUT_RAW	2

/* If you want default black a different color try the below */
/* Useful if you are trying to xdraw to get red/blue */
#if 0
/* Default is BLACK0 */
#define DEFAULT_BLACK	-1
#else
/* DEFAULT is BLACK1 */
#define DEFAULT_BLACK	1
#endif

static int debug=0;

static int convert_color(int color) {

	int c=0;

	switch(color) {
		case 0x000000:	c=0; break;	/* black */
		case 0xe31e60:	c=1; break;	/* magenta */
		case 0x604ebd:	c=2; break;	/* dark blue */
		case 0xff44fd:	c=3; break;	/* purple */
		case 0x00a360:	c=4; break;	/* dark green */
		case 0x9c9c9c:	c=5; break;	/* grey 1 */
		case 0x14cffd:	c=6; break;	/* medium blue */
		case 0xd0c3ff:	c=7; break;	/* light blue */
		case 0x607203:	c=8; break;	/* brown */
		case 0xff6a3c:	c=9; break;	/* orange */
		case 0x9d9d9d:	c=10; break;	/* grey 2 */
		case 0xffa0d0:	c=11; break;	/* pink */
		case 0x14f53c:	c=12; break;	/* bright green */
		case 0xd0dd8d:	c=13; break;	/* yellow */
		case 0x72ffd0:	c=14; break;	/* aqua */
		case 0xffffff:	c=15; break;	/* white */
		default:
			printf("Unknown color %x\n",color);
			break;
	}

	return c;
}



/* expects a PNG where the xsize is *2 */
int loadpng(char *filename,
		unsigned char *image, int *xsize, int *ysize,
		int high) {

	int x,y;
	int color;
	FILE *infile;
	int debug=0;
	unsigned char *out_ptr;
	int width, height;
	int a2_color;

	png_byte bit_depth;
	png_structp png_ptr;
	png_infop info_ptr;
	png_bytep *row_pointers;
	png_byte color_type;

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
	*ysize=height/2;

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
		for(y=high;y<height;y+=4) {
			for(x=0;x<width;x++) {

				/* top color */
				color=	(row_pointers[y][x*4]<<16)+
					(row_pointers[y][x*4+1]<<8)+
					(row_pointers[y][x*4+2]);
				if (debug) {
					printf("%x ",color);
				}

				a2_color=convert_color(color);

				/* bottom color */
				color=	(row_pointers[y+2][x*4]<<16)+
					(row_pointers[y+2][x*4+1]<<8)+
					(row_pointers[y+2][x*4+2]);
				if (debug) {
					printf("%x ",color);
				}

				a2_color|=(convert_color(color)<<4);

				*out_ptr=a2_color;
				out_ptr++;
			}
			if (debug) printf("\n");
		}
	}
	else if (color_type==PNG_COLOR_TYPE_PALETTE) {
		for(y=high;y<height;y+=4) {
			for(x=0;x<width;x++) {

				/* top color */
				a2_color=row_pointers[y][x];

				/* bottom color */
				color=row_pointers[y+2][x];

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

	return 0;
}







/* Converts a PNG to RAW 8K Hires Image */


static void print_help(char *name,int version) {

	printf("\npcx2hgr version %s\n",VERSION);

	if (version) exit(1);

	printf("\nUsage: %s [-r] [-s] PCXFILE\n\n",name);
	printf("\t[-r] raw, don't prepend with BLOAD addr/size\n");
	printf("\t[-s] short, leave off bottom text area\n");
	printf("\n");

	exit(1);
}

//static unsigned char image[8192];


static unsigned char image[8192];

int main(int argc, char **argv) {

	int xsize=0,ysize=0;
	int c,i;

	char *filename;

	/* Parse command line arguments */

	while ( (c=getopt(argc, argv, "hv") ) != -1) {

		switch(c) {

                        case 'h':
                                print_help(argv[0],0);
				break;
                        case 'v':
                                print_help(argv[0],1);
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

	memset(image,0,8192);

	if (loadpng(filename,image,&xsize,&ysize,1)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	for(i=0;i<8192;i++) {
		fprintf(stdout,"%c",image[i]);
	}

	return 0;
}



