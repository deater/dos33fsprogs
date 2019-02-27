include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_gone.inc

#####

intro_gone.inc:	$(PNG2RLE) \
	intro_gone.png
	$(PNG2RLE) asm intro_gone.png gone_rle > intro_gone.inc


#####

clean:		
		rm -f *~ *.inc

