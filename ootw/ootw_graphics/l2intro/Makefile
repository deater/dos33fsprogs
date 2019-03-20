include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_l2intro.inc

#####

ootw_l2intro.inc:	$(PNG2RLE) \
	ootw2_cage.png
	$(PNG2RLE) asm ootw2_cage.png intro_cage_rle > ootw_l2intro.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

