include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c8_crawl.inc

#####

ootw_c8_crawl.inc:	$(PNG2RLE) \
	entry.png
	$(PNG2RLE) asm entry.png entry_rle > ootw_c8_crawl.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

