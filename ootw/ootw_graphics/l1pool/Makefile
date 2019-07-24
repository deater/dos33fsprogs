include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_pool.inc

#####

ootw_pool.inc:	$(PNG2RLE) another_pool.png
	$(PNG2RLE) asm another_pool.png pool_rle > ootw_pool.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

