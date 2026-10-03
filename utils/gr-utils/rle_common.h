#define OUTPUT_C	0
#define OUTPUT_ASM	1
#define OUTPUT_RAW	2
#define OUTPUT_BIN	3

int rle_smaller(int out_type, char *varname,
		int xsize,int ysize, unsigned char *image);

