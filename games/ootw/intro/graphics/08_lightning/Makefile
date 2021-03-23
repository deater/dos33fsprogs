include ../../../../../Makefile.inc

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

clean:		
		rm -f *~ *.inc *.gr *.lzsa

