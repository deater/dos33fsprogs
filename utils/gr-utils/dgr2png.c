/* Take two Apple II 40x48 15-color graphics images (MAIN and AUX) */
/* and make a png file */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

#include <png.h>

#define PAL_LENGTH	16	// PNG_MAX_PALETTE_LENGTH

static int gr_offsets[24]={
        0x400-0x400,0x480-0x400,0x500-0x400,0x580-0x400,0x600-0x400,0x680-0x400,0x700-0x400,0x780-0x400,
        0x428-0x400,0x4A8-0x400,0x528-0x400,0x5A8-0x400,0x628-0x400,0x6A8-0x400,0x728-0x400,0x7A8-0x400,
        0x450-0x400,0x4D0-0x400,0x550-0x400,0x5D0-0x400,0x650-0x400,0x6D0-0x400,0x750-0x400,0x7D0-0x400,
};

/* rotate left by 1 to unconvert */
static unsigned char aux_colors[]={
	0,	/* 0000 -> 0000 */
	2,	/* 0001 -> 0010 */
	4,	/* 0010 -> 0100 */
	6,	/* 0011 -> 0110 */
	8,	/* 0100 -> 1000 */
	10,	/* 0101 -> 1010 */
	12,	/* 0110 -> 1100 */
	14,	/* 0111 -> 1110 */
	1,	/* 1000 -> 0001 */
	3,	/* 1001 -> 0011 */
	5,	/* 1010	-> 0101 */
	7,	/* 1011 -> 0111 */
	9,	/* 1100 -> 1001 */
	11,	/* 1101 -> 1011 */
	13,	/* 1110 -> 1101 */
	15,	/* 1111 -> 1111 */
};
int main(int argc, char **argv) {

	int fd;
	char filename[256];
	char main_screen[1024];
	char aux_screen[1024];
	FILE *output;
	int width=80,height=48,y,x;
	png_byte color_type=PNG_COLOR_TYPE_PALETTE;
	png_byte bit_depth=8;

	png_structp png_ptr;
	png_infop info_ptr;
//	int number_of_passes;
	png_bytep *row_pointers;
	png_colorp palette;
	png_color *col;

	if (argc<2) {
		fprintf(stderr,"Usage: gr2png MAIN AUX OUTPUT\n");
		fprintf(stderr,"  where MAIN/AUX are 1k AppleII LORES image\n\n");
		return -1;
	}

	if (argc<3) {
		sprintf(filename,"%s.png",argv[1]);
	}
	else {
		strncpy(filename,argv[3],256-1);
	}

	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		printf("Error opening %s! %s\n",argv[1],strerror(errno));
		return -1;
	}
	read(fd,main_screen,1024);
	close(fd);

	fd=open(argv[2],O_RDONLY);
	if (fd<0) {
		printf("Error opening %s! %s\n",argv[2],strerror(errno));
		return -1;
	}
	read(fd,aux_screen,1024);
	close(fd);



	output = fopen(filename, "wb");
	if (output==NULL) {
		printf("Error opening %s, %s\n",filename,strerror(errno));
		return -1;
	}

	/* initialize */
	png_ptr = png_create_write_struct(
			PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

        if (png_ptr==NULL) {
		fprintf(stderr,"Error!  png_create_write_struct() failed\n");
		return -1;
	}

        info_ptr = png_create_info_struct(png_ptr);
        if (info_ptr==NULL) {
		fprintf(stderr,"Error!  png_create_info_struct() failed\n");
		return -1;
	}

//	setjmp(png_jmpbuf(png_ptr));

	png_init_io(png_ptr, output);

        /* write header */
//	setjmp(png_jmpbuf(png_ptr));

	png_set_IHDR(png_ptr, info_ptr, width, height,
			bit_depth, color_type, PNG_INTERLACE_NONE,
			PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

//	png_write_info(png_ptr, info_ptr);

	/* set palette */
	palette = (png_colorp)png_malloc(png_ptr,
		PAL_LENGTH * (sizeof (png_color)));

	/* 0: black */
	col=&palette[0]; col->red=0x00; col->green=0x00; col->blue=0x00;
	/* 1: magenta */
	col=&palette[1]; col->red=0xe3; col->green=0x1e; col->blue=0x60;
	/* 2: dark blue */
	col=&palette[2]; col->red=0x60; col->green=0x4e; col->blue=0xbd;
	/* 3: purple */
	col=&palette[3]; col->red=0xff; col->green=0x44; col->blue=0xfd;
	/* 4: dark green */
	col=&palette[4]; col->red=0x00; col->green=0xa3; col->blue=0x60;
	/* 5: grey 1 */
	col=&palette[5]; col->red=0x9c; col->green=0x9c; col->blue=0x9c;
	/* 6: medium blue */
	col=&palette[6]; col->red=0x14; col->green=0xcf; col->blue=0xfd;
	/* 7: light blue */
	col=&palette[7]; col->red=0xd0; col->green=0xc3; col->blue=0xff;
	/* 8: brown */
	col=&palette[8]; col->red=0x60; col->green=0x72; col->blue=0x03;
	/* 9: orange */
	col=&palette[9]; col->red=0xff; col->green=0x6a; col->blue=0x3c;
	/* 10: gray 2 */
	col=&palette[10]; col->red=0x9d; col->green=0x9d; col->blue=0x9d;
	/* 11: pink */
	col=&palette[11]; col->red=0xff; col->green=0xa0; col->blue=0xd0;
	/* 12: bright green */
	col=&palette[12]; col->red=0x14; col->green=0xf5; col->blue=0x3c;
	/* 13: yellow */
	col=&palette[13]; col->red=0xd0; col->green=0xdd; col->blue=0x8d;
	/* 14: aqua */
	col=&palette[14]; col->red=0x72; col->green=0xff; col->blue=0xd0;
	/* 15: white */
	col=&palette[15]; col->red=0xff; col->green=0xff; col->blue=0xff;

	/* ... Set palette colors ... */
	png_set_PLTE(png_ptr, info_ptr, palette, PAL_LENGTH);

	png_write_info(png_ptr, info_ptr);



	row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * height);

	for(y=0;y<height;y++) {
		row_pointers[y]=malloc(width);
	}

	/*********************************************/
	/* do the actual conversion                  */
	/*********************************************/
	int color1,color2;

	for(y=0;y<height/2;y++) {
		for(x=0;x<40;x++) {

			/* note the aux colors are rotated right by 1 */

			color1=(aux_screen[gr_offsets[y]+x])&0xf;
			row_pointers[y*2][x*2]=aux_colors[color1];
			color2=(main_screen[gr_offsets[y]+x])&0xf;
			row_pointers[y*2][(x*2)+1]=color2;


			color1=((aux_screen[gr_offsets[y]+x])>>4)&0xf;
			row_pointers[(y*2)+1][x*2]=aux_colors[color1];
			color2=((main_screen[gr_offsets[y]+x])>>4)&0xf;
			row_pointers[(y*2)+1][(x*2)+1]=color2;
		}
	}

        png_write_image(png_ptr, row_pointers);


	png_write_end(png_ptr, NULL);

	/* cleanup heap allocation */
	for (y=0; y<height; y++) {
		free(row_pointers[y]);
	}
	free(row_pointers);

	fclose(output);

	return 0;
}
