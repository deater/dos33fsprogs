include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c13_room.inc

#####

ootw_c13_room.inc:	$(PNG2RLE) \
	entry.png
	$(PNG2RLE) asm entry.png entry_rle > ootw_c13_room.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

