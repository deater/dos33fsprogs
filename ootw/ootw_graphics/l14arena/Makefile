include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c14_arena.inc

#####

ootw_c14_arena.inc:	$(PNG2RLE) \
	arena.png
	$(PNG2RLE) asm arena.png arena_rle > ootw_c14_arena.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

