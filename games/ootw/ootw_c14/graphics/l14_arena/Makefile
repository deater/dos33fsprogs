include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c14_arena.inc

#####

ootw_c14_arena.inc:	$(PNG2RLE) \
	arena.png
	$(PNG2RLE) asm arena.png arena_rle > ootw_c14_arena.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

