#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <png.h>

/* TODO: */
/* 40x48 images */
/* 80x40, 80x48 double-highres images */

int main(int argc, char **argv) {

	int image[40][40];
	int x,y;
	FILE *infile,*outfile;
	int debug=0;

	if (argc<3) {
		fprintf(stderr,"Usage:\t%s INFILE OUTFILE\n\n",argv[0]);
		exit(-1);
	}

	outfile=fopen(argv[2],"w");
	if (outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",argv[2]);
		exit(-1);
	}

	int width, height;
	png_byte color_type;
	png_byte bit_depth;

	png_structp png_ptr;
	png_infop info_ptr;
	int number_of_passes;
	png_bytep * row_pointers;

	unsigned char header[8];

        /* open file and test for it being a png */
        infile = fopen(argv[1], "rb");
        if (infile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",argv[1]);
		exit(-1);
	}

	/* Check the header */
        fread(header, 1, 8, infile);
        if (png_sig_cmp(header, 0, 8)) {
		fprintf(stderr,"Error!  %s is not a PNG file\n",argv[1]);
		exit(-1);
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
        color_type = png_get_color_type(png_ptr, info_ptr);
        bit_depth = png_get_bit_depth(png_ptr, info_ptr);

	if (debug) {
		printf("PNG: width=%d height=%d depth=%d\n",width,height,bit_depth);
	}

        number_of_passes = png_set_interlace_handling(png_ptr);
        png_read_update_info(png_ptr, info_ptr);

        row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * height);
        for (y=0; y<height; y++) {
                row_pointers[y] = (png_byte*) malloc(png_get_rowbytes(png_ptr,info_ptr));
	}

        png_read_image(png_ptr, row_pointers);

        fclose(infile);

	int color;

	for(y=0;y<40;y++) {
		for(x=0;x<40;x++) {
			color=	(row_pointers[y][x*2*4]<<16)+
				(row_pointers[y][x*2*4+1]<<8)+
				(row_pointers[y][x*2*4+2]);
			if (debug) {
				printf("%x ",color);
//				printf("(%x,%x,%x,%x) ",
//					row_pointers[y][x*2*4],
//					row_pointers[y][x*2*4+1],
//					row_pointers[y][x*2*4+2],
//					row_pointers[y][x*2*4+3]);
			}
			switch(color) {
				case 0:	image[x][y]=0;		/* black */
					break;
				case 0xe31e60: image[x][y]=1;	/* magenta */
					break;
				case 0x604ebd: image[x][y]=2;	/* dark blue */
					break;
				case 0xff44fd: image[x][y]=3;	/* purple */
					break;
				case 0xa360:   image[x][y]=4;	/* dark green */
					break;
				case 0x9c9c9c: image[x][y]=5;	/* grey 1 */
					break;
				case 0x14cffd: image[x][y]=6;	/* medium blue */
					break;
				case 0xd0c3ff: image[x][y]=7;	/* light blue */
					break;
				case 0x607203: image[x][y]=8;	/* brown */
					break;
				case 0xff6a3c: image[x][y]=9;	/* orange */
					break;
				case 0x9d9d9d: image[x][y]=10;	/* grey 2 */
					break;
				case 0xffa0d0: image[x][y]=11;	/* pink */
					break;
				case 0x14f53c: image[x][y]=12;	/* bright green */
					break;
				case 0xd0dd8d: image[x][y]=13;	/* yellow */
					break;
				case 0x72ffd0: image[x][y]=14;	/* aqua */
					break;
				case 0xffffff: image[x][y]=15;	/* white */
					break;

				default:
					printf("Unknown color %x\n",color);
					image[x][y]=0; break;
			}
		}
		if (debug) printf("\n");
	}

	/* Stripe test image */
//	for(x=0;x<40;x++) for(y=0;y<40;y++) image[x][y]=y%16;

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

	int row=0;
	int col=0;
	int enough=0;

	x=0;
	while(1) {
		fputc( image[col][row] | (image[col][row+1]<<4),outfile);
		x++;
		if (x>0x3f8) break;
		enough++;
		if (enough>119) {
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			fputc(0,outfile);
			enough=0;
		}

		col++;
		if (col>39) {
			col=0;
			row+=16;
			if (row>47) row-=46;
		}
	}

	fclose(outfile);

	return 0;
}
