/* Convert a 40x96 image into two, 40x48 images suitable of loading */
/* with my kfest18 based code */

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <png.h>

#define OUTPUT_C	0
#define OUTPUT_ASM	1


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
int loadpng(char *filename, unsigned char **image_ptr, int *xsize, int *ysize,
		int high) {

	int x,y;
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
//	int number_of_passes;

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

	*image_ptr=image;

	return 0;
}




/*****************************************/
/* \/                                 \/ */
/* Converts a PNG to RLE compressed data */
/*****************************************/


static int print_run(int count, int out_type, int run, int last) {

	int size=0;

	if (count==0) {
		if (out_type==OUTPUT_C) {
			printf("\n\t");
		}
		else {
			printf("\n\t.byte ");
		}
	}
	else {
		if (out_type==OUTPUT_C) {
		}
		else {
			printf(", ");
		}
	}

	if (run==1) {
		if (out_type==OUTPUT_C) {
			printf("0x%02X,",last);
		}
		else {
			printf("$%02X",last);
		}
		size++;
	}
	if (run==2) {
		if (out_type==OUTPUT_C) {
			printf("0x%02X,0x%02X,",last,last);
		}
		else {
			printf("$%02X,$%02X",last,last);
		}
		size+=2;
	}

	if ((run>2) && (run<16)) {
		if (out_type==OUTPUT_C) {
			printf("0x%02X,0x%02X,",0xA0|run,last);
		}
		else {
			printf("$%02X,$%02X",0xA0|run,last);
		}
		size+=2;
	}

	if (run>=16) {
		if (out_type==OUTPUT_C) {
			printf("0x%02X,0x%02X,0x%02X,",0xA0,run,last);
		}
		else {
			printf("$%02X,$%02X,$%02X",0xA0,run,last);
		}
		size+=3;
	}

	return size;
}

int rle_smaller(int out_type, char *varname,
		int xsize,int ysize, unsigned char *image,int high) {

	int run=0;
	int x;

	int last=-1,next;
	int size=0;
	int count=0;

	x=0;

	/* Write out xsize and ysize */

	if (out_type==OUTPUT_C) {
		fprintf(stdout,"unsigned char %s_%s[]={\n",varname,
			high?"high":"low");
		fprintf(stdout,"\t0x%X, /* ysize=%d */",xsize,ysize);
	}
	else {
		fprintf(stdout,"%s_%s:",varname,high?"high":"low");
		fprintf(stdout,"\t.byte $%X ; ysize=%d",xsize,ysize);
	}

	size+=2;

	/* Get first top/bottom color pair */
	last=image[x];
	run++;
	x++;

	while(1) {

		/* get next top/bottom color pair */
		next=image[x];

		if ((next&0xf0)==0xA0) {
			fprintf(stderr,"Warning! Using color A (grey2)!\n");
			next&=~0xf0;
			next|=0x50; // substitute grey1
		}

		/* If color change (or too big) then output our run */
		/* Note 0xff for run length is special case meaning "finished" */
		if ((next!=last) || (run>254)) {

			size+=print_run(count,out_type,run,last);

			count++;
			run=0;
			last=next;
		}

		x++;

		/* If we reach the end */
		if (x>=xsize*(ysize/2)) {
			run++;

			size+=print_run(count,out_type,run,last);

			break;

		}

		run++;
		if (count>6) count=0;

	}

	/* Print closing marker */

	if (out_type==OUTPUT_C) {
		fprintf(stdout,"0xA1,");
		fprintf(stdout,"\t};\n");
	} else {
		fprintf(stdout,"\n\t.byte $A1\n");
	}

	size+=1;

	return size;
}



/* Converts a PNG to RLE compressed data */

int main(int argc, char **argv) {

	unsigned char *image;
	int xsize,ysize;
	int size=0;
	int out_type=OUTPUT_C;

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s type INFILE varname\n\n",argv[0]);
		fprintf(stderr,"\ttype: c or asm\n");
		fprintf(stderr,"\tvarname: label for graphic\n");
		fprintf(stderr,"\n");

		exit(-1);
	}

	if (!strcmp(argv[1],"c")) {
		out_type=OUTPUT_C;
	}
	else if (!strcmp(argv[1],"asm")) {
		out_type=OUTPUT_ASM;
	}

	if (loadpng(argv[2],&image,&xsize,&ysize,1)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

//	size=rle_original(out_type,argv[3],
//		xsize,ysize,image);

	size=rle_smaller(out_type,argv[3],
		xsize,ysize,image,0);

	fprintf(stderr,"Size %d bytes\n",size);

	if (loadpng(argv[2],&image,&xsize,&ysize,0)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

//	size=rle_original(out_type,argv[3],
//		xsize,ysize,image);

	size=rle_smaller(out_type,argv[3],
		xsize,ysize,image,1);

	fprintf(stderr,"Size %d bytes\n",size);


	return 0;
}







