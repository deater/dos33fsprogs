include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c2_cage.inc

#####

ootw_c2_cage.inc:	$(PNG2RLE) \
	ootw_c2_nocage.png ootw_c2_cage_fell.png \
	debris1.png debris2.png debris3.png
	$(PNG2RLE) asm ootw_c2_cage_fell.png cage_fell_rle > ootw_c2_cage.inc
	$(PNG2RLE) asm ootw_c2_nocage.png cage_rle >> ootw_c2_cage.inc
	$(PNG2RLE) asm debris1.png debris1_rle >> ootw_c2_cage.inc
	$(PNG2RLE) asm debris2.png debris2_rle >> ootw_c2_cage.inc
	$(PNG2RLE) asm debris3.png debris3_rle >> ootw_c2_cage.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

