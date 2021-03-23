include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c4_city.inc

#####

ootw_c4_city.inc:	\
	recharge.lzsa hallway.lzsa causeway1.lzsa causeway2.lzsa pit.lzsa
	echo "recharge_lzsa: .incbin \"recharge.lzsa\"" > ootw_c4_city.inc
	echo "hallway_lzsa: .incbin \"hallway.lzsa\"" >> ootw_c4_city.inc
	echo "causeway1_lzsa: .incbin \"causeway1.lzsa\"" >> ootw_c4_city.inc
	echo "causeway2_lzsa: .incbin \"causeway2.lzsa\"" >> ootw_c4_city.inc
	echo "pit_lzsa: .incbin \"pit.lzsa\"" >> ootw_c4_city.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.inc

