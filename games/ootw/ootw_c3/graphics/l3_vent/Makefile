include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c3_vent.inc

#####

ootw_c3_vent.inc:	vent.lzsa
	echo "vent_lzsa: .incbin \"vent.lzsa\"" > ootw_c3_vent.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr

