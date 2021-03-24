include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c11_room.inc

#####

ootw_c11_room.inc:	$(PNG2RLE) \
	above.png
	$(PNG2RLE) asm above.png above_rle > ootw_c11_room.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

