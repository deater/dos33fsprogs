/* Converts 280x192 8-bit PNG file with correct palette to Apple II HGR */








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
#if 0
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
#endif

		/* These use the questionable palette my older code used */
		/* Also handle the newer one */
		/* Bitflipped because HGR is backwards, woz is crazy */
		case 0x000000:	c=0; break;	/* black */
		case 0x1bcb01:	c=2; break;	/* bright green */
		case 0x14f53c:	c=2; break;	/* bright green */
		case 0xe434fe:	c=1; break;	/* magenta */
		case 0xe31e60:	c=1; break;	/* magenta */
		case 0xffffff:	c=3; break;	/* white */
		case 0xcd5b01:	c=6; break;	/* orange */
		case 0xff6a3c:	c=6; break;	/* orange */
		case 0x1b9afe:	c=5; break;	/* medium blue */
		case 0x14cffd:	c=5; break;	/* medium blue */

		default:
			fprintf(stderr,"Unknown color %x\n",color);
			break;
	}

	return c;
}



/* expects a PNG where the xsize is *2 */
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

	printf("\npcx2hgr version %s\n",VERSION);

	if (version) exit(1);

	printf("\nUsage: %s [-r] [-s] PCXFILE\n\n",name);
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

static int hgr_offset(int y) {

	int temp,temp2,address;
	temp=y/8;
	temp2=y%8;

	temp2=temp2*0x400;

	address=hgr_offset_table[temp]+temp2;

	return address;
}

/* Count both black/white variants */
static int color_high(int color) {
	if ((color>2) || (color==0)) return 1;
	return 0;
}

static int color_low(int color) {
	if ((color<4) || (color==7)) return 1;
	return 0;
}


static int colors_to_bytes(unsigned char colors[14],
			unsigned char *byte1,
			unsigned char *byte2) {

	int highbit1=0,highbit2=0,lowbit1=0,lowbit2=0;
	int hb1,hb2;
	int error=0;

	*byte1=0;
	*byte2=0;

	highbit1+=color_high(colors[0]);
	highbit1+=color_high(colors[1]);
	highbit1+=color_high(colors[2]);
	highbit1+=color_high(colors[3]);
	highbit1+=color_high(colors[4]);
	highbit1+=color_high(colors[5]);
	highbit1+=color_high(colors[6]);

	highbit2+=color_high(colors[7]);
	highbit2+=color_high(colors[8]);
	highbit2+=color_high(colors[9]);
	highbit2+=color_high(colors[10]);
	highbit2+=color_high(colors[11]);
	highbit2+=color_high(colors[12]);
	highbit2+=color_high(colors[13]);

	lowbit1+=color_low(colors[0]);
	lowbit1+=color_low(colors[1]);
	lowbit1+=color_low(colors[2]);
	lowbit1+=color_low(colors[3]);
	lowbit1+=color_low(colors[4]);
	lowbit1+=color_low(colors[5]);
	lowbit1+=color_low(colors[6]);

	lowbit2+=color_low(colors[7]);
	lowbit2+=color_low(colors[8]);
	lowbit2+=color_low(colors[9]);
	lowbit2+=color_low(colors[10]);
	lowbit2+=color_low(colors[11]);
	lowbit2+=color_low(colors[12]);
	lowbit2+=color_low(colors[13]);



	if (highbit1==7) hb1=1;
	else if (lowbit1==7) hb1=0;
	else {
		error=1;
		if (highbit1>lowbit1) hb1=1;
		else hb1=0;
	}

	if (highbit2==7) hb2=1;
	else if (lowbit2==7) hb2=0;
	else {
		error=2;
		if (highbit2>lowbit2) hb2=1;
		else hb2=0;
	}

/*
 0 0 0 0 -> 00 00
 1 1 1 1 -> 01 01
 2 2 2 2 -> 10 10
 3 3 3 3 -> 11 11
 1 3 3 1 -> 01 11

 1 1 2 2 3 3 0 -> 0 11 10 01

*/



	*byte1|=(colors[0]&1)<<0;
	*byte1|=(colors[1]&2)<<0;
	*byte1|=(colors[2]&1)<<2;
	*byte1|=(colors[3]&2)<<2;
	*byte1|=(colors[4]&1)<<4;
	*byte1|=(colors[5]&2)<<4;
	*byte1|=(colors[6]&1)<<6;
	*byte1|=hb1<<7;

	*byte2|=(colors[7]&2)>>1;
	*byte2|=(colors[8]&1)<<1;
	*byte2|=(colors[9]&2)<<1;
	*byte2|=(colors[10]&1)<<3;
	*byte2|=(colors[11]&2)<<3;
	*byte2|=(colors[12]&1)<<5;
	*byte2|=(colors[13]&2)<<5;
	*byte2|=hb2<<7;

	return error;
}


static unsigned char apple2_image[8192];

int main(int argc, char **argv) {

	int xsize=0,ysize=0,error;
	int c,x,y,z,color1;
	unsigned char *image;
	unsigned char byte1,byte2,colors[14];

	char *filename;

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

	memset(apple2_image,0,8192);

	if (loadpng(filename,&image,&xsize,&ysize)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

	for(y=0;y<192;y++) {
		for(x=0;x<20;x++) {
			for(z=0;z<14;z++) {
				color1=image[y*280+x*14+z];
//				if (color1!=color2) {
//					fprintf(stderr,"Warning: color at %d x %d doesn't match\n",
//							x*14+z*2,y);
//
//				}
				colors[z]=color1;
			}
			error=colors_to_bytes(colors,&byte1,&byte2);
			if (error!=0) {
				fprintf(stderr,"Warning: mixing colors at %d x %d\n",
					x*14+error*7,y);
			}

			apple2_image[hgr_offset(y)+(x*2)+0]=byte1;
			apple2_image[hgr_offset(y)+(x*2)+1]=byte2;
		}

	}

	fwrite(apple2_image,8192,sizeof(unsigned char),stdout);

	return 0;
}
