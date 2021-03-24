include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c8_crawl.inc

#####

ootw_c8_crawl.inc:	$(PNG2RLE) \
	entry.png
	$(PNG2RLE) asm entry.png entry_rle > ootw_c8_crawl.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

