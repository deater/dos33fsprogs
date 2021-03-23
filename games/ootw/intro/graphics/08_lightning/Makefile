include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4
PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	nothing.inc lightning.inc whiteblack.inc

#####
nothing.inc:	nothing.lzsa
	echo "nothing_lzsa: .incbin \"nothing.lzsa\"" > nothing.inc

#####
whiteblack.inc:	white.lzsa black.lzsa
	echo "white_lzsa: .incbin \"white.lzsa\"" > whiteblack.inc
	echo "black_lzsa: .incbin \"black.lzsa\"" >> whiteblack.inc

#####

lightning.inc:	\
	bolt1.lzsa bolt2.lzsa bolt3.lzsa bolt4.lzsa \
	bolt5.lzsa bolt6.lzsa bolt7.lzsa \
	flash.lzsa white.lzsa black.lzsa \
	storm01.lzsa storm02.lzsa storm03.lzsa storm04.lzsa storm05.lzsa \
	storm06.lzsa storm08.lzsa storm09.lzsa storm10.lzsa storm11.lzsa \
	storm12.lzsa storm13.lzsa storm14.lzsa storm15.lzsa storm16.lzsa \
	storm29.lzsa storm30.lzsa storm31.lzsa storm32.lzsa storm33.lzsa \
	storm34.lzsa storm35.lzsa storm36.lzsa storm37.lzsa storm38.lzsa \
	storm40.lzsa storm41.lzsa storm42.lzsa
	echo "bolt1_lzsa: .incbin \"bolt1.lzsa\"" > lightning.inc
	echo "bolt2_lzsa: .incbin \"bolt2.lzsa\"" >> lightning.inc
	echo "bolt3_lzsa: .incbin \"bolt3.lzsa\"" >> lightning.inc
	echo "bolt4_lzsa: .incbin \"bolt4.lzsa\"" >> lightning.inc
	echo "bolt5_lzsa: .incbin \"bolt5.lzsa\"" >> lightning.inc
	echo "bolt6_lzsa: .incbin \"bolt6.lzsa\"" >> lightning.inc
	echo "bolt7_lzsa: .incbin \"bolt7.lzsa\"" >> lightning.inc
	echo "flash_lzsa: .incbin \"flash.lzsa\"" >> lightning.inc
	echo "white_lzsa: .incbin \"white.lzsa\"" >> lightning.inc
	echo "black_lzsa: .incbin \"black.lzsa\"" >> lightning.inc
	echo "nothing_lzsa: .incbin \"nothing.lzsa\"" >> lightning.inc
	echo "storm01_lzsa: .incbin \"storm01.lzsa\"" >> lightning.inc
	echo "storm02_lzsa: .incbin \"storm02.lzsa\"" >> lightning.inc
	echo "storm03_lzsa: .incbin \"storm03.lzsa\"" >> lightning.inc
	echo "storm04_lzsa: .incbin \"storm04.lzsa\"" >> lightning.inc
	echo "storm05_lzsa: .incbin \"storm05.lzsa\"" >> lightning.inc
	echo "storm06_lzsa: .incbin \"storm06.lzsa\"" >> lightning.inc
	echo "storm08_lzsa: .incbin \"storm08.lzsa\"" >> lightning.inc
	echo "storm09_lzsa: .incbin \"storm09.lzsa\"" >> lightning.inc
	echo "storm10_lzsa: .incbin \"storm10.lzsa\"" >> lightning.inc
	echo "storm11_lzsa: .incbin \"storm11.lzsa\"" >> lightning.inc
	echo "storm12_lzsa: .incbin \"storm12.lzsa\"" >> lightning.inc
	echo "storm13_lzsa: .incbin \"storm13.lzsa\"" >> lightning.inc
	echo "storm14_lzsa: .incbin \"storm14.lzsa\"" >> lightning.inc
	echo "storm15_lzsa: .incbin \"storm15.lzsa\"" >> lightning.inc
	echo "storm16_lzsa: .incbin \"storm16.lzsa\"" >> lightning.inc
	echo "storm29_lzsa: .incbin \"storm29.lzsa\"" >> lightning.inc
	echo "storm30_lzsa: .incbin \"storm30.lzsa\"" >> lightning.inc
	echo "storm31_lzsa: .incbin \"storm31.lzsa\"" >> lightning.inc
	echo "storm32_lzsa: .incbin \"storm32.lzsa\"" >> lightning.inc
	echo "storm33_lzsa: .incbin \"storm33.lzsa\"" >> lightning.inc
	echo "storm34_lzsa: .incbin \"storm34.lzsa\"" >> lightning.inc
	echo "storm35_lzsa: .incbin \"storm35.lzsa\"" >> lightning.inc
	echo "storm36_lzsa: .incbin \"storm36.lzsa\"" >> lightning.inc
	echo "storm37_lzsa: .incbin \"storm37.lzsa\"" >> lightning.inc
	echo "storm38_lzsa: .incbin \"storm38.lzsa\"" >> lightning.inc
	echo "storm40_lzsa: .incbin \"storm40.lzsa\"" >> lightning.inc
	echo "storm41_lzsa: .incbin \"storm41.lzsa\"" >> lightning.inc
	echo "storm42_lzsa: .incbin \"storm42.lzsa\"" >> lightning.inc


###

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


#####
#nothing.inc:	nothing.png $(PNG2RLE)
#	$(PNG2RLE) asm nothing.png nothing_rle > nothing.inc

#####
#whiteblack.inc:	white.png black.png $(PNG2RLE)
#	$(PNG2RLE) asm white.png white_rle > whiteblack.inc
#	$(PNG2RLE) asm black.png black_rle >> whiteblack.inc

#####

#lightning.inc:	$(PNG2RLE) \
#	bolt1.png bolt2.png bolt3.png bolt4.png bolt5.png bolt6.png bolt7.png \
#	flash.png white.png black.png \
#	storm01.png storm02.png storm03.png storm04.png storm05.png \
#	storm06.png storm08.png storm09.png storm10.png storm11.png \
#	storm12.png storm13.png storm14.png storm15.png storm16.png \
#	storm29.png storm30.png storm31.png storm32.png storm33.png \
#	storm34.png storm35.png storm36.png storm37.png storm38.png \
#	storm40.png storm41.png storm42.png
#	$(PNG2RLE) asm bolt1.png bolt1_rle > lightning.inc
#	$(PNG2RLE) asm bolt2.png bolt2_rle >> lightning.inc
#	$(PNG2RLE) asm bolt3.png bolt3_rle >> lightning.inc
#	$(PNG2RLE) asm bolt4.png bolt4_rle >> lightning.inc
#	$(PNG2RLE) asm bolt5.png bolt5_rle >> lightning.inc
#	$(PNG2RLE) asm bolt6.png bolt6_rle >> lightning.inc
#	$(PNG2RLE) asm bolt7.png bolt7_rle >> lightning.inc
#	$(PNG2RLE) asm flash.png flash_rle >> lightning.inc
#	$(PNG2RLE) asm white.png white_rle >> lightning.inc
#	$(PNG2RLE) asm black.png black_rle >> lightning.inc
#	$(PNG2RLE) asm nothing.png nothing_rle >> lightning.inc
#	$(PNG2RLE) asm storm01.png storm01_rle >> lightning.inc
#	$(PNG2RLE) asm storm02.png storm02_rle >> lightning.inc
#	$(PNG2RLE) asm storm03.png storm03_rle >> lightning.inc
#	$(PNG2RLE) asm storm04.png storm04_rle >> lightning.inc
#	$(PNG2RLE) asm storm05.png storm05_rle >> lightning.inc
#	$(PNG2RLE) asm storm06.png storm06_rle >> lightning.inc
#	$(PNG2RLE) asm storm08.png storm08_rle >> lightning.inc
#	$(PNG2RLE) asm storm09.png storm09_rle >> lightning.inc
#	$(PNG2RLE) asm storm10.png storm10_rle >> lightning.inc
#	$(PNG2RLE) asm storm11.png storm11_rle >> lightning.inc
#	$(PNG2RLE) asm storm12.png storm12_rle >> lightning.inc
#	$(PNG2RLE) asm storm13.png storm13_rle >> lightning.inc
#	$(PNG2RLE) asm storm14.png storm14_rle >> lightning.inc
#	$(PNG2RLE) asm storm15.png storm15_rle >> lightning.inc
#	$(PNG2RLE) asm storm16.png storm16_rle >> lightning.inc
#	$(PNG2RLE) asm storm29.png storm29_rle >> lightning.inc
#	$(PNG2RLE) asm storm30.png storm30_rle >> lightning.inc
#	$(PNG2RLE) asm storm31.png storm31_rle >> lightning.inc
#	$(PNG2RLE) asm storm32.png storm32_rle >> lightning.inc
#	$(PNG2RLE) asm storm33.png storm33_rle >> lightning.inc
#	$(PNG2RLE) asm storm34.png storm34_rle >> lightning.inc
#	$(PNG2RLE) asm storm35.png storm35_rle >> lightning.inc
#	$(PNG2RLE) asm storm36.png storm36_rle >> lightning.inc
#	$(PNG2RLE) asm storm37.png storm37_rle >> lightning.inc
#	$(PNG2RLE) asm storm38.png storm38_rle >> lightning.inc
#	$(PNG2RLE) asm storm40.png storm40_rle >> lightning.inc
#	$(PNG2RLE) asm storm41.png storm41_rle >> lightning.inc
#	$(PNG2RLE) asm storm42.png storm42_rle >> lightning.inc



#####
#####

#nothing_lz4.inc:	$(PNG2LZ4)
#	$(PNG2LZ4) asm nothing.png nothing_rle > nothing_lz4.inc


#####
#whiteblack_lz4.inc:	white.png black.png $(PNG2L4)
#	$(PNG2LZ4) asm white.png white_rle > whiteblack_lz4.inc
#	$(PNG2LZ4) asm black.png black_rle >> whiteblack_lz4.inc



#lightning_lz4.inc:	$(PNG2LZ4) \
#	bolt1.png bolt2.png bolt3.png bolt4.png bolt5.png bolt6.png bolt7.png \
#	flash.png white.png black.png \
#	storm01.png storm02.png storm03.png storm04.png storm05.png \
#	storm06.png storm08.png storm09.png storm10.png storm11.png \
#	storm12.png storm13.png storm14.png storm15.png storm16.png \
#	storm29.png storm30.png storm31.png storm32.png storm33.png \
#	storm34.png storm35.png storm36.png storm37.png storm38.png \
#	storm40.png storm41.png storm42.png
#	$(PNG2LZ4) asm bolt1.png bolt1_rle > lightning_lz4.inc
#	$(PNG2LZ4) asm bolt2.png bolt2_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm bolt3.png bolt3_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm bolt4.png bolt4_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm bolt5.png bolt5_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm bolt6.png bolt6_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm bolt7.png bolt7_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm flash.png flash_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm white.png white_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm black.png black_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm01.png storm01_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm02.png storm02_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm03.png storm03_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm04.png storm04_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm05.png storm05_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm06.png storm06_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm08.png storm08_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm09.png storm09_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm10.png storm10_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm11.png storm11_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm12.png storm12_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm13.png storm13_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm14.png storm14_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm15.png storm15_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm16.png storm16_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm29.png storm29_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm30.png storm30_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm31.png storm31_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm32.png storm32_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm33.png storm33_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm34.png storm34_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm35.png storm35_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm36.png storm36_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm37.png storm37_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm38.png storm38_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm40.png storm40_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm41.png storm41_rle >> lightning_lz4.inc
#	$(PNG2LZ4) asm storm42.png storm42_rle >> lightning_lz4.inc




#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa

