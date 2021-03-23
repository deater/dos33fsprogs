include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c11_room.inc

#####

ootw_c11_room.inc:	$(PNG2RLE) \
	above.png
	$(PNG2RLE) asm above.png above_rle > ootw_c11_room.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

