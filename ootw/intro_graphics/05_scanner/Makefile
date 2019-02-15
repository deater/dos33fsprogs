include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_scanner.inc intro_scanning.inc intro_ai_bg.inc intro_ai.inc

#####

intro_ai_bg.inc:	$(PNG2RLE) ai_background.png
	$(PNG2RLE) asm ai_background.png ai_bg_rle > intro_ai_bg.inc

#####

intro_ai.inc:	$(PNG2RLE) ai01.png ai02.png ai03.png ai04.png ai05.png \
	static01.png static02.png static03.png
	$(PNG2RLE) asm ai01.png ai01_rle > intro_ai.inc
	$(PNG2RLE) asm ai02.png ai02_rle >> intro_ai.inc
	$(PNG2RLE) asm ai03.png ai03_rle >> intro_ai.inc
	$(PNG2RLE) asm ai04.png ai04_rle >> intro_ai.inc
	$(PNG2RLE) asm ai05.png ai05_rle >> intro_ai.inc
	$(PNG2RLE) asm static01.png static01_rle >> intro_ai.inc
	$(PNG2RLE) asm static02.png static02_rle >> intro_ai.inc
	$(PNG2RLE) asm static03.png static03_rle >> intro_ai.inc




#####

intro_scanner.inc:	$(PNG2RLE) intro_scanner.png
	$(PNG2RLE) asm intro_scanner.png scanner_rle > intro_scanner.inc

#####

intro_scanning.inc:	$(PNG2RLE) \
	scan01.png scan02.png scan03.png \
	scan04.png scan05.png scan06.png \
	scan07.png scan08.png scan09.png \
	scan10.png scan11.png scan12.png \
	scan13.png scan14.png scan15.png \
	scan16.png scan17.png scan18.png \
	scan19.png
	$(PNG2RLE) asm scan01.png scan01_rle > intro_scanning.inc
	$(PNG2RLE) asm scan02.png scan02_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan03.png scan03_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan04.png scan04_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan05.png scan05_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan06.png scan06_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan07.png scan07_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan08.png scan08_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan09.png scan09_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan10.png scan10_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan11.png scan11_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan12.png scan12_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan13.png scan13_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan14.png scan14_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan15.png scan15_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan16.png scan16_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan17.png scan17_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan18.png scan18_rle >> intro_scanning.inc
	$(PNG2RLE) asm scan19.png scan19_rle >> intro_scanning.inc


clean:		
		rm -f *~ *.inc
