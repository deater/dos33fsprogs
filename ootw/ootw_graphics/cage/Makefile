include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c2_cage.inc

#####

ootw_c2_cage.inc:	$(PNG2RLE) \
	ootw_c2_cage.png
	$(PNG2RLE) asm ootw_c2_cage.png cage_rle > ootw_c2_cage.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

