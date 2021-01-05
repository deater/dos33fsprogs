/* Converts 140x192 8-bit PNG file with correct palette to Apple II DHGR */

/* http://www.battlestations.zone/2017/04/apple-ii-double-hi-res-from-ground-up_12.html */

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

	if (width!=140) {
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

	printf("\npng2dhgr version %s\n",VERSION);

	if (version) exit(1);

	printf("\nUsage: %s [-r] [-s] PNGFILE OUTBASE\n\n",name);
	printf("\t[-r] raw, don't prepend with BLOAD addr/size\n");
	printf("\t[-s] short, leave off bottom text area\n");
	printf("\n");

	exit(1);
}

static int hgr_offset_table[48]={
	0x0000,0x0080,0x0100,0x0180,0x0200,0x0280,0x0300,0x0380,
	0x0028,0x00A8,0x0128,0x01A8,0x0228,0x02A8,0x0328,0x03A8,
	0x0050,0x00D0,0x0150,0x01D0,0x0250,0x02D0,0x0350,0x03D0,
};

static char aux1_colors[16]={
	0x00,0x08,0x44,0x4c,0x22,0x2a,0x66,0x6e,
	0x11,0x19,0x55,0x5d,0x33,0x3b,0x77,0x7f};
static char main1_colors[16]={
	0x00,0x11,0x08,0x19,0x44,0x55,0x4c,0x5d,
	0x22,0x33,0x2a,0x3b,0x66,0x77,0x6e,0x7f};
static char aux2_colors[16]={
	0x00,0x22,0x11,0x33,0x08,0x2a,0x19,0x3b,
	0x44,0x66,0x55,0x77,0x4c,0x6e,0x5d,0x7f};
static char main2_colors[16]={
	0x00,0x44,0x22,0x66,0x11,0x55,0x33,0x77,
	0x08,0x4c,0x2a,0x6e,0x19,0x5d,0x3b,0x7f};

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

static int hgr_offset(int y) {

	int temp,temp2,address;
	temp=y/8;
	temp2=y%8;

	temp2=temp2*0x400;

	address=hgr_offset_table[temp]+temp2;

	return address;
}

static unsigned char apple2_aux[8192],apple2_bin[8192];

int main(int argc, char **argv) {

	int xsize=0,ysize=0;
	int c,x,y,color1;
	unsigned char *image;
	unsigned char colors[7];

	char *filename,*base;
	char outfile[BUFSIZ];
	FILE *aux,*bin;

	/* Parse command line arguments */

	while ( (c=getopt(argc, argv, "hvd") ) != -1) {

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

	memset(apple2_aux,0,8192);
	memset(apple2_bin,0,8192);

	if (loadpng(filename,&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	for(y=0;y<192;y++) {
		for(x=0;x<20;x++) {
			colors[0]=image[y*140+x*7+0];
			colors[1]=image[y*140+x*7+1];
			colors[2]=image[y*140+x*7+2];
			colors[3]=image[y*140+x*7+3];
			colors[4]=image[y*140+x*7+4];
			colors[5]=image[y*140+x*7+5];
			colors[6]=image[y*140+x*7+6];

#if 0
			color1=aux1_colors[colors[0]]&0xf;
			color1|=(aux1_colors[colors[1]]<<4)&0x7f;
			apple2_aux[hgr_offset(y)+(x*2)+0]=color1;

			color1=(main1_colors[colors[1]]>>3)&0x1;
			color1|=(main1_colors[colors[2]]<<1)&0x1e;
			color1|=(main1_colors[colors[3]]<<5)&0x60;
			apple2_bin[hgr_offset(y)+(x*2)+0]=color1;

			color1=(aux2_colors[colors[3]]>>2)&0x3;
			color1|=(aux2_colors[colors[4]]<<2)&0x3c;
			color1|=(aux2_colors[colors[5]]<<6)&0x40;
			apple2_aux[hgr_offset(y)+(x*2)+1]=color1;

			color1=(main2_colors[colors[5]]>>1)&0x7;
			color1|=(main2_colors[colors[6]]<<3)&0x78;
			apple2_bin[hgr_offset(y)+(x*2)+1]=color1;
#endif

#if 0

			color1=colors[0]&0xf;
			color1|=(colors[1]<<4)&0x7f;
			apple2_aux[hgr_offset(y)+(x*2)+0]=color1;

			color1=(colors[1]>>3)&0x1;
			color1|=(colors[2]<<1)&0x1e;
			color1|=(colors[3]<<5)&0x60;
			apple2_bin[hgr_offset(y)+(x*2)+0]=color1;

			color1=(colors[3]>>2)&0x3;
			color1|=(colors[4]<<2)&0x3c;
			color1|=(colors[5]<<6)&0x40;
			apple2_aux[hgr_offset(y)+(x*2)+1]=color1;

			color1=(colors[5]>>1)&0x7;
			color1|=(colors[6]<<3)&0x78;
			apple2_bin[hgr_offset(y)+(x*2)+1]=color1;
#endif

#if 1
// 33 4c
// 0011 0011 0100 1100
// PDDC CCCB PGGG GFFF
// B=1XXX
// C=1001
// D=XX01
// F=100X
// G=1001
			color1=flipped_colors[colors[0]]&0xf;
			color1|=(flipped_colors[colors[1]]<<4)&0x7f;
			apple2_aux[hgr_offset(y)+(x*2)+0]=color1;

			color1=(flipped_colors[colors[1]]>>3)&0x1;
			color1|=(flipped_colors[colors[2]]<<1)&0x1e;
			color1|=(flipped_colors[colors[3]]<<5)&0x60;
			apple2_bin[hgr_offset(y)+(x*2)+0]=color1;

			color1=(flipped_colors[colors[3]]>>2)&0x3;
			color1|=(flipped_colors[colors[4]]<<2)&0x3c;
			color1|=(flipped_colors[colors[5]]<<6)&0x40;
			apple2_aux[hgr_offset(y)+(x*2)+1]=color1;

			color1=(flipped_colors[colors[5]]>>1)&0x7;
			color1|=(flipped_colors[colors[6]]<<3)&0x78;
			apple2_bin[hgr_offset(y)+(x*2)+1]=color1;
#endif

		}



	}

	sprintf(outfile,"%s.AUX",base);
	aux=fopen(outfile,"w");
	if (aux==NULL) {
		fprintf(stderr,"Error opening %s\n",outfile);
		exit(1);
	}
	fwrite(apple2_aux,8192,sizeof(unsigned char),aux);
	fclose(aux);

	sprintf(outfile,"%s.BIN",base);
	bin=fopen(outfile,"w");
	if (bin==NULL) {
		fprintf(stderr,"Error opening %s\n",outfile);
		exit(1);
	}
	fwrite(apple2_bin,8192,sizeof(unsigned char),bin);
	fclose(bin);

	return 0;

}
