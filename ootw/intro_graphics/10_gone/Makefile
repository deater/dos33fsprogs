include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4


all:	intro_zappo.inc intro_gone.inc intro_zappo_lz4.inc

#####

intro_zappo.inc:	$(PNG2RLE) \
	blue_zappo.png \
	zappo01.png zappo02.png zappo03.png zappo04.png \
	zappo05.png zappo06.png zappo07.png zappo08.png \
	zappo09.png zappo10.png zappo11.png zappo12.png \
	zappo13.png zappo14.png zappo15.png zappo16.png \
	zappo17.png
	$(PNG2RLE) asm blue_zappo.png blue_zappo_rle > intro_zappo.inc
	$(PNG2RLE) asm zappo01.png zappo01_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo02.png zappo02_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo03.png zappo03_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo04.png zappo04_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo05.png zappo05_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo06.png zappo06_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo07.png zappo07_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo08.png zappo08_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo09.png zappo09_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo10.png zappo10_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo11.png zappo11_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo12.png zappo12_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo13.png zappo13_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo14.png zappo14_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo15.png zappo15_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo16.png zappo16_rle >> intro_zappo.inc
	$(PNG2RLE) asm zappo17.png zappo17_rle >> intro_zappo.inc


intro_zappo_lz4.inc:	$(PNG2LZ4) \
	blue_zappo.png \
	zappo01.png zappo02.png zappo03.png zappo04.png \
	zappo05.png zappo06.png zappo07.png zappo08.png \
	zappo09.png zappo10.png zappo11.png zappo12.png \
	zappo13.png zappo14.png zappo15.png zappo16.png \
	zappo17.png
	$(PNG2LZ4) asm blue_zappo.png blue_zappo_rle > intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo01.png zappo01_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo02.png zappo02_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo03.png zappo03_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo04.png zappo04_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo05.png zappo05_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo06.png zappo06_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo07.png zappo07_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo08.png zappo08_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo09.png zappo09_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo10.png zappo10_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo11.png zappo11_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo12.png zappo12_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo13.png zappo13_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo14.png zappo14_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo15.png zappo15_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo16.png zappo16_rle >> intro_zappo_lz4.inc
	$(PNG2LZ4) asm zappo17.png zappo17_rle >> intro_zappo_lz4.inc


#####

intro_gone.inc:	$(PNG2RLE) \
	intro_gone.png
	$(PNG2RLE) asm intro_gone.png gone_rle > intro_gone.inc


#####

clean:		
		rm -f *~ *.inc

