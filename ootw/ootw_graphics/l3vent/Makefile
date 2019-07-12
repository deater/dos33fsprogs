include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c3_vent.inc

#####

ootw_c3_vent.inc:	$(PNG2RLE) \
	vent.png
	$(PNG2RLE) asm vent.png vent_rle > ootw_c3_vent.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

