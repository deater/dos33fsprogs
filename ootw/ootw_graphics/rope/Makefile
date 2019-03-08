include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_rope.inc

#####

ootw_rope.inc:	$(PNG2RLE) another_rope.png
	$(PNG2RLE) asm another_rope.png rope_rle > ootw_rope.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

