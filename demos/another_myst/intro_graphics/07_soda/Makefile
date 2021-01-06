include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4


all:	intro_open_soda.inc intro_drinking.inc \
	intro_open_soda_lz4.inc intro_drinking_lz4.inc

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


intro_drinking.inc:	$(PNG2RLE) \
	drinking02.png drinking03.png drinking04.png drinking05.png
	$(PNG2RLE) asm drinking02.png drinking02_rle >> intro_drinking.inc
	$(PNG2RLE) asm drinking03.png drinking03_rle >> intro_drinking.inc
	$(PNG2RLE) asm drinking04.png drinking04_rle >> intro_drinking.inc
	$(PNG2RLE) asm drinking05.png drinking05_rle >> intro_drinking.inc

#####

intro_open_soda_lz4.inc:	$(PNG2LZ4) soda_bg.png \
		soda01.png soda02.png soda03.png \
		soda04.png soda05.png soda06.png \
		soda07.png soda08.png soda09.png
	$(PNG2LZ4) asm soda_bg.png soda_bg_rle > intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda01.png soda01_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda02.png soda02_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda03.png soda03_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda04.png soda04_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda05.png soda05_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda06.png soda06_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda07.png soda07_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda08.png soda08_rle >> intro_open_soda_lz4.inc
	$(PNG2LZ4) asm soda09.png soda09_rle >> intro_open_soda_lz4.inc

#####


intro_drinking_lz4.inc:	$(PNG2LZ4) \
	drinking02.png drinking03.png drinking04.png drinking05.png
	$(PNG2LZ4) asm drinking02.png drinking02_rle >> intro_drinking_lz4.inc
	$(PNG2LZ4) asm drinking03.png drinking03_rle >> intro_drinking_lz4.inc
	$(PNG2LZ4) asm drinking04.png drinking04_rle >> intro_drinking_lz4.inc
	$(PNG2LZ4) asm drinking05.png drinking05_rle >> intro_drinking_lz4.inc


#####

clean:		
		rm -f *~ *.inc
