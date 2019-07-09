include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c2_jail.inc

#####

ootw_c2_jail.inc:	$(PNG2RLE) \
	ootw_c2_cage_fell.png jail2_bg.png
	$(PNG2RLE) asm ootw_c2_cage_fell.png cage_fell_rle > ootw_c2_jail.inc
	$(PNG2RLE) asm jail2_bg.png jail2_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm jail3_bg.png jail3_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm jail4_bg.png jail4_rle >> ootw_c2_jail.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

