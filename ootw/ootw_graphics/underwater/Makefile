include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_underwater.inc

#####

ootw_underwater.inc:	$(PNG2RLE) another_uboot.png
	$(PNG2RLE) asm another_uboot.png underwater_rle > ootw_underwater.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

