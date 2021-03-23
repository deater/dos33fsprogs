include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4
PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	intro_open_soda.inc intro_drinking.inc


#####

intro_open_soda.inc:	soda_bg.lzsa \
		soda01.lzsa soda02.lzsa soda03.lzsa \
		soda04.lzsa soda05.lzsa soda06.lzsa \
		soda07.lzsa soda08.lzsa soda09.lzsa
	echo "soda_bg_lzsa: .incbin \"soda_bg.lzsa\"" > intro_open_soda.inc
	echo "soda01_lzsa: .incbin \"soda01.lzsa\"" >> intro_open_soda.inc
	echo "soda02_lzsa: .incbin \"soda02.lzsa\"" >> intro_open_soda.inc
	echo "soda03_lzsa: .incbin \"soda03.lzsa\"" >> intro_open_soda.inc
	echo "soda04_lzsa: .incbin \"soda04.lzsa\"" >> intro_open_soda.inc
	echo "soda05_lzsa: .incbin \"soda05.lzsa\"" >> intro_open_soda.inc
	echo "soda06_lzsa: .incbin \"soda06.lzsa\"" >> intro_open_soda.inc
	echo "soda07_lzsa: .incbin \"soda07.lzsa\"" >> intro_open_soda.inc
	echo "soda08_lzsa: .incbin \"soda08.lzsa\"" >> intro_open_soda.inc
	echo "soda09_lzsa: .incbin \"soda09.lzsa\"" >> intro_open_soda.inc

#####


intro_drinking.inc:	\
	drinking02.lzsa drinking03.lzsa drinking04.lzsa drinking05.lzsa
	echo "drinking02_lzsa: .incbin \"drinking02.lzsa\"" > intro_drinking.inc
	echo "drinking03_lzsa: .incbin \"drinking03.lzsa\"" >> intro_drinking.inc
	echo "drinking04_lzsa: .incbin \"drinking04.lzsa\"" >> intro_drinking.inc
	echo "drinking05_lzsa: .incbin \"drinking05.lzsa\"" >> intro_drinking.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@



#intro_open_soda.inc:	$(PNG2RLE) soda_bg.png \
#		soda01.png soda02.png soda03.png \
#		soda04.png soda05.png soda06.png \
#		soda07.png soda08.png soda09.png
#	$(PNG2RLE) asm soda_bg.png soda_bg_rle > intro_open_soda.inc
#	$(PNG2RLE) asm soda01.png soda01_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda02.png soda02_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda03.png soda03_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda04.png soda04_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda05.png soda05_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda06.png soda06_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda07.png soda07_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda08.png soda08_rle >> intro_open_soda.inc
#	$(PNG2RLE) asm soda09.png soda09_rle >> intro_open_soda.inc

#####


#intro_drinking.inc:	$(PNG2RLE) \
#	drinking02.png drinking03.png drinking04.png drinking05.png
#	$(PNG2RLE) asm drinking02.png drinking02_rle >> intro_drinking.inc
#	$(PNG2RLE) asm drinking03.png drinking03_rle >> intro_drinking.inc
#	$(PNG2RLE) asm drinking04.png drinking04_rle >> intro_drinking.inc
#	$(PNG2RLE) asm drinking05.png drinking05_rle >> intro_drinking.inc


#####

#intro_open_soda_lz4.inc:	$(PNG2LZ4) soda_bg.png \
#		soda01.png soda02.png soda03.png \
#		soda04.png soda05.png soda06.png \
#		soda07.png soda08.png soda09.png
#	$(PNG2LZ4) asm soda_bg.png soda_bg_rle > intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda01.png soda01_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda02.png soda02_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda03.png soda03_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda04.png soda04_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda05.png soda05_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda06.png soda06_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda07.png soda07_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda08.png soda08_rle >> intro_open_soda_lz4.inc
#	$(PNG2LZ4) asm soda09.png soda09_rle >> intro_open_soda_lz4.inc

#####


#intro_drinking_lz4.inc:	$(PNG2LZ4) \
#	drinking02.png drinking03.png drinking04.png drinking05.png
#	$(PNG2LZ4) asm drinking02.png drinking02_rle >> intro_drinking_lz4.inc
#	$(PNG2LZ4) asm drinking03.png drinking03_rle >> intro_drinking_lz4.inc
#	$(PNG2LZ4) asm drinking04.png drinking04_rle >> intro_drinking_lz4.inc
#	$(PNG2LZ4) asm drinking05.png drinking05_rle >> intro_drinking_lz4.inc


#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
