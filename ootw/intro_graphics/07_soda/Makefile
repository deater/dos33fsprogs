include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_open_soda.inc intro_drinking.inc

#####

intro_open_soda.inc:	$(PNG2RLE) soda_bg.png \
		soda01.png soda02.png soda03.png \
		soda04.png soda05.png soda06.png \
		soda07.png soda08.png soda09.png
	$(PNG2RLE) asm soda_bg.png soda_bg_rle > intro_open_soda.inc
	$(PNG2RLE) asm soda01.png soda01_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda02.png soda02_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda03.png soda03_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda04.png soda04_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda05.png soda05_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda06.png soda06_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda07.png soda07_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda08.png soda08_rle >> intro_open_soda.inc
	$(PNG2RLE) asm soda09.png soda09_rle >> intro_open_soda.inc

#####


intro_drinking.inc:	$(PNG2RLE) intro_drinking.png
	$(PNG2RLE) asm intro_drinking.png drinking_rle > intro_drinking.inc

#####

#intro_cursor.inc:	$(PNG2RLE) desktop_bg.png \
#	cursor01.png cursor02.png cursor03.png cursor04.png \
#	cursor05.png cursor06.png cursor07.png cursor08.png
#	$(PNG2RLE) asm desktop_bg.png desktop_bg_rle > intro_cursor.inc
#	$(PNG2RLE) asm cursor01.png cursor01_rle >> intro_cursor.inc

clean:		
		rm -f *~ *.inc
