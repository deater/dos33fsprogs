include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4


all:	nothing.inc lightning.inc whiteblack.inc \
	nothing_lz4.inc lightning_lz4.inc whiteblack_lz4.inc


#####
nothing.inc:	nothing.png $(PNG2RLE)
	$(PNG2RLE) asm nothing.png nothing_rle > nothing.inc

#####
whiteblack.inc:	white.png black.png $(PNG2RLE)
	$(PNG2RLE) asm white.png white_rle > whiteblack.inc
	$(PNG2RLE) asm black.png black_rle >> whiteblack.inc

#####

lightning.inc:	$(PNG2RLE) \
	bolt1.png bolt2.png bolt3.png bolt4.png bolt5.png bolt6.png bolt7.png \
	flash.png white.png black.png \
	storm01.png storm02.png storm03.png storm04.png storm05.png \
	storm06.png storm08.png storm09.png storm10.png storm11.png \
	storm12.png storm13.png storm14.png storm15.png storm16.png \
	storm29.png storm30.png storm31.png storm32.png storm33.png \
	storm34.png storm35.png storm36.png storm37.png storm38.png \
	storm40.png storm41.png storm42.png
	$(PNG2RLE) asm bolt1.png bolt1_rle > lightning.inc
	$(PNG2RLE) asm bolt2.png bolt2_rle >> lightning.inc
	$(PNG2RLE) asm bolt3.png bolt3_rle >> lightning.inc
	$(PNG2RLE) asm bolt4.png bolt4_rle >> lightning.inc
	$(PNG2RLE) asm bolt5.png bolt5_rle >> lightning.inc
	$(PNG2RLE) asm bolt6.png bolt6_rle >> lightning.inc
	$(PNG2RLE) asm bolt7.png bolt7_rle >> lightning.inc
	$(PNG2RLE) asm flash.png flash_rle >> lightning.inc
	$(PNG2RLE) asm white.png white_rle >> lightning.inc
	$(PNG2RLE) asm black.png black_rle >> lightning.inc
	$(PNG2RLE) asm nothing.png nothing_rle >> lightning.inc
	$(PNG2RLE) asm storm01.png storm01_rle >> lightning.inc
	$(PNG2RLE) asm storm02.png storm02_rle >> lightning.inc
	$(PNG2RLE) asm storm03.png storm03_rle >> lightning.inc
	$(PNG2RLE) asm storm04.png storm04_rle >> lightning.inc
	$(PNG2RLE) asm storm05.png storm05_rle >> lightning.inc
	$(PNG2RLE) asm storm06.png storm06_rle >> lightning.inc
	$(PNG2RLE) asm storm08.png storm08_rle >> lightning.inc
	$(PNG2RLE) asm storm09.png storm09_rle >> lightning.inc
	$(PNG2RLE) asm storm10.png storm10_rle >> lightning.inc
	$(PNG2RLE) asm storm11.png storm11_rle >> lightning.inc
	$(PNG2RLE) asm storm12.png storm12_rle >> lightning.inc
	$(PNG2RLE) asm storm13.png storm13_rle >> lightning.inc
	$(PNG2RLE) asm storm14.png storm14_rle >> lightning.inc
	$(PNG2RLE) asm storm15.png storm15_rle >> lightning.inc
	$(PNG2RLE) asm storm16.png storm16_rle >> lightning.inc
	$(PNG2RLE) asm storm29.png storm29_rle >> lightning.inc
	$(PNG2RLE) asm storm30.png storm30_rle >> lightning.inc
	$(PNG2RLE) asm storm31.png storm31_rle >> lightning.inc
	$(PNG2RLE) asm storm32.png storm32_rle >> lightning.inc
	$(PNG2RLE) asm storm33.png storm33_rle >> lightning.inc
	$(PNG2RLE) asm storm34.png storm34_rle >> lightning.inc
	$(PNG2RLE) asm storm35.png storm35_rle >> lightning.inc
	$(PNG2RLE) asm storm36.png storm36_rle >> lightning.inc
	$(PNG2RLE) asm storm37.png storm37_rle >> lightning.inc
	$(PNG2RLE) asm storm38.png storm38_rle >> lightning.inc
	$(PNG2RLE) asm storm40.png storm40_rle >> lightning.inc
	$(PNG2RLE) asm storm41.png storm41_rle >> lightning.inc
	$(PNG2RLE) asm storm42.png storm42_rle >> lightning.inc

#####
#####

nothing_lz4.inc:	$(PNG2LZ4)
	$(PNG2LZ4) asm nothing.png nothing_rle > nothing_lz4.inc


#####
whiteblack_lz4.inc:	white.png black.png $(PNG2L4)
	$(PNG2LZ4) asm white.png white_rle > whiteblack_lz4.inc
	$(PNG2LZ4) asm black.png black_rle >> whiteblack_lz4.inc



lightning_lz4.inc:	$(PNG2LZ4) \
	bolt1.png bolt2.png bolt3.png bolt4.png bolt5.png bolt6.png bolt7.png \
	flash.png white.png black.png \
	storm01.png storm02.png storm03.png storm04.png storm05.png \
	storm06.png storm08.png storm09.png storm10.png storm11.png \
	storm12.png storm13.png storm14.png storm15.png storm16.png \
	storm29.png storm30.png storm31.png storm32.png storm33.png \
	storm34.png storm35.png storm36.png storm37.png storm38.png \
	storm40.png storm41.png storm42.png
	$(PNG2LZ4) asm bolt1.png bolt1_rle > lightning_lz4.inc
	$(PNG2LZ4) asm bolt2.png bolt2_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm bolt3.png bolt3_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm bolt4.png bolt4_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm bolt5.png bolt5_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm bolt6.png bolt6_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm bolt7.png bolt7_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm flash.png flash_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm white.png white_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm black.png black_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm01.png storm01_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm02.png storm02_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm03.png storm03_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm04.png storm04_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm05.png storm05_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm06.png storm06_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm08.png storm08_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm09.png storm09_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm10.png storm10_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm11.png storm11_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm12.png storm12_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm13.png storm13_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm14.png storm14_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm15.png storm15_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm16.png storm16_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm29.png storm29_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm30.png storm30_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm31.png storm31_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm32.png storm32_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm33.png storm33_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm34.png storm34_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm35.png storm35_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm36.png storm36_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm37.png storm37_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm38.png storm38_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm40.png storm40_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm41.png storm41_rle >> lightning_lz4.inc
	$(PNG2LZ4) asm storm42.png storm42_rle >> lightning_lz4.inc




#####

clean:		
		rm -f *~ *.inc

