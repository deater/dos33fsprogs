include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_scanner.inc

#####

intro_scanner.inc:	$(PNG2RLE) intro_scanner.png
	$(PNG2RLE) asm intro_scanner.png scanner_rle > intro_scanner.inc

#####


clean:		
		rm -f *~ *.inc
