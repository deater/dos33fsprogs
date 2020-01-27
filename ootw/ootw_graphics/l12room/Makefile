include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c12_room.inc

#####

ootw_c12_room.inc:	$(PNG2RLE) \
	house.png
	$(PNG2RLE) asm house.png house_rle > ootw_c12_room.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

