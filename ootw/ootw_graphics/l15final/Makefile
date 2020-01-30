include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c15_final.inc

#####

ootw_c15_final.inc:	$(PNG2RLE) \
	bath.png walkway1.png walkway2.png walkway3.png above_pit.png final.png
	$(PNG2RLE) asm bath.png bath_rle > ootw_c15_final.inc
	$(PNG2RLE) asm walkway1.png walkway1_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm walkway2.png walkway2_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm walkway3.png walkway3_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm above_pit.png above_pit_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm final.png final_rle >> ootw_c15_final.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

