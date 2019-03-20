include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_l2intro.inc

#####

ootw_l2intro.inc:	$(PNG2RLE) \
	cage_01.png cage_02.png cage_03.png cage_04.png \
	eyes_bg.png eyes_01.png eyes_02.png eyes_03.png \
	eyes_04.png eyes_05.png \
	friend02.png friend03.png friend04.png friend05.png friend06.png
	$(PNG2RLE) asm cage_01.png cage_01_rle > ootw_l2intro.inc
	$(PNG2RLE) asm cage_02.png cage_02_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm cage_03.png cage_03_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm cage_04.png cage_04_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm eyes_bg.png eyes_bg_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm eyes_01.png eyes_01_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm eyes_02.png eyes_02_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm eyes_03.png eyes_03_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm eyes_04.png eyes_04_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm eyes_05.png eyes_05_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm friend02.png friend_02_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm friend03.png friend_03_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm friend04.png friend_04_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm friend05.png friend_05_rle >> ootw_l2intro.inc
	$(PNG2RLE) asm friend06.png friend_06_rle >> ootw_l2intro.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

