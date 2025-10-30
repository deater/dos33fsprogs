/* Grabs part of 280x192 8-bit PNG file with correct palette */
/* Makes "sprites" suitable for Apple II DHGR */

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

static int debug=0,color_warnings=0;

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


static void print_help(char *name,int version) {

	printf("\n%s version %s\n",VERSION,name);

	if (version) exit(1);

	printf("\nUsage: %s [-h] [-v] [-a] [-d] [-s] [-l label] PNGFILE x1 y1 x2 y2\n\n",name);
	printf("\t[-a] generate only aux data\n");
	printf("\t[-d] debug\n");
	printf("\t[-h] help\n");
	printf("\t[-b] version\n");
	printf("\t[-s] emit size of sprite before the data\n");
	printf("\t[-l label] for the sprite\n");
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


/* rotated right by 1 */
static unsigned char dhgr_remap[16]={
	/* 0000 -> 0000 black */	0x00,
	/* 0001 -> 1000 magenta */	0x08,
	/* 0010 -> 0001 dark blue */	0x01,
	/* 0011 -> 1001 purple */	0x09,
	/* 0100 -> 0010 dark green */	0x02,
	/* 0101 -> 1010 grey 1 */	0x0a,
	/* 0110 -> 0011 med blue */	0x03,
	/* 0111 -> 1011 lt blue */	0x0b,
	/* 1000 -> 0100 brown */	0x04,
	/* 1001 -> 1100 orange */	0x0c,
	/* 1010 -> 0101 grey2 */	0x05,
	/* 1011 -> 1101 pink */		0x0d,
	/* 1100 -> 0110 br green */	0x06,
	/* 1101 -> 1110 yellow */	0x0e,
	/* 1110 -> 0111 aqua */		0x07,
	/* 1111 -> 1111 white */	0x0f,
};



/*

  AUX       MAIN     AUX      MAIN
 PBBBAAAA PDDCCCCB PFEEEEDD PGGGGFFF

*/

static int colors_to_bytes(unsigned char colors[14],
			unsigned char *byte0,
			unsigned char *byte1,
			unsigned char *byte2,
			unsigned char *byte3) {


	int error=0,i;
	int debug=0;

	if (debug) {
		printf("Colors before: ");
		for(i=0;i<14;i++) {
			printf("%d ",colors[i]);
		}
	}

	for(i=0;i<14;i++) {
		colors[i]=dhgr_remap[colors[i]];
	}

	if (debug) {
		printf("Colors after: ");
		for(i=0;i<14;i++) {
			printf("%d ",colors[i]);
		}
	}

	for(i=0;i<7;i++) {
		if (colors[i*2]!=colors[(i*2)+1]) {
			colors[i*2]=(colors[i*2]&0x3)|(colors[(i*2)+1]&0xc);
		}
	}

	/* aux0 */
	*byte0 = (colors[0]) | ((colors[2]&0x7)<<4);

	/* main0 */
	*byte1 = (colors[2]>>3) | (colors[4]<<1) | ((colors[6]&3)<<5);

	/* aux1 */
	*byte2 = (colors[6]>>2) | ((colors[8])<<2) | ((colors[10]&1)<<6);

	/* main1 */
	*byte3 = (colors[10]>>1) | (colors[12]<<3);

	if (debug) {
		printf("\t%x %x %x %x\n",*byte0,*byte1,*byte2,*byte3);
	}

	return error;
}


static unsigned char apple2_main[8192];
static unsigned char apple2_aux[8192];

int main(int argc, char **argv) {

	int xsize=0,ysize=0;
	int printsize=0,total_bytes=0;
	int only_aux=0,only_main=0;
	int c,x,y,z,color1;
	unsigned char *image;
	unsigned char byte0,byte1,byte2,byte3,colors[14];
	char label_string[BUFSIZ];

	int x1,y1,x2,y2;

	int xs;

	char *filename;

	strncpy(label_string,"sprite",BUFSIZ);

	/* Parse command line arguments */

	while ( (c=getopt(argc, argv, "hvadmsl:") ) != -1) {

		switch(c) {
			case 'a':
				only_aux=1;
				break;
                        case 'h':
                                print_help(argv[0],0);
				break;
                        case 'v':
                                print_help(argv[0],1);
				break;
			case 'd':
				debug=1;
				break;
			case 's':
				printsize=1;
				break;
			case 'm':
				only_main=1;
				break;
			case 'l':
				strncpy(label_string,optarg,BUFSIZ-1);
				break;
			default:
				print_help(argv[0],0);
				break;
		}
	}

	if (argc-optind<5) {
		printf("ERROR: Was expecting filename and co-ords!\n");
		//printf("\targc=%d optind=%d\n",argc,optind);
		exit(1);
	}

	filename=strdup(argv[optind]);

	x1=atoi(argv[optind+1]);
	y1=atoi(argv[optind+2]);
	x2=atoi(argv[optind+3]);
	y2=atoi(argv[optind+4]);

	memset(apple2_main,0,8192);
	memset(apple2_aux,0,8192);

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
//				}
				colors[z]=color1;
			}
			colors_to_bytes(colors,&byte0,&byte1,&byte2,&byte3);

			apple2_aux[hgr_offset(y)+(x*2)+0]=byte0;
			apple2_main[hgr_offset(y)+(x*2)+0]=byte1;
			apple2_aux[hgr_offset(y)+(x*2)+1]=byte2;
			apple2_main[hgr_offset(y)+(x*2)+1]=byte3;
		}

	}

	if (x1%7) {
		fprintf(stderr,"Warning!  x1 should be a multiple of 7\n");
	}

	xs=(x2/7-x1/7);
	if (!((x2%7==0)&&(x1%7==0))) xs++;

	total_bytes=(xs*(y2-y1));
//	if (printsize) total_bytes+=2;
//	if (mask_offset) total_bytes+=2;

	if (!only_aux) {
		printf("; %d %d %d %d\n",x1,y1,x2,y2);
		printf("; total bytes: %d\n",total_bytes);
		printf("%s_main:\n",label_string);

		if (printsize) {
			printf("\t.byte $%02X,$%02X\n",xs,y2-y1);
		}

		for(y=y1;y<y2;y++) {
			printf("\t.byte ");
			for(x=x1/7;x<=x2/7;x++) {
				printf("$%02X",apple2_main[hgr_offset(y)+x]);
				if (x!=x2/7) printf(",");
			}
			printf("\n");
		}
	}

	if (!only_main) {

		printf("; %d %d %d %d\n",x1,y1,x2,y2);
		printf("; total bytes: %d\n",total_bytes);
		printf("%s_aux:\n",label_string);

		if (printsize) {
			printf("\t.byte $%02X,$%02X\n",xs,y2-y1);
		}


		for(y=y1;y<y2;y++) {
			printf("\t.byte ");
			for(x=x1/7;x<=x2/7;x++) {
				printf("$%02X",apple2_aux[hgr_offset(y)+x]);
				if (x!=x2/7) printf(",");
			}
			printf("\n");
		}
	}


	fprintf(stderr,"Total warnings: %d\n",color_warnings);

	return 0;
}
