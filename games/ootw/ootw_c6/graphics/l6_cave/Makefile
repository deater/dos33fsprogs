include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c6_cave.inc

#####

ootw_c6_cave.inc:	$(PNG2RLE) \
	cave.png
	$(PNG2RLE) asm cave.png cave_rle > ootw_c6_cave.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

