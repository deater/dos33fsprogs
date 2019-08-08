include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c5_cave.inc

#####

ootw_c5_cave.inc:	$(PNG2RLE) \
	entrance_cave.png
	$(PNG2RLE) asm entrance_cave.png entrance_rle > ootw_c5_cave.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

