include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c15_bath.inc ootw_c15_final.inc

#####

ootw_c15_bath.inc:	$(PNG2RLE) \
	bath_00.png bath_01.png bath_02.png bath_03.png bath_04.png \
	bath_05.png bath_06.png bath_07.png bath_08.png bath_09.png \
	bath_10.png bath_11.png bath_12.png bath_13.png bath_14.png \
	bath_15.png bath_16.png bath_17.png bath_18.png bath_19.png \
	bath_20.png bath_21.png bath_22.png bath_23.png bath_24.png \
	bath_25.png bath_26.png bath_27.png bath_28.png bath_29.png \
	bath_30.png bath_31.png bath_32.png bath_33.png bath_34.png \
	bath_35.png bath_end.png
	$(PNG2RLE) asm bath_00.png bath_00_rle > ootw_c15_bath.inc
	$(PNG2RLE) asm bath_01.png bath_01_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_02.png bath_02_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_03.png bath_03_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_04.png bath_04_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_05.png bath_05_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_06.png bath_06_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_07.png bath_07_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_08.png bath_08_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_09.png bath_09_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_10.png bath_10_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_11.png bath_11_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_12.png bath_12_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_13.png bath_13_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_14.png bath_14_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_15.png bath_15_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_16.png bath_16_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_17.png bath_17_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_18.png bath_18_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_19.png bath_19_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_20.png bath_20_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_21.png bath_21_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_22.png bath_22_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_23.png bath_23_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_24.png bath_24_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_25.png bath_25_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_26.png bath_26_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_27.png bath_27_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_28.png bath_28_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_29.png bath_29_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_30.png bath_30_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_31.png bath_31_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_32.png bath_32_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_33.png bath_33_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_34.png bath_34_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_35.png bath_35_rle >> ootw_c15_bath.inc
	$(PNG2RLE) asm bath_end.png bath_end_rle >> ootw_c15_bath.inc

ootw_c15_final.inc:	$(PNG2RLE) \
	walkway1.png walkway2.png walkway3.png above_pit.png final.png
	$(PNG2RLE) asm walkway1.png walkway1_rle > ootw_c15_final.inc
	$(PNG2RLE) asm walkway2.png walkway2_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm walkway3.png walkway3_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm above_pit.png above_pit_rle >> ootw_c15_final.inc
	$(PNG2RLE) asm final.png final_rle >> ootw_c15_final.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

