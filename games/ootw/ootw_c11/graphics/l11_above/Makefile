include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c11_room.inc

#####

ootw_c11_room.inc:	\
	above.lzsa
	echo "above_lzsa: .incbin \"above.lzsa\"" > ootw_c11_room.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

