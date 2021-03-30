include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c12_room.inc

#####

ootw_c12_room.inc:	\
	house.lzsa
	echo "house_lzsa: .incbin \"house.lzsa\"" > ootw_c12_room.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc

