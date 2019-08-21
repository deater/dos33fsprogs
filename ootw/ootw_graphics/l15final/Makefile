include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c15_final.inc

#####

ootw_c15_final.inc:	$(PNG2RLE) \
	bath.png battle.png grabbed.png
	$(PNG2RLE) asm bath.png bath_rle > ootw_c15_final.inc
	$(PNG2RLE) asm battle.png battle_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm grabbed.png grabbed_rle >> ootw_c15_final.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

