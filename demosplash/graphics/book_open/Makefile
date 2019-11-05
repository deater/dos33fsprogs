include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	book_open.inc

#####

book_open.inc:	$(PNG2RLE) \
	book00.png book01.png book02.png book03.png book04.png book05.png \
	book06.png book07.png book08.png book09.png book10.png
	$(PNG2RLE) asm book00.png book00_rle > book_open.inc
	$(PNG2RLE) asm book01.png book01_rle >> book_open.inc
	$(PNG2RLE) asm book02.png book02_rle >> book_open.inc
	$(PNG2RLE) asm book03.png book03_rle >> book_open.inc
	$(PNG2RLE) asm book04.png book04_rle >> book_open.inc
	$(PNG2RLE) asm book05.png book05_rle >> book_open.inc
	$(PNG2RLE) asm book06.png book06_rle >> book_open.inc
	$(PNG2RLE) asm book07.png book07_rle >> book_open.inc
	$(PNG2RLE) asm book08.png book08_rle >> book_open.inc
	$(PNG2RLE) asm book09.png book09_rle >> book_open.inc
	$(PNG2RLE) asm book10.png book10_rle >> book_open.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

