include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_open_soda.inc intro_drinking.inc

#####

intro_open_soda.inc:	$(PNG2RLE) intro_open_soda.png
	$(PNG2RLE) asm intro_open_soda.png open_soda_rle > intro_open_soda.inc

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
