/* Converts a png frame grabbed from ZX spectrum SCA animation */
/* 320x240 to a 40x48 png apple II gr file */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"

#include <png.h>

static int convert_color(int color, char *filename) {

	int c=0;

	switch(color) {
		case 0x000000:	c=0; break;	/* black */
		case 0x0000cd:	c=2; break;	/* dark blue => dark blue */
		case 0x0000ff:	c=2; break;	/* bright blue => dark blue */
		case 0xcd0000:	c=1; break;	/* dark red => magenta */
		case 0xff0000:	c=1; break;	/* bright red => magenta */
		case 0xff00ff:	c=3; break;	/* pink => purple */
		case 0x00cd00:	c=4; break;	/* dark green => dark green */
		case 0x00cdcd:	c=6; break;	/* dark cyan => medium blue */
		case 0x00ff00:	c=12; break;	/* light green => bright green */
		case 0xcdcd00:	c=8; break;	/* dark yellow => brown */
		case 0x00ffff:	c=7; break;	/* light blue => light blue */
		case 0xcdcdcd:	c=5; break;	/* grey => grey */
		case 0xffff00:	c=13; break;	/* light yellow => yellow */
		case 0xcd00cd:	c=3; break;	/* dark purple => purple */

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
		case 0xf5ff00:	c=10; break;	/* transparent */
		default:
			fprintf(stderr,"Unknown color %x, file %s\n",
				color,filename);
			c=14;
//			exit(-1);
			break;
	}

	return c;
}

/* expects a PNG where the xsize is 320 */

/* xsize, ysize is the size of the result, not size of */
/* the input image */
int loadsca(char *filename, unsigned char **image_ptr, int *xsize, int *ysize,
	int png_type) {

	int x,y,ystart,yadd,xadd;
	int color;
	FILE *infile;
	int debug=0;
	unsigned char *image,*out_ptr;
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

	/* get the xadd */
	if (width==320) {
		*xsize=40;
		xadd=8;
		yadd=4; /* FIXME: check we are 192 in ysize */
	}
	else {
		fprintf(stderr,"Unsupported width %d\n",width);
		return -1;
	}

	if ((png_type==PNG_WHOLETHING) || (png_type==PNG_NO_ADJUST)) {
		*ysize=height;
		ystart=0;
		yadd*=2;
	}
	else if (png_type==PNG_ODDLINES) {
		*ysize=height/2;
		ystart=1;
		yadd*=4;
	}
	else if (png_type==PNG_EVENLINES) {
		*ysize=height/2;
		ystart=0;
		yadd*=4;
	}
	else if (png_type==PNG_RAW) {
		/* FIXME, not working */
		*ysize=height;
		ystart=0;
		yadd=1;
	}
	else {
		fprintf(stderr,"Unknown PNG type\n");
		return -1;
	}

	color_type = png_get_color_type(png_ptr, info_ptr);
	bit_depth = png_get_bit_depth(png_ptr, info_ptr);

	if (debug) {
		printf("PNG: width=%d height=%d depth=%d\n",width,height,bit_depth);
		if (color_type==PNG_COLOR_TYPE_RGB) printf("Type RGB\n");
		else if (color_type==PNG_COLOR_TYPE_RGB_ALPHA) printf("Type RGBA\n");
		else if (color_type==PNG_COLOR_TYPE_PALETTE) printf("Type palette\n");
		printf("Generating output size %d x %d\n",*xsize,*ysize);
	}

//        number_of_passes = png_set_interlace_handling(png_ptr);
	png_read_update_info(png_ptr, info_ptr);

	row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * height);
	for (y=0; y<height; y++) {
		/* FIXME: do we ever free these? */
		row_pointers[y] = (png_byte*) malloc(png_get_rowbytes(png_ptr,info_ptr));
	}

	png_read_image(png_ptr, row_pointers);

	fclose(infile);

	/* FIXME: this should be 40x24 max??? */
	image=calloc(width*height,sizeof(unsigned char));
	if (image==NULL) {
		fprintf(stderr,"Memory error!\n");
		return -1;
	}
	out_ptr=image;

	if (color_type==PNG_COLOR_TYPE_RGB_ALPHA) {
		for(y=ystart;y<height;y+=yadd) {
			for(x=0;x<width;x+=xadd) {

				/* top color */
//				color=	(row_pointers[y][x*xadd*4]<<16)+
//					(row_pointers[y][x*xadd*4+1]<<8)+
//					(row_pointers[y][x*xadd*4+2]);
				color=	(row_pointers[y][x*4]<<16)+
					(row_pointers[y][x*4+1]<<8)+
					(row_pointers[y][x*4+2]);

//				if (debug) {
//					printf("%x/",color);
//				}

				a2_color=convert_color(color,filename);

				/* bottom color */
				color=	(row_pointers[y+yadd/2][x*4]<<16)+
					(row_pointers[y+yadd/2][x*4+1]<<8)+
					(row_pointers[y+yadd/2][x*4+2]);
//				if (debug) {
//					printf("%x ",color);
//				}

				a2_color|=(convert_color(color,filename)<<4);

				if (debug) printf("%02X ",a2_color);

				*out_ptr=a2_color;
				out_ptr++;
			}
			if (debug) printf("\n\n");
		}
	}
	else if (color_type==PNG_COLOR_TYPE_PALETTE) {
		for(y=ystart;y<height;y+=yadd) {
			for(x=0;x<width;x+=xadd) {

				if (bit_depth==8) {
					/* top color */
					a2_color=row_pointers[y][x];
					if (a2_color==16) {
						a2_color=10;
					}
					if (a2_color>16) {
						fprintf(stderr,"Error color %d\n",a2_color);
					}

					/* bottom color */
					color=row_pointers[y+(yadd/2)][x];
					if (color==16) {
						color=10;
					}
					if (color>16) {
						fprintf(stderr,"Error color %d\n",color);
					}

					a2_color|=(color<<4);

					if (debug) {
						printf("%x ",a2_color);
					}

					*out_ptr=a2_color;
					out_ptr++;
				}
				else if (bit_depth==4) {
					/* top color */
					a2_color=row_pointers[y][x/2];
					if (x%2==0) {
						a2_color=(a2_color>>4);
					}
					a2_color&=0xf;

					/* bottom color */
					color=row_pointers[y+(yadd/2)][x/2];
					if (x%2==0) {
						color=(color>>4);
					}
					color&=0xf;

					a2_color|=(color<<4);

					if (debug) {
						printf("%x ",a2_color);
					}

					*out_ptr=a2_color;
					out_ptr++;

				}
			}
			if (debug) printf("\n");
		}
	}
	else {
		printf("Unknown color type\n");
	}


	*image_ptr=image;

	return 0;
}


static short gr_offsets[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};



/* Converts a PNG to a GR file you can BLOAD to 0x400		*/
/* HOWEVER you *never* want to do this in real life		*/
/* as it will clobber important values in the memory holes	*/

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int x;
	unsigned char out_buffer[1024];

	unsigned char *image;
	int xsize,ysize;
	FILE *outfile;

	if (argc<3) {
		fprintf(stderr,"Usage:\t%s INFILE OUTFILE\n\n",argv[0]);
		exit(-1);
	}

	outfile=fopen(argv[2],"w");
	if (outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",argv[2]);
		exit(-1);
	}

	if (loadsca(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);


	memset(out_buffer,0,1024);
	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			out_buffer[(gr_offsets[row]-0x400)+col]=
							image[(row+3)*xsize+col];
		}
	}

	for(x=0;x<1024;x++) fputc( out_buffer[x],outfile);

	fclose(outfile);

	return 0;
}
