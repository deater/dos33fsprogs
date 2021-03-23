include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_rope.inc ootw_swing.inc

#####

ootw_rope.inc:	$(PNG2RLE) another_rope.png another_norope.png
	$(PNG2RLE) asm another_rope.png rope_rle > ootw_rope.inc
	$(PNG2RLE) asm another_norope.png no_rope_rle >> ootw_rope.inc
	$(PNG2RLE) asm another_brokerope.png broke_rope_rle >> ootw_rope.inc


#####

ootw_swing.inc:	$(PNG2RLE) \
	another_swing01.png another_swing02.png another_swing03.png \
	another_swing04.png another_swing05.png another_swing06.png \
	another_swing08.png \
	another_swing10.png another_swing11.png another_swing12.png \
	another_swing13.png another_swing14.png another_swing15.png \
	another_swing16.png another_swing17.png another_swing18.png \
	another_swing19.png another_swing20.png another_swing21.png \
	another_swing22.png another_swing23.png another_swing24.png \
	another_swing25.png
	$(PNG2RLE) asm another_swing01.png swing01_rle > ootw_swing.inc
	$(PNG2RLE) asm another_swing02.png swing02_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing03.png swing03_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing04.png swing04_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing05.png swing05_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing06.png swing06_rle >> ootw_swing.inc
#	$(PNG2RLE) asm another_swing07.png swing07_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing08.png swing08_rle >> ootw_swing.inc
#	$(PNG2RLE) asm another_swing09.png swing09_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing10.png swing10_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing11.png swing11_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing12.png swing12_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing13.png swing13_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing14.png swing14_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing15.png swing15_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing16.png swing16_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing17.png swing17_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing18.png swing18_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing19.png swing19_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing20.png swing20_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing21.png swing21_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing22.png swing22_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing23.png swing23_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing24.png swing24_rle >> ootw_swing.inc
	$(PNG2RLE) asm another_swing25.png swing25_rle >> ootw_swing.inc



#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

