include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c12_room.inc

#####

ootw_c12_room.inc:	$(PNG2RLE) \
	house.png
	$(PNG2RLE) asm house.png house_rle > ootw_c12_room.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

