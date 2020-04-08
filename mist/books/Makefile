#include ../Makefile.inc

PNG2RLE = ../../gr-utils/png2rle
PNG2GR = ../../gr-utils/png2gr
TEXT2GR = ../../gr-utils/text2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	octagon_books.inc


####

octagon_books.inc:	\
	channelwood.lzsa stoneship.lzsa mechanical.lzsa selenitic.lzsa
	echo "channelwood_book_lzsa: .incbin \"channelwood.lzsa\"" > octagon_books.inc
	echo "stoneship_book_lzsa: .incbin \"stoneship.lzsa\"" >> octagon_books.inc
	echo "mechanical_book_lzsa: .incbin \"mechanical.lzsa\"" >> octagon_books.inc
	echo "selenitic_book_lzsa: .incbin \"selenitic.lzsa\"" >> octagon_books.inc


%.gr: %.book
	$(TEXT2GR) -i $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
		rm -f *~ *.o *.lst *.gr *.lzsa octagon_books.inc
