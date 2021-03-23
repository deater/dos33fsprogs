include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4
PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	intro_scanner.inc intro_scanning.inc intro_ai_bg.inc intro_ai.inc


#####

intro_ai_bg.inc:	ai_background.lzsa
	echo "ai_bg_lzsa: .incbin \"ai_background.lzsa\"" > intro_ai_bg.inc

#####

intro_ai.inc:	ai01.lzsa ai02.lzsa ai03.lzsa ai04.lzsa ai05.lzsa \
	static01.lzsa static02.lzsa static03.lzsa
	echo "ai01_lzsa: .incbin \"ai01.lzsa\"" > intro_ai.inc
	echo "ai02_lzsa: .incbin \"ai02.lzsa\"" >> intro_ai.inc
	echo "ai03_lzsa: .incbin \"ai03.lzsa\"" >> intro_ai.inc
	echo "ai04_lzsa: .incbin \"ai04.lzsa\"" >> intro_ai.inc
	echo "ai05_lzsa: .incbin \"ai05.lzsa\"" >> intro_ai.inc
	echo "static01_lzsa: .incbin \"static01.lzsa\"" >> intro_ai.inc
	echo "static02_lzsa: .incbin \"static02.lzsa\"" >> intro_ai.inc
	echo "static03_lzsa: .incbin \"static03.lzsa\"" >> intro_ai.inc

#####

intro_scanner.inc:	intro_scanner.lzsa
	echo "intro_scanner_lzsa: .incbin \"intro_scanner.lzsa\"" > intro_scanner.inc

#####

intro_scanning.inc:	\
	scan01.lzsa scan02.lzsa scan03.lzsa \
	scan04.lzsa scan05.lzsa scan06.lzsa \
	scan07.lzsa scan08.lzsa scan09.lzsa \
	scan10.lzsa scan11.lzsa scan12.lzsa \
	scan13.lzsa scan14.lzsa scan15.lzsa \
	scan16.lzsa scan17.lzsa scan18.lzsa \
	scan19.lzsa
	echo "scan01_lzsa: .incbin \"scan01.lzsa\"" > intro_scanning.inc
	echo "scan02_lzsa: .incbin \"scan02.lzsa\"" >> intro_scanning.inc
	echo "scan03_lzsa: .incbin \"scan03.lzsa\"" >> intro_scanning.inc
	echo "scan04_lzsa: .incbin \"scan04.lzsa\"" >> intro_scanning.inc
	echo "scan05_lzsa: .incbin \"scan05.lzsa\"" >> intro_scanning.inc
	echo "scan06_lzsa: .incbin \"scan06.lzsa\"" >> intro_scanning.inc
	echo "scan07_lzsa: .incbin \"scan07.lzsa\"" >> intro_scanning.inc
	echo "scan08_lzsa: .incbin \"scan08.lzsa\"" >> intro_scanning.inc
	echo "scan09_lzsa: .incbin \"scan09.lzsa\"" >> intro_scanning.inc
	echo "scan10_lzsa: .incbin \"scan10.lzsa\"" >> intro_scanning.inc
	echo "scan11_lzsa: .incbin \"scan11.lzsa\"" >> intro_scanning.inc
	echo "scan12_lzsa: .incbin \"scan12.lzsa\"" >> intro_scanning.inc
	echo "scan13_lzsa: .incbin \"scan13.lzsa\"" >> intro_scanning.inc
	echo "scan14_lzsa: .incbin \"scan14.lzsa\"" >> intro_scanning.inc
	echo "scan15_lzsa: .incbin \"scan15.lzsa\"" >> intro_scanning.inc
	echo "scan16_lzsa: .incbin \"scan16.lzsa\"" >> intro_scanning.inc
	echo "scan17_lzsa: .incbin \"scan17.lzsa\"" >> intro_scanning.inc
	echo "scan18_lzsa: .incbin \"scan18.lzsa\"" >> intro_scanning.inc
	echo "scan19_lzsa: .incbin \"scan19.lzsa\"" >> intro_scanning.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


#####
#
#intro_ai_bg.inc:	$(PNG2RLE) ai_background.png
#	$(PNG2RLE) asm ai_background.png ai_bg_rle > intro_ai_bg.inc

#####

#intro_ai.inc:	$(PNG2RLE) ai01.png ai02.png ai03.png ai04.png ai05.png \
#	static01.png static02.png static03.png
#	$(PNG2RLE) asm ai01.png ai01_rle > intro_ai.inc
#	$(PNG2RLE) asm ai02.png ai02_rle >> intro_ai.inc
#	$(PNG2RLE) asm ai03.png ai03_rle >> intro_ai.inc
#	$(PNG2RLE) asm ai04.png ai04_rle >> intro_ai.inc
#	$(PNG2RLE) asm ai05.png ai05_rle >> intro_ai.inc
#	$(PNG2RLE) asm static01.png static01_rle >> intro_ai.inc
#	$(PNG2RLE) asm static02.png static02_rle >> intro_ai.inc
#	$(PNG2RLE) asm static03.png static03_rle >> intro_ai.inc




#####

#intro_scanner.inc:	$(PNG2RLE) intro_scanner.png
#	$(PNG2RLE) asm intro_scanner.png scanner_rle > intro_scanner.inc

#####

#intro_scanning.inc:	$(PNG2RLE) \
#	scan01.png scan02.png scan03.png \
#	scan04.png scan05.png scan06.png \
#	scan07.png scan08.png scan09.png \
#	scan10.png scan11.png scan12.png \
#	scan13.png scan14.png scan15.png \
#	scan16.png scan17.png scan18.png \
#	scan19.png
#	$(PNG2RLE) asm scan01.png scan01_rle > intro_scanning.inc
#	$(PNG2RLE) asm scan02.png scan02_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan03.png scan03_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan04.png scan04_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan05.png scan05_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan06.png scan06_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan07.png scan07_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan08.png scan08_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan09.png scan09_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan10.png scan10_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan11.png scan11_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan12.png scan12_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan13.png scan13_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan14.png scan14_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan15.png scan15_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan16.png scan16_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan17.png scan17_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan18.png scan18_rle >> intro_scanning.inc
#	$(PNG2RLE) asm scan19.png scan19_rle >> intro_scanning.inc

#####
#####


#intro_ai_bg_lz4.inc:	$(PNG2LZ4) ai_background.png
#	$(PNG2LZ4) asm ai_background.png ai_bg_rle > intro_ai_bg_lz4.inc

#####

#intro_ai_lz4.inc:	$(PNG2LZ4) ai01.png ai02.png ai03.png ai04.png ai05.png \
#	static01.png static02.png static03.png
#	$(PNG2LZ4) asm ai01.png ai01_rle > intro_ai_lz4.inc
#	$(PNG2LZ4) asm ai02.png ai02_rle >> intro_ai_lz4.inc
#	$(PNG2LZ4) asm ai03.png ai03_rle >> intro_ai_lz4.inc
#	$(PNG2LZ4) asm ai04.png ai04_rle >> intro_ai_lz4.inc
#	$(PNG2LZ4) asm ai05.png ai05_rle >> intro_ai_lz4.inc
#	$(PNG2LZ4) asm static01.png static01_rle >> intro_ai_lz4.inc
#	$(PNG2LZ4) asm static02.png static02_rle >> intro_ai_lz4.inc
#	$(PNG2LZ4) asm static03.png static03_rle >> intro_ai_lz4.inc




#####
#
#intro_scanner_lz4.inc:	$(PNG2LZ4) intro_scanner.png
#	$(PNG2LZ4) asm intro_scanner.png scanner_rle > intro_scanner_lz4.inc

#####

#intro_scanning_lz4.inc:	$(PNG2LZ4) \
#	scan01.png scan02.png scan03.png \
#	scan04.png scan05.png scan06.png \
#	scan07.png scan08.png scan09.png \
#	scan10.png scan11.png scan12.png \
#	scan13.png scan14.png scan15.png \
#	scan16.png scan17.png scan18.png \
#	scan19.png
#	$(PNG2LZ4) asm scan01.png scan01_rle > intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan02.png scan02_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan03.png scan03_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan04.png scan04_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan05.png scan05_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan06.png scan06_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan07.png scan07_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan08.png scan08_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan09.png scan09_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan10.png scan10_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan11.png scan11_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan12.png scan12_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan13.png scan13_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan14.png scan14_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan15.png scan15_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan16.png scan16_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan17.png scan17_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan18.png scan18_rle >> intro_scanning_lz4.inc
#	$(PNG2LZ4) asm scan19.png scan19_rle >> intro_scanning_lz4.inc


clean:		
		rm -f *~ *.inc *.lzsa *.gr
