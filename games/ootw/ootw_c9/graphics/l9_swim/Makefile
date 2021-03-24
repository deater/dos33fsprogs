include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c9_swim.inc

#####

ootw_c9_swim.inc:	$(PNG2RLE) \
	pool.png
	$(PNG2RLE) asm pool.png pool_rle > ootw_c9_swim.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

