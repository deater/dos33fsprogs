#define PNG_WHOLETHING	0
#define PNG_ODDLINES	1
#define PNG_EVENLINES	2

int loadpng(char *filename, unsigned char **image_ptr, int *xsize, int *ysize,
	int png_type);

