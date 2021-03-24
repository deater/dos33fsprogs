include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c7_cave.inc

#####

ootw_c7_cave.inc:	$(PNG2RLE) \
	cave.png
	$(PNG2RLE) asm cave.png cave_rle > ootw_c7_cave.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

