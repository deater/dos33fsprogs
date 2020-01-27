include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c9_swim.inc

#####

ootw_c9_swim.inc:	$(PNG2RLE) \
	pool.png
	$(PNG2RLE) asm pool.png pool_rle > ootw_c9_swim.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

