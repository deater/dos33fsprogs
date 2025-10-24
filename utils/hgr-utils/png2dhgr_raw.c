/* Converts 140x192 8-bit PNG file with correct palette to raw Apple II DHGR */

/* This is an extended version which puts the colors in a non-packed */
/* non-interlaced form to make ZX02 compression work better */
/* It needs a special unpacker to view */

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
			fprintf(stderr,"Unknown color %x\n",color);
			break;
	}

	return c;
}



/* expects a PNG */
int loadpng(char *filename,
		unsigned char **image_ptr, int *xsize, int *ysize) {

	int x,y;
	int color;
	FILE *infile;
	unsigned char *image,*out_ptr;
	int width, height;
	int a2_color;
	int skip=1;

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

	if ((width!=140) && (width!=280)) {
		fprintf(stderr,"Unknown width %d\n",width);
		return -1;
	}

	if (width==280) {
		skip=2;
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
		for(x=0;x<width;x+=skip) {

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

	printf("\npng2dhgr_raw version %s\n",VERSION);

	if (version) exit(1);

	printf("\nUsage: %s [-u] [-t] PNGFILE OUTBASE\n\n",name);
	printf("\t[-u] uncompact, one color per byte\n");
	printf("\t[-t] top/bottom, split at line 96\n");
	printf("\n");

	exit(1);
}


static char flipped_colors[16]={
/* black */	0x00,
/* magenta */	0x08,
/* dark blue */	0x01,
/* purple */	0x09,
/* dark green */0x02,
/* grey 1 */	0x0a,
/* med blue */	0x03,
/* lt blue */	0x0b,
/* brown */	0x04,
/* orange */	0x0c,
/* grey2 */	0x05,
/* pink */	0x0d,
/* br green */	0x06,
/* yellow */	0x0e,
/* aqua */	0x07,
/* white */	0x0f,
};



static unsigned char apple2_out[65536];

int main(int argc, char **argv) {

	int xsize=0,ysize=0;
	int uncompact=0;
	int top_bottom=0;
	int c,x,y,color1,color2;
	unsigned char *image;
	unsigned char colors[7];

	char *filename,*base;
	char outfile[BUFSIZ];
	FILE *aux;

	/* Parse command line arguments */

	while ( (c=getopt(argc, argv, "hvdtu") ) != -1) {

		switch(c) {

                        case 'h':
                                print_help(argv[0],0);
				break;
			case 't':
				top_bottom=1;
				break;
			case 'u':
				uncompact=1;
				break;
			case 'v':
				print_help(argv[0],1);
				break;
                        case 'd':
				debug=1;
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

	if (optind+1>=argc) {
		base=strdup("OUT");
	}
	else {
		base=strdup(argv[optind+1]);
	}

	memset(apple2_out,0,65536);

	if (loadpng(filename,&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	/* 140x192 with each byte a single color */
	if (uncompact) {
		for(y=0;y<192;y++) {
			for(x=0;x<140;x++) {
				colors[0]=image[y*140+x];
				color1=flipped_colors[colors[0]]&0xf;
				apple2_out[(y*140)+x]=color1;
			}
		}

		sprintf(outfile,"%s.uncompact",base);
		aux=fopen(outfile,"w");
		if (aux==NULL) {
			fprintf(stderr,"Error opening %s\n",outfile);
			exit(1);
		}
		fwrite(apple2_out,140*192,sizeof(unsigned char),aux);
		fclose(aux);
	}

	memset(apple2_out,0,65536);

	/* 140x192 but two neighboring colors in one byte */
	for(y=0;y<192;y++) {
		for(x=0;x<70;x++) {
			colors[0]=image[(y*140)+(x*2)];
			colors[1]=image[(y*140)+(x*2)+1];

			color1=flipped_colors[colors[0]]&0xf;
			color2=flipped_colors[colors[1]]&0xf;

			apple2_out[(y*70)+x]= (color2<<4) | (color1);
		}
	}

	if (top_bottom) {

		sprintf(outfile,"%s.raw_top",base);
		aux=fopen(outfile,"w");
		if (aux==NULL) {
			fprintf(stderr,"Error opening %s\n",outfile);
			exit(1);
		}
		fwrite(apple2_out,70*96,sizeof(unsigned char),aux);
		fclose(aux);

		sprintf(outfile,"%s.raw_bottom",base);
		aux=fopen(outfile,"w");
		if (aux==NULL) {
			fprintf(stderr,"Error opening %s\n",outfile);
			exit(1);
		}
		fwrite(apple2_out+(70*96),70*96,sizeof(unsigned char),aux);
		fclose(aux);


	}
	else {
		sprintf(outfile,"%s.raw",base);
		aux=fopen(outfile,"w");
		if (aux==NULL) {
			fprintf(stderr,"Error opening %s\n",outfile);
			exit(1);
		}
		fwrite(apple2_out,70*192,sizeof(unsigned char),aux);
		fclose(aux);
	}

	return 0;

}

// 140*192 = 26 880 bytes
// nibble packed = 13 440 bytes
